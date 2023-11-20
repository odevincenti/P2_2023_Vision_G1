function dice = find_dice(im, imon)

%% Busco centroide
imblack=imon>0.9;         % Aplico threshold que vuelve casi todo negro
% idisp(imblack)
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000])  % Busco blobs negros de area parecida al d20
% f.plot_box('g')  % put a green bounding box on each blob
% f.plot_centroid('o');  % put a circle+cross on the centroid of each blob
% f.plot_centroid('x');

% Recorto dado
imfoc=im(f.vmin+20:f.vmax-20, f.umin+20:f.umax-20);
% idisp(imfoc)

%% Completo espacios vacios
%ithresh(imfoc)
imth=imfoc>0.28;
imfull = iclose(imth, kcircle(3.5));
imfull = iclose(imfull, ones(5, 5));
% idisp(imfull)

%% Detecto lineas
%imth=imfoc>0.27;
%imth = imfoc;
edges = icanny(imfull);
% idisp(edges)
h = Hough(edges, 'houghthresh', 0.6, 'suppress', 5);
lines = h.lines();

% idisp(imfull, 'dark');

lines = lines.seglength(edges);
k = find( lines.length > 25 & lines.length <= 60);

% lines(k).plot('b--')
% lines(k)

% Suprimo lineas segun angulo
filtered_lines = filter_lines(lines(k))
% filtered_lines.plot('b--')

%% Chequeo triangulos
tri_lines = find_triangle(filtered_lines)
% idisp(imfull, 'dark');
% tri_lines.plot('b--')

dice = imcorr;
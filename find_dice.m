function dice = find_dice(im, imon)

%% Busco centroide
imblack=imon>0.9;         % Aplico threshold que vuelve casi todo negro
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000]);  % Busco blobs negros de area parecida al d20
% idisp(imblack)
% f.plot_box('g')  % put a green bounding box on each blob
% f.plot_centroid('o');  % put a circle+cross on the centroid of each blob
% f.plot_centroid('x');

%% Recorto dado
imfoc=im(f.vmin+20:f.vmax-20, f.umin+20:f.umax-20);
% idisp(imfoc)

%% Completo espacios vacios
%ithresh(imfoc)
imth=imfoc>0.28;
imfull = iclose(imth, kcircle(3.5));
imfull = iclose(imfull, ones(5, 5));
% idisp(imfull)

%% Detecto l�neas
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

%% Suprimo lineas segun angulo
filtered_lines = [];
for line = lines(k)
    append = 1;
    for fline = filtered_lines
        if (line.theta > fline.theta - 0.1 && line.theta < fline.theta + 0.1)
            append = 0;
            break
        end
    end
    if append == 1
        filtered_lines = [filtered_lines, line];
    end
end

% filtered_lines.plot('b--')
% filtered_lines


%% Corrijo orientaci�n
im=im(f.vmin:f.vmax, f.umin:f.umax);
imcorr = irotate(im, filtered_lines(2).theta*180/pi);
% idisp(imcorr)

dice = imcorr;
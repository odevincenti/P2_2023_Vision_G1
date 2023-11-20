%% P2 2023 Automacion Industrial (22.90)
% Grupo 1
% Ignacio Cutignola (59330)
% Olivia De Vincenti (60354)
% Valentino Venier Anache (60097)

clear all
close all
clc

%% Carga de imagen
im=iread('resultado 20.jpg'); 
im=idouble(im);
imon=imono(im);
%ithresh(imon)
% idisp(im)
% stop=input('continuar?');
% close all

% %% Generar ejemplos
% im=iread('template 1.jpg'); 
% im=idouble(im);
% imon=imono(im);
% kgaus=kgauss(0.6);
% im=iconv(im,kgaus);
% imwrite(im, 'resultado 11.jpg')


%% Busco centroide
imblack=imon>0.9;         % Aplico threshold que vuelve casi todo negro
idisp(imblack)
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000])  % Busco blobs negros de area parecida al d20
f.plot_box('g')  % put a green bounding box on each blob
f.plot_centroid('o');  % put a circle+cross on the centroid of each blob
f.plot_centroid('x');

% Recorto dado
imfoc=im(f.vmin+20:f.vmax-20, f.umin+20:f.umax-20);
idisp(imfoc)

%% Completo espacios vacios
%ithresh(imfoc)
imth=imfoc>0.28;
imfull = iclose(imth, kcircle(3.5));
imfull = iclose(imfull, ones(5, 5));
idisp(imfull)

%% Detecto lineas
%imth=imfoc>0.27;
%imth = imfoc;
edges = icanny(imfull);
idisp(edges)
h = Hough(edges, 'houghthresh', 0.6, 'suppress', 5);
lines = h.lines();

idisp(imfull, 'dark');

lines = lines.seglength(edges);
k = find( lines.length > 25 & lines.length <= 60);

% lines(k).plot('b--')
% lines(k)

% Suprimo lineas segun angulo
filtered_lines = filter_lines(lines(k))
filtered_lines.plot('b--')

%% Chequeo triangulos
tri_lines = find_triangle(filtered_lines)
idisp(imfull, 'dark');
tri_lines.plot('b--')

%% Corrijo orientacion
% im=im(f.vmin:f.vmax, f.umin:f.umax);
% imcorr = irotate(im, filtered_lines(3).theta*180/pi);
% idisp(imcorr)

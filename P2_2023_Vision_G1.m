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
idisp(im)

%% Busco centroide
imblack=imon>0.9;         % Aplico threshold que vuelve casi todo negro
% idisp(imblack)
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000])  % Busco blobs negros de area parecida al d20
% f.plot_box('g')  % put a green bounding box on each blob
% f.plot_centroid('o');  % put a circle+cross on the centroid of each blob
% f.plot_centroid('x');

% Recorto tiangulo del dado
imfoc=im(f.vmin+20:f.vmax-20, f.umin+20:f.umax-20);
idisp(imfoc)

%% Completo espacios hasta que quede sólo el triangulo
%ithresh(imfoc)
imth=imfoc>0.28;
imfull = iclose(imth, kcircle(3.5));
imfull = iclose(imfull, ones(5, 5));
idisp(imfull)

%% Detecto lineas
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
filtered_lines.plot('b--')

%% Chequeo triangulos
tri_lines = find_triangle(filtered_lines);
idisp(imfull, 'dark');
tri_lines.plot('b--')
[~, idx] = sort(abs(tri_lines.theta));
tri_lines = tri_lines(idx)
base = tri_lines(1);
if base.rho < 60
    base = tri_lines(2);
end

%% Corrijo orientacion
imm=im(f.vmin:f.vmax, f.umin:f.umax);
vc = (f.vmax - f.vmin)/2;
uc = (f.umax - f.umin)/2;
imrot = irotate(imm, base.theta*180/pi, 'extrapval', 1);
idisp(imrot)

%% Obtengo template de los numeros a evaluar
numbers_template = get_numbers();
% disp(numbers_template)

%% Busco numero
number=0;
max_coincidence = 0;

for i=1:1:3
    %% Corrijo orientacion
    %imm=im(f.vmin:f.vmax, f.umin:f.umax);
    imrot = irotate(imrot, 120, 'extrapval', 1);
    idisp(imrot)
    
    %% Recorto numero
    imfoc=imrot(vc-11:vc+11, uc-11:uc+11); % Tiene que ser 23x23
    idisp(imfoc)
    ithresh(imfoc)
    % [H W] = size(imfoc)

    %% Aplico Threshold
    imth_foc=imfoc>0.45;
    imth_foc = imth_foc*255;
    idisp(imth_foc)

    %%  Busco el numero, tienen que ser los dos Threshold
    [number_aux, coincidence_aux] = find_number(numbers_template, imth_foc)
    if coincidence_aux > max_coincidence
        number = number_aux;
        max_coincidence = coincidence_aux;
    end
        
end

disp(['El valor del dado arrojado es: ', num2str(number)]);

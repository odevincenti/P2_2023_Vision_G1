%% P2 2023 Automacion Industrial (22.90)
% Grupo 1
% Ignacio Cutignola (59330)
% Olivia De Vincenti (60354)
% Valentino Venier Anache (60097)

clear all
close all
clc

%% Carga de imagen
im=iread('resultado 20.jpg');       % Cargamos la imagen
im=idouble(im);                     % La pasamos a doble precision
imon=imono(im);                     % La pasamos a escala de grises
%ithresh(imon)
%idisp(im)

%% Buscamos centroide
imblack=imon>0.9;         % Aplicamos threshold que vuelve todo el dado negro
% idisp(imblack)
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000])  % Buscamos blobs negros de area parecida al d20

% Recortamos triangulo del dado
imfoc=im(f.vmin+20:f.vmax-20, f.umin+20:f.umax-20);
%idisp(imfoc)

%% Rellenamos espacios hasta que las lineas principales sean las del triangulo
%ithresh(imfoc)
imth=imfoc>0.28;
imfull = iclose(imth, kcircle(3.5));
imfull = iclose(imfull, ones(5, 5));
%idisp(imfull)

%% Detecto lineas
edges = icanny(imfull);     % Obtenemos bordes
% idisp(edges)
% Aplicamos transformada de Hough con 60% de votos y promedio de supresion de 5
h = Hough(edges, 'houghthresh', 0.6, 'suppress', 5);
lines = h.lines();          % Extraemos lineas
% idisp(imfull, 'dark');

% Filtramos las lineas que miden entre 25 y 60 ya que entre ellas se
% encuentran los bordes del triangulo principal
lines = lines.seglength(edges);
k = find( lines.length > 25 & lines.length <= 60);
% lines(k).plot('b--')
% lines(k)

% Suprimimos lineas paralelas con un angulo similar
filtered_lines = filter_lines(lines(k));
% filtered_lines.plot('b--')

%% Chequeamos triangulos
% Buscamos un triangulo equilatero entre las lineas filtradas
% Pedimos que en sus intersecciones se formen angulos de 60°
tri_lines = find_triangle(filtered_lines);
% idisp(imfull, 'dark');
% tri_lines.plot('b--')
[~, idx] = sort(abs(tri_lines.theta));  % Ordenamos las lineas
tri_lines = tri_lines(idx)
base = tri_lines(1);    % Determinamos la linea mas horizontal como la base
% Si la linea mas horizontal tiene rho menor que 60 la imagen quedara al reves al girarla
if base.rho < 60        
    base = tri_lines(2);    % En ese caso se toma la segunda linea mas horizontal
end

%% Corrijo orientacion
imm=im(f.vmin:f.vmax, f.umin:f.umax);   % Extraemos el dado completo
vc = (f.vmax - f.vmin)/2;               % Ubicamos su centro
uc = (f.umax - f.umin)/2;
% Giramos la imagen hasta que la base quede horizontal
imrot = irotate(imm, base.theta*180/pi, 'extrapval', 1);
%idisp(imrot)

%% Obtenemos template de los numeros a evaluar
numbers_template = get_numbers();
% disp(numbers_template)

%% Buscamos numero
% Es necesario analizar las 3 posibles orientaciones del dado
number=0;
max_coincidence = 0;

for i=1:1:3
    %% Giramos dado
    %imm=im(f.vmin:f.vmax, f.umin:f.umax);
    imrot = irotate(imrot, 120, 'extrapval', 1);
    %idisp(imrot)
    
    %% Recortamos numero
    imfoc=imrot(vc-11:vc+11, uc-11:uc+11);  % Tiene que ser 23x23
    %idisp(imfoc)
    %[H, W] = size(imfoc)

    %% Aplicamos Threshold
    imth_foc=imfoc>0.45;
    imth_foc = imth_foc*255;
    %idisp(imth_foc)

    %% Buscamos el numero, tienen que ser los dos Threshold
    [number_aux, coincidence_aux] = find_number(numbers_template, imth_foc);
    if coincidence_aux > max_coincidence
        number = number_aux;
        max_coincidence = coincidence_aux;
    end
        
end

% Resultado
disp(['El valor del dado arrojado es: ', num2str(number)]);

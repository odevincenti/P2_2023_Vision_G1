%% P2 2023 Automacion Industrial (22.90)
% Grupo 1
% Ignacio Cutignola (59330)
% Olivia De Vincenti (60354)
% Valentino Venier Anache (60097)


clear all close all clc

%% Carga de imagen
imgrey_d = iread('resultado 2.jpg', 'grey');  

%Tamaño de imagen.
size_img = size(imgrey_d);
fila = size_img(1);
columna = size_img(2);

%% Imagenes de numeros de cada dado
% Se obtiene una lista del template de cada letra
number_array = get_numbers();

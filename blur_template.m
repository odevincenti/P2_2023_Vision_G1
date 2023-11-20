%% Generación de ejemplos
% Se aplica un kernel gaussiano a los templates para que queden ligeramente
% difuminados (como en los ejemplos).
% Luego se extrae y gira un dado elegido usando Paint 3D.
im=iread('template 1.jpg'); 
im=idouble(im);
imon=imono(im);
kgaus=kgauss(0.6);
im=iconv(im,kgaus);
imwrite(im, 'template_2_blur.jpg')
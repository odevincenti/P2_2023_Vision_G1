function dice_number = find_dice_number(dice)


%% Busco nuevamente el centroide nuevamente para pasar el numero
imblack=dice>0.9;         % Aplico threshold que vuelve casi todo negro
% idisp(imblack)
f = iblobs(imblack, 'class', 0, 'area', [10000, 30000]);  % Busco blobs negros de area parecida al d20
% f.plot_box('g')  % put a green bounding box on each blob
% f.plot_centroid('o');  % put a circle+cross on the centroid of each blob
% f.plot_centroid('x');

% Recorto dado
imfoc=dice(f.vc-11:f.vc+11, f.uc-11:f.uc+11); % Tiene que ser 23x23
% idisp(imfoc)
% [H W] = size(imfoc)

%% Aplico Threshold
imth_foc=imfoc>0.31;
imth_foc = imth_foc*255;
% disp(imth_foc)

dice_number = imth_foc;
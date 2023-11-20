function numbers = get_numbers()

%% get_numbers

%   La funcion get_numbers se encarga de analizar los archivos de template1
%   y template2 y obtener a partir de ellos un arreglo de numeros 
%   correspondiente a cada dado

%% Carga de imagen
kgaus=kgauss(0.6);
foto1 = imread('template 1.jpg');
foto1=iconv(foto1,kgaus);
foto2 = imread('template 2.jpg');
foto2=iconv(foto2,kgaus);

%%  Foto1

grey1=imono(foto1);

[H, W] = size(grey1);

nice=200;
value=255/nice;
for i = 1:H
    for j = 1:W
        if(grey1(i,j)< nice)
           grey1(i,j) = uint8(grey1(i,j)*value);
         else
            grey1(i,j) = 255;
        end
    end
end

foto_threashold= grey1.*0;
THRESHOLD=90;
for i = 1:H
    for j = 1:W
        if(grey1(i,j)< THRESHOLD)
           foto_threashold(i,j) = 0;
        else
           foto_threashold(i,j) = 255;
        end
    end
end

% idisp(foto_threashold)

numSize = 22;

%********** NUMEROS **********
% 20
%                       Y     X
Num20 = foto_threashold(90:(90+numSize),85:(85+numSize));
% Num20 = 1 - Num20 ;
% idisp(Num20)

% 19
%                       Y     X
Num19 = foto_threashold(87:(87+numSize),245:(245+numSize));
% idisp(Num19)

% 18
%                       Y     X
Num18 = foto_threashold(96:(96+numSize),415:(415+numSize));
% idisp(Num18)

% 17
%                       Y     X
Num17 = foto_threashold(271:(271+numSize),83:(83+numSize));
% idisp(Num17)

% 16
%                       Y     X
Num16 = foto_threashold(269:(269+numSize),242:(242+numSize));
% idisp(Num16)

% 15
%                       Y     X
Num15 = foto_threashold(94:(94+numSize),580:(580+numSize));
% idisp(Num15)

% 14
%                       Y     X
Num14 = foto_threashold(278:(278+numSize),414:(414+numSize));
% idisp(Num14)

% 13
%                       Y     X
Num13 = foto_threashold(282:(282+numSize),585:(585+numSize));
% idisp(Num13)

% 12
%                       Y     X
Num12 = foto_threashold(86:(86+numSize),749:(749+numSize));
% idisp(Num12)

% 11
%                       Y     X
Num11 = foto_threashold(276:(276+numSize),755:(755+numSize));
% idisp(Num11)


%%  Foto2

grey2=imono(foto2);

[H W] = size(grey1);

nice=200;
value=255/nice;
for i = 1:H
    for j = 1:W
        if(grey2(i,j)< nice)
           grey2(i,j) = uint8(grey2(i,j)*value);
         else
            grey2(i,j) = 255;
        end
    end
end

foto_threashold= grey2.*0;
THRESHOLD=90;
for i = 1:H
    for j = 1:W
        if(grey2(i,j)< THRESHOLD)
           foto_threashold(i,j) = 0;
        else
           foto_threashold(i,j) = 255;
        end
    end
end

% idisp(foto_threashold)


%********** NUMEROS **********
% 10
%                       Y     X
Num10 = foto_threashold(97:(97+numSize),91:(91+numSize));
% idisp(Num10)

% 9
%                       Y     X
Num9 = foto_threashold(95:(95+numSize),264:(264+numSize));
% idisp(Num9)

% 8
%                       Y     X
Num8 = foto_threashold(99:(99+numSize),448:(448+numSize));
% idisp(Num8)

% 7
%                       Y     X
Num7 = foto_threashold(299:(299+numSize),92:(92+numSize));
% idisp(Num7)

% 6
%                       Y     X
Num6 = foto_threashold(305:(305+numSize),267:(267+numSize));
% idisp(Num6)

% 5
%                       Y     X
Num5 = foto_threashold(92:(92+numSize),632:(632+numSize));
% idisp(Num5)

% 4
%                       Y     X
Num4 = foto_threashold(302:(302+numSize),447:(447+numSize));
% idisp(Num4)

% 3
%                       Y     X
Num3 = foto_threashold(287:(287+numSize),636:(636+numSize));
% idisp(Num3)

% 2
%                       Y     X
Num2 = foto_threashold(96:(96+numSize),820:(820+numSize));
% idisp(Num2)

% 1
%                       Y     X
Num1 = foto_threashold(287:(287+numSize),815:(815+numSize));
% idisp(Num1)


numbers = [Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num10, Num11, Num12, Num13, Num14, Num15, Num16, Num17, Num18, Num19, Num20];

% idisp(numbers)



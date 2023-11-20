function [number, coincidence] = find_number(template, number_x)

%Lista de numeros
numeros = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
%N = size(numeros);

coincidence = 0;
vector_coincidence = [];

for aux = 1:23:size(template, 2)
    
    number_to_compare = template(:,aux:min(aux+22, end));
   
   % Recorrer la matriz y comparar cada elemento
    for fila = 1:size(number_x, 1)
        for columna = 1:size(number_x, 2)
            if (number_x(fila, columna) == number_to_compare(fila, columna))
                coincidence =  coincidence + 1;
            end
        end
    end
    
    % Append del nuevo valor al final del vector
    vector_coincidence = [vector_coincidence, coincidence];
    
    coincidence = 0;

end

% Encontrar el valor más alto en la matriz
[coincidence, number] = max(vector_coincidence);


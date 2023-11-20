function tri_lines = find_triangle(filtered_lines)
    tri = [];
    len = size(filtered_lines);
    for i = 1:1:len(2)                  % Iterador 1
        for j = [i+1:1:len(2), 1]       % Iterador 2
            %fprintf('%i, %i', i, j)
            % Obtenemos diferencia entre angulos
            thetadiff = abs(filtered_lines(i).theta - filtered_lines(j).theta);
            % Si el valor esta cerca de 60°, podría ser una esquina del triangulo
            if thetadiff > pi/3*0.9 && thetadiff < pi/3*1.1
                if ~ismember(i, tri)    % Si no guarde la linea 1
                    tri = [tri, i];     % La guardo
                end
                if ~ismember(j, tri)    % Si no guarde la linea 2
                    tri = [tri, j];     % La guardo
                end
                lentri = size(tri);     % Si ya obtuvimos las 3 lineas,
                if lentri(2) == 3       % ya encontramos el triangulo
                    break
                end
            end
        end
    end
    tri_lines = filtered_lines(tri);    % Obtenemos las lineas de los indices
end
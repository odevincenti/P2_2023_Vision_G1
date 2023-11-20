% filter_lines: Filtra lineas paralelas para que quede 1 por angulo
% representativo
function filtered_lines = filter_lines(lines)
    filtered_lines = [];        % Inicializamos arreglo de lineas filtradas
    for line = lines            % Iteramos sobre las lineas
        append = 1;
        for fline = filtered_lines    % Iteramos sobre las lineas guardadas
            % Si los angulos son muy parecidos entre si
            if (line.theta > fline.theta - 0.1 && line.theta < fline.theta + 0.1)
                append = 0;     % La nueva linea no sera guardada
                break
            end
        end
        if append == 1          % Si no encontramos similitud con otra linea
            filtered_lines = [filtered_lines, line];    % Guardamos la linea
        end
    end
end
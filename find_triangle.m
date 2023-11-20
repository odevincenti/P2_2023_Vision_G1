function tri_lines = find_triangle(filtered_lines)
    tri = [];
    len = size(filtered_lines);
    for i = 1:1:len(2)
        for j = [i+1:1:len(2), 1]
            %fprintf('%i, %i', i, j)
            thetadiff = abs(filtered_lines(i).theta - filtered_lines(j).theta);
            if thetadiff > pi/3*0.9 && thetadiff < pi/3*1.1
                if ~ismember(i, tri)
                    tri = [tri, i];
                end
                if ~ismember(j, tri)
                    tri = [tri, j];
                end
                lentri = size(tri);
                if lentri(2) == 3
                    break
                end
            end
        end
    end
    tri_lines = filtered_lines(tri);
end
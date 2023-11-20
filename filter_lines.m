function filtered_lines = filter_lines(lines)
    filtered_lines = [];
    for line = lines
        append = 1;
        for fline = filtered_lines
            if (line.theta > fline.theta - 0.1 && line.theta < fline.theta + 0.1)
                append = 0;
                break
            end
        end
        if append == 1
            filtered_lines = [filtered_lines, line];
        end
    end
end
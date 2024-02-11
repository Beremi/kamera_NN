function latexTable = matrix2latex2(data, rowNames, colNames, rounding, title_table)
    % Check if the number of rounding specifications matches the data columns
    if length(rounding) ~= size(data, 2)
        error('The rounding vector does not match the number of columns in the data matrix.');
    end
    
    % Start the table with the LaTeX tabular environment
    latexTable = "\n \n \\begin{table}[h!]\n\\centering\n\\begin{tabular}{|l";
    for i = 1:length(colNames)-1
        latexTable = strcat(latexTable, "|c");
    end
    latexTable = strcat(latexTable, "|}\n\\hline\n");
    
    % Add column names
    latexTable = strcat(latexTable, colNames{1});
    for i = 2:length(colNames)
        latexTable = strcat(latexTable, " & ", colNames{i});
    end
    latexTable = strcat(latexTable, " \\\\\n\\hline\n");
    
    % Add rows of data
    for i = 1:size(data, 1)
        latexTable = strcat(latexTable, rowNames{i});
        for j = 1:size(data, 2)
            if j <= 2 % Assuming the first two columns require a percentage symbol
                formattedValue = sprintf(['%.' num2str(rounding(j)) 'f\\\\%%%%'], data(i, j));
            else
                formattedValue = sprintf(['%.' num2str(rounding(j)) 'f'], data(i, j));
            end
            latexTable = strcat(latexTable, " & ", formattedValue);
        end
        latexTable = strcat(latexTable, " \\\\\n");
    end
    
    % Close the tabular environment and table
    latexTable = strcat(latexTable, "\\hline\n\\end{tabular}\n\\caption{",title_table,"}\n\\label{your-label-here}\n\\end{table}\n\n\n");
end

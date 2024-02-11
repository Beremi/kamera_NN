function latexTable = matrix2latex(matrix, rowNames, colNames, expsize, rounding)
    % Validate inputs
    [n, m] = size(matrix);
    if length(rowNames) ~= n || length(colNames) ~= m
        error('Size of rowNames or colNames does not match matrix dimensions.');
    end
    
    % Initialize the LaTeX table string with proper line breaks
    latexTable = '\n\n\\begin{table}[ht]\\centering\n\\begin{tabular}{';
    latexTable = [latexTable 'l' repmat('c', 1, m) '} \\hline\n'];
    
    % Column names with line break after
    latexTable = [latexTable ' & ' strjoin(colNames, ' & ') ' \\\\ \\hline\n'];
    
    for i = 1:n
        % Row name
        latexTable = [latexTable num2str(rowNames(i))];
        
        for j = 1:m
            % Scale and round the matrix value
            scaledValue = matrix(i, j) * 10^(-expsize);
            roundedValue = round(scaledValue, rounding);
            
            % Convert number to LaTeX format with trailing zeros
            latexValue = ['$' sprintf(['%.' num2str(rounding) 'f'], roundedValue) ' \\cdot 10^{', num2str(-expsize), '}$'];
            latexTable = [latexTable ' & ' latexValue];
        end
        
        latexTable = [latexTable ' \\\\\n']; % End of row with line break
    end
    
    % Close the LaTeX table string with proper line breaks
    latexTable = [latexTable '\\hline\n\\end{tabular}\n\\caption{Your caption here.}\\label{your-label-here}\n\\end{table}\n\n\n'];
end

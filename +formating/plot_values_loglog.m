function plot_values_loglog(dataMatrix, xValues, legendEntries, xLabel, yLabel, plotTitle)
    % Check the number of datasets
    [nRows, nCols] = size(dataMatrix);
    if nCols > 5
        error('The matrix can have a maximum of 5 columns.');
    end
    
    % Define marker styles to differentiate the datasets
    markers = {'o', 's', 'v', 'd', 'h'}; % Example markers for up to 5 datasets
    
    % Create the figure
    figure;
    hold on; % Keep the plot active to add multiple datasets
    
    % Initialize min and max values for setting limits
    minY = inf;
    maxY = -inf;
    minX = min(xValues);
    maxX = max(xValues);
    
    % Plot each dataset
    for i = 1:nCols
        plot(xValues, dataMatrix(:, i), 'LineStyle', ':', 'LineWidth', 2, ...
             'Marker', markers{i}, 'MarkerSize', 8);
        % Update min and max values
        minY = min(minY, min(dataMatrix(:, i)));
        maxY = max(maxY, max(dataMatrix(:, i)));
    end
    
    % Adjust x and y limits
    xlim([minX*0.8, maxX*1.2]);
    ylim([minY*0.8, maxY*1.2]);
    
    % Set the scales to logarithmic
    set(gca, 'XScale', 'log', 'YScale', 'log');
    
    % Set labels and title with LaTeX interpreter
    xlabel(xLabel, 'FontSize', 15, 'Interpreter', 'latex');
    ylabel(yLabel, 'FontSize', 15, 'Interpreter', 'latex');
    title(plotTitle, 'FontSize', 15, 'Interpreter', 'latex');
    
    % Add legend
    legend(legendEntries, 'FontSize', 15, 'Interpreter', 'latex', 'Location', 'best');
    
    % Set font size for the axes and add grid and box
    set(gca, 'FontSize', 15);
    grid on; % Enable grid
    box on; % Enable box
    
    hold off; % Release the plot
end

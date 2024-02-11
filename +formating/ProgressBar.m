function ProgressBar(currentIteration, totalIterations)
    % Calculate the percentage of completion
    percentageCompleted = (currentIteration / totalIterations) * 100;
    
    % Use a fixed format for the progress message. This will ensure the message
    % length stays constant. You may need to adjust the format if your totalIterations
    % number is very large, to avoid the final percentage exceeding the allocated space.
    progressStr = sprintf('Completed %04.1f%%', percentageCompleted);
    
    % Calculate the number of characters to delete. This is the length of the
    % progress message. Since the format is fixed, this could be simplified, but
    % is left as is for clarity and potential adjustments.
    numCharsToDelete = length(progressStr);
    
    % If it's not the first iteration, delete the previous line using backspace
    % characters. We now have a consistent number of characters to delete.
    if currentIteration > 1
        fprintf(repmat('\b', 1, numCharsToDelete));
    end
    
    % Print the current progress
    fprintf('%s', progressStr);
    
    % When reaching the last iteration, print a newline
    if currentIteration == totalIterations
        fprintf('\n');
    end
end

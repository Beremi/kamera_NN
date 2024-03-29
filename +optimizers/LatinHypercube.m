function samples = LatinHypercube(num_samples, num_dimensions)
    % Preallocate the samples array
    samples = zeros(num_samples, num_dimensions);
    
    % Generate the intervals
    intervals = linspace(-1, 1, num_samples+1);
    
    % Create a Latin Hypercube Sample
    for i = 1:num_dimensions
        % Permute the intervals for the current dimension
        permuted_intervals = intervals(randperm(num_samples));
%         [~,idx] = sort(rand(num_samples,1));
%         permuted_intervals = intervals(idx);
        % Take the midpoints of these intervals to ensure one sample per interval
        samples(:, i) = permuted_intervals(1:num_samples)' + diff(intervals(1:2))/2;
    end
    
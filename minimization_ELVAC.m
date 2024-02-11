function [results] = minimization_ELVAC(options, repeats)

rng(0)

bounds = [50 * 1e-3, 50 * 1e-3, 50 * 1e-3, 20 * pi / 180, 20 * pi / 180, 20 * pi / 180];
nvars = 6;
data = load("ELVAC_measurements.mat");
positions_angles = data.positions_angles;
points_positions = data.points_positions;


datasets = size(positions_angles,1);

iters = zeros(datasets,repeats);
times = zeros(datasets,repeats);
true_errors = zeros(datasets,repeats);
true_errors_pos = zeros(datasets,repeats);
true_errors_angle = zeros(datasets,repeats);


fprintf("sets %d:\n", datasets);
for i = 1:datasets
    
    F = @(x) operators.F_val(x, points_positions(i,:));
    dF = @(x) operators.F_grad(x, points_positions(i,:))';
    ddF = @(x) reshape(operators.F_hess(x, points_positions(i,:))',6,6,size(x,1));

    for j = 1:repeats
        tic;

        switch options.method
            case 'CE'
                [x, it] = optimizers.fmin_CE(F, zeros(1,nvars), diag(bounds.^2), options.sample_size_CE, options.tolerance_CE, options.elite_fraction, options.max_iterations_CE);
            case 'DEvec'
                [x, it] = optimizers.fmin_DEvec(F, bounds, options.beta_min, options.beta_max, options.pCR, options.population_size, options.tolerance_DE, options.max_iterations);
            case 'DEvecNewton'
                [x, it] = optimizers.fmin_DEvecNewton(F, dF, ddF, bounds, options.beta_min, options.beta_max, options.pCR, options.population_size, options.tolerance_DE, options.tolerance_DEgrad, options.max_iterations);
            case 'LHNewton'
                [x, it] = optimizers.fmin_LHNewton(F, dF, ddF, bounds, options.sample_size_LH, options.tolerance, options.max_iterations_newton);
            case 'Newton'
                [x, it] = optimizers.fmin_Newton(F, dF, ddF, bounds, options.tolerance, options.max_iterations_newton);
            case 'Newton_rand'
                [x, it] = optimizers.fmin_Newton_rand(F, dF, ddF, bounds, options.tolerance, options.max_iterations_newton);
            case 'NN'
                [x] = optimizers.fmin_NN(points_positions(i,:), options.model_weights);
                it = 0;
            case 'NNNewton'
                [x, it] = optimizers.fmin_NNNewton(points_positions(i,:), options.model_weights, F, dF, ddF);
            otherwise
                error('Unknown optimization method specified in options.method');
        end


        time = toc;
        iters(i,j) = it;
        times(i, j) = time;
        fval_cur = F(x);
        true_errors(i, j) = fval_cur - F(positions_angles(i,:));

        true_errors_pos(i, j) = norm(x(1:3) - positions_angles(i,1:3));
        true_errors_angle(i, j) = norm(x(4:6) - positions_angles(i,4:6));

        formating.ProgressBar((i-1)*repeats + j, datasets*repeats)
    end
    
end
mask = true_errors(:) > 1e-3;
mask2 = true_errors(:) > 1e-2;

results = [mean(mask2)*100, ...
    mean(mask)*100, ...
    geomean(true_errors_pos(:)), ...
    quantile(true_errors_pos(:),0.999), ...
    geomean(true_errors_angle(:)), ...
    quantile(true_errors_angle(:),0.999), ...
    1000*mean(times(~mask)),...
    1000*quantile(times(~mask),0.999)];

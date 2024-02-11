% Assume F, dF, ddF, bounds, and nvars are defined elsewhere in your script

n_tests = 1000;
repeats = 10;


% common parametes
max_iterations = 1000;
tolerance = 1e-2;

% CE parameters
max_iterations_CE = 1000;
sample_size_CE = 10000;
elite_fraction = 0.002;
tolerance_CE = 1e-7;

%DE params
beta_min = 0.3; % Lower Bound of Scaling Factor
beta_max = 0.7; % Upper Bound of Scaling Factor
pCR = 0.5; % Crossover Probability
population_size = 300;
tolerance_DE = 1e-4;

tolerance_DEgrad = 1e-1;

% LH 
sample_size_LH = 6;
ratio_hess_step = 0.1;
n_newton_steps = 3;
max_iterations_newton = 100;

% pure Newton
maxit_newton = 100;

% Neural Net weights
model_weights = NN_weights.load_NN_weights();

colnames = {'Method', 'Hard fail \\%%', 'Soft fail \\%%', 'mean pos err', ...
    '99.9 \\%% of pos err', 'mean angle err', '99.9 \\%% of angle err', 'mean time','99.9 \\%% of time'};
results_synt = [];
results_ELVAC = [];

% Example of defining options structure
options = struct();
options.method = 'DEvec'; % Change this to switch methods
options.sample_size_CE = sample_size_CE;
options.tolerance_CE = tolerance_CE;
options.elite_fraction = elite_fraction;
options.max_iterations_CE = max_iterations_CE;
options.beta_min = beta_min;
options.beta_max = beta_max;
options.pCR = pCR;
options.population_size = population_size;
options.tolerance_DE = tolerance_DE;
options.max_iterations = max_iterations;
options.tolerance_DEgrad = tolerance_DEgrad;
options.sample_size_LH = sample_size_LH;
options.ratio_hess_step = ratio_hess_step;
options.n_newton_steps = n_newton_steps;
options.tolerance = tolerance;
options.max_iterations_newton = maxit_newton;
options.model_weights = model_weights;


id_test = 1;

%% Newton zero
options.max_iterations_newton = 100;
options.method = 'Newton';
methods_name{id_test} = [options.method];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% Newton rand
options.max_iterations_newton = 100;
options.method = 'Newton_rand';
methods_name{id_test} = [options.method];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% Latin Hypercube + Newton
options.max_iterations_newton = 100;
options.sample_size_LH = 10;
options.method = 'LHNewton';
methods_name{id_test} = [options.method '10'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% Latin Hypercube + Newton
options.max_iterations_newton = 100;
options.sample_size_LH = 100;
options.method = 'LHNewton';
methods_name{id_test} = [options.method '100'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% DE
options.population_size = 200;
options.method = 'DEvec';
methods_name{id_test} = [options.method '200'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% DE
options.population_size = 300;
options.method = 'DEvec';
methods_name{id_test} = [options.method '300'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% DE Newton
options.population_size = 4;
options.method = 'DEvecNewton';
methods_name{id_test} = [options.method '4'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% DE Newton
options.population_size = 16;
options.method = 'DEvecNewton';
methods_name{id_test} = [options.method '16'];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% NN
options.method = 'NN';
methods_name{id_test} = [options.method];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

%% NN Newton
options.method = 'NNNewton';
methods_name{id_test} = [options.method];
fprintf("Solver: %s\n", methods_name{id_test})

[results_synt(id_test,:)] = minimization_synthetic(options, n_tests);
[results_ELVAC(id_test,:)] = minimization_ELVAC(options, repeats);
id_test = id_test + 1;

latexTable = formating.matrix2latex2(results_ELVAC, methods_name, colnames, [4 4 4 4 4 4 2 2], 'Data from real ELVAC testing.');
fprintf(latexTable)
latexTable = formating.matrix2latex2(results_synt, methods_name, colnames, [4 4 4 4 4 4 2 2], 'Synhetic Data.');
fprintf(latexTable)
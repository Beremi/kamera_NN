data = load("ELVAC_measurements.mat");
positions_angles = data.positions_angles;
points_positions = data.points_positions;

rng(0)

datasets = size(positions_angles,1);
bounds = [50 * 1e-3, 50 * 1e-3, 50 * 1e-3, 20 * pi / 180, 20 * pi / 180, 20 * pi / 180];
nvars = 6;

all_times = zeros(5,3);

all_chunks = [1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384, 32768];
% common parametes
ii = 0;
for size_chunk = all_chunks
    ii = ii+1;
    repeats = ceil(1e4/size_chunk)+10;
    times_F = zeros(datasets,1);
    times_dF = zeros(datasets,1);
    times_ddF = zeros(datasets,1);
    for i = 1:datasets
        fprintf("set %d:", i);
        F = @(x) operators.F_val(x, points_positions(i,:));
        dF = @(x) operators.F_grad(x, points_positions(i,:));
        ddF = @(x) operators.F_hess(x, points_positions(i,:));
        x = 2 * (rand(size_chunk, nvars) - 0.5) .* bounds;

        tic;
        for j = 1:repeats
            F(x);
        end
        time = toc;
        times_F(i) = time/repeats;

        tic;
        for j = 1:repeats
            dF(x);    
        end
        time = toc;
        times_dF(i) = time/repeats;

        tic;
        for j = 1:repeats
            ddF(x);
        end
        time = toc;
        times_ddF(i) = time/repeats;
        fprintf("\n");
    end

    all_times(ii,1) = median(times_F(:))/size_chunk;
    all_times(ii,2) = median(times_dF(:))/size_chunk;
    all_times(ii,3) = median(times_ddF(:))/size_chunk;
end

fprintf(formating.matrix2latex(all_times, all_chunks, {'$F$','$\\nabla F$', '$\\nabla^2 F$'}, -7, 2))
formating.plot_values_loglog(all_times, all_chunks, {'$F$','$\nabla F$', '$\nabla^2 F$'}, "Vector size", ...
    "Time per evluation [s]", "Efficiency of vectorized  evaluation of operators");

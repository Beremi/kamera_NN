n = 1e6;

bounds = [50 * 1e-3, 50 * 1e-3, 50 * 1e-3, 20 * pi / 180, 20 * pi / 180, 20 * pi / 180];

synth_x = 2 * (rand(n,6) - 0.5) .* bounds;
synth_y = kamera(synth_x);




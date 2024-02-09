
synth_y_test=synth_y + 5*randn(n,10).*[0.0028, 0.0015, 0.0094, 0.0083, 0.0092,0.0074, 0.0089, 0.0072, 0.0089, 0.0083];


%figure
for model=[4,6,12,13]
    NN_x = kamera_inv_NN(synth_y_test, model );
    NN_y = kamera(NN_x);
    
    hold on
    plot(sort(sum((NN_y - synth_y_test).^2,2)))
    set(gca,"yscale","log")
end

NN_x = kamera_inv2_NN(synth_y_test );
NN_y = kamera(NN_x);

hold on
plot(sort(sum((NN_y - synth_y_test).^2,2)))
set(gca,"yscale","log")
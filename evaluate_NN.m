
load("kamera_mereni.mat")
h5FilePath = 'model_weights4.h5';

% Load the weights and biases from the HDF5 file
weights.fc1 = h5read(h5FilePath, '/fc1.weight');
biases.fc1 = h5read(h5FilePath, '/fc1.bias');
weights.fc2 = h5read(h5FilePath, '/fc2.weight');
biases.fc2 = h5read(h5FilePath, '/fc2.bias');
weights.fc3 = h5read(h5FilePath, '/fc3.weight');
biases.fc3 = h5read(h5FilePath, '/fc3.bias');
weights.fc4 = h5read(h5FilePath, '/fc4.weight');
biases.fc4 = h5read(h5FilePath, '/fc4.bias');
weights.fc5 = h5read(h5FilePath, '/fc8.weight');
biases.fc5 = h5read(h5FilePath, '/fc8.bias');

tic;
% Forward pass, including biases
x = test_y;
x = tanh(x * weights.fc1 + biases.fc1'); % ReLU activation
x = tanh(x * weights.fc2 + biases.fc2'); % ReLU activation
x = tanh(x * weights.fc3 + biases.fc3'); % ReLU activation
x = tanh(x * weights.fc4 + biases.fc4'); % ReLU activation
output = x * weights.fc5 + biases.fc5';

% Transpose output to match expected layout

toc

idx_del = [91, 98, 99, 101] ;
output(idx_del,:) = [];
test_x(idx_del,:) = [];
test_y(idx_del,:) = [];


plot(sum((kamera(test_x) - test_y).^2,2))
set(gca,"yscale","log")
hold on
plot(sum((kamera(output) - test_y).^2,2))



% for i = 1:6
% figure
% plot(output(:,i))
% hold on
% plot(test_x(:,i))
% end
% 
% for i=1:101
% FFF(i) = valF(test_x(i,:), data{i}.S, data{i}.f_presc, data{i}.v, data{i}.n, 309.5 * 1e-3);
% FFFNN(i) = min(FFFNN(i),valF(output(i,:), data{i}.S, data{i}.f_presc, data{i}.v, data{i}.n, 309.5 * 1e-3));
% end
%plot(FFFNN)
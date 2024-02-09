function [output] = kamera_inv_NN(test_y, model)

h5FilePath = "model_weights" + num2str(model) +".h5";

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
end


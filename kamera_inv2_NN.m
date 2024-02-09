function [output] = kamera_inv2_NN(test_y)


h5FilePath = 'model_weights_fmorning.h5';

% Load the weights and biases from the HDF5 file
weights.fc1 = h5read(h5FilePath, '/fc1.weight');
biases.fc1 = h5read(h5FilePath, '/fc1.bias');
weights.fc2 = h5read(h5FilePath, '/fc2.weight');
biases.fc2 = h5read(h5FilePath, '/fc2.bias');
weights.fc3 = h5read(h5FilePath, '/fc3.weight');
biases.fc3 = h5read(h5FilePath, '/fc3.bias');
weights.fc4 = h5read(h5FilePath, '/fc4.weight');
biases.fc4 = h5read(h5FilePath, '/fc4.bias');
weights.fc5 = h5read(h5FilePath, '/fc5.weight');
biases.fc5 = h5read(h5FilePath, '/fc5.bias');
weights.fc6 = h5read(h5FilePath, '/fc6.weight');
biases.fc6 = h5read(h5FilePath, '/fc6.bias');

% Forward pass, including biases
x = test_y;
x = max(0, x * weights.fc1 + biases.fc1'); % ReLU activation
x = max(0, x * weights.fc2 + biases.fc2'); % ReLU activation
x = max(0, x * weights.fc3 + biases.fc3'); % ReLU activation
x = max(0, x * weights.fc4 + biases.fc4'); % ReLU activation
x = max(0, x * weights.fc5 + biases.fc5'); % ReLU activation
output = x * weights.fc6 + biases.fc6';
end


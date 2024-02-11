% load input data
load("ELVAC_measurements.mat")

% load Neural networ weights and biases
h5FilePath = 'model_weights16.h5'; % and all others ending with a number

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

% Forward pass, including biases
x = points_positions;
x = tanh(x * weights.fc1 + biases.fc1');
x = tanh(x * weights.fc2 + biases.fc2');
x = tanh(x * weights.fc3 + biases.fc3');
x = tanh(x * weights.fc4 + biases.fc4');
output = x * weights.fc5 + biases.fc5';


for i = 1:6
    figure
    plot(output(:,i))
    hold on
    plot(positions_angles(:,i))
end

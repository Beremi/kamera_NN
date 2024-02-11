function [output] = fmin_NN(test_y, model_weights)

weights = model_weights.weights;
biases = model_weights.biases;
% Forward pass, including biases
x = test_y;
x = tanh(x * weights.fc1 + biases.fc1'); % ReLU activation
x = tanh(x * weights.fc2 + biases.fc2'); % ReLU activation
x = tanh(x * weights.fc3 + biases.fc3'); % ReLU activation
x = tanh(x * weights.fc4 + biases.fc4'); % ReLU activation
output = x * weights.fc5 + biases.fc5';
end


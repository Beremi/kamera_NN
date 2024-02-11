function [output, it] = fmin_NNNewton(test_y, model_weights, F,dF,ddF)

weights = model_weights.weights;
biases = model_weights.biases;
% Forward pass, including biases
x = test_y;
x = tanh(x * weights.fc1 + biases.fc1'); % ReLU activation
x = tanh(x * weights.fc2 + biases.fc2'); % ReLU activation
x = tanh(x * weights.fc3 + biases.fc3'); % ReLU activation
x = tanh(x * weights.fc4 + biases.fc4'); % ReLU activation
output = x * weights.fc5 + biases.fc5';

[output,it] = optimizers.newton(output,F,dF,ddF,100,1e-1,1024);
end


function [x , it] = fmin_LHNewton(F, dF, ddF, bounds, n_samples, epsilon, maxit_newton)
%FMIN_BERES Summary of this function goes here
%   Detailed explanation goes here
warning('off', 'MATLAB:nearlySingularMatrix');
warning('off', 'MATLAB:SingularMatrix');
warning('off', 'all');

points = bounds.*optimizers.LatinHypercube(n_samples, 6);
F_vals = zeros(n_samples,1);
its = zeros(n_samples,1);

for i = 1:n_samples
    [x,its(i)] = optimizers.newton(points(i,:),F,dF,ddF,maxit_newton,epsilon,128);
    x = max(x,-bounds);
    x = min(x,bounds);
    points(i,:) = x;
    F_vals(i) = F(x);
end
[~, Idx] = min(F_vals);

% Use the sortIdx to sort the 'points' matrix column-wise

x = points(Idx,:);
it = its(Idx);

% [x,it2] = optimizers.newton(x,F,dF,ddF,maxit_newton*10,epsilon,128);
% x = max(x,-bounds);
% x = min(x,bounds);
% it = it+it2;
warning('on', 'MATLAB:nearlySingularMatrix');
warning('on', 'MATLAB:SingularMatrix');
warning('on', 'all');
end

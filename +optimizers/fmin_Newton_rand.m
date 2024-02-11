function [x , it] = fmin_Newton_rand(F, dF, ddF, bounds, epsilon, maxit_newton)
%FMIN_BERES Summary of this function goes here
%   Detailed explanation goes here
warning('off', 'MATLAB:nearlySingularMatrix');
warning('off', 'MATLAB:SingularMatrix');

n_vars = length(bounds);
point = bounds.*(rand(1,n_vars)-0.5)*2;

[x,it] = optimizers.newton(point,F,dF,ddF,maxit_newton,epsilon, 128);

warning('on', 'MATLAB:nearlySingularMatrix');
warning('on', 'MATLAB:SingularMatrix');

end

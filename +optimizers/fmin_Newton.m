function [x , it] = fmin_Newton(F, dF, ddF, bounds, epsilon, maxit_newton)
%FMIN_BERES Summary of this function goes here
%   Detailed explanation goes here
warning('off', 'MATLAB:nearlySingularMatrix');
warning('off', 'MATLAB:SingularMatrix');

point = bounds*0 + eps;

[x,it] = optimizers.newton(point,F,dF,ddF,maxit_newton,epsilon,128);

warning('on', 'MATLAB:nearlySingularMatrix');
warning('on', 'MATLAB:SingularMatrix');

end

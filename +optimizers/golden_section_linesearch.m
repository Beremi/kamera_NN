function alpha = golden_section_linesearch(x, d, F, a, b, eps)
% Define the golden ratio
rho = (sqrt(5) - 1) / 2;

% Define the end points of the initial interval
a0 = a;
b0 = b;

% Calculate the two interior points
a1 = b0 - rho * (b0 - a0);
b1 = a0 + rho * (b0 - a0);

% Evaluate the function at the interior points
F_a1 = F(x + a1 * d);
F_b1 = F(x + b1 * d);

% Iterate until the interval is smaller than the tolerance
while (abs(b0 - a0) > eps)
    if (F_a1 < F_b1)
        % If the function value at a1 is less, we choose the interval [a0, b1]
        b0 = b1;
        b1 = a1;
        F_b1 = F_a1;
        a1 = b0 - rho * (b0 - a0);
        F_a1 = F(x + a1 * d);
    else
        % If the function value at b1 is less, we choose the interval [a1, b0]
        a0 = a1;
        a1 = b1;
        F_a1 = F_b1;
        b1 = a0 + rho * (b0 - a0);
        F_b1 = F(x + b1 * d);
    end
end

% Choose the best estimate for the minimum
if F_a1 < F_b1
    alpha = (a0 + b1) / 2;
else
    alpha = (a1 + b0) / 2;
end
end
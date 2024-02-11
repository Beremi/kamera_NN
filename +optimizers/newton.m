function [x,it_newton,g] = newton(x0,F,dF,ddF,maxit,eps, n_linesearch, bounds)
x = x0;
it_newton = 0;
for it = 1:maxit
    g = dF(x);
    g_norm = norm(g);

    if g_norm < eps
        break
    end

    H = ddF(x);
    d = -H\g;

    % alpha = goldenSectionLineSearch(x, d', F, -1, 1, 1e-1);
    % x = x + alpha*d';

    all_point_search_newton = x+d' .* linspace(-1,1,n_linesearch)';
    if nargin == 8
        all_point_search_newton = max(all_point_search_newton, - bounds);
        all_point_search_newton = min(all_point_search_newton,bounds);
    end
    [~, idx_newton_line] = min(F(all_point_search_newton));
    x = all_point_search_newton(idx_newton_line,:);
    it_newton = it_newton + 1;
end
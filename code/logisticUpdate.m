function [ r, k, y0 ] = logisticUpdate( ts, ys, r, k, y0 )
% Takes t and y data points, as well as initial parameters to the logistic
% function, and returns the updated parameters after one iteration of least
% squares.

% Ensure that ts and ys are column vectors
dim = size(ts);
if dim(1) == 1
    ts = ts';
end

dim = size(ys);
if dim(1) == 1
    ys = ys';
end

% Calculate f over the values of t
fvals = logistic(ts, r, k, y0);

% Calculate 1 / (y0 + (k - y0) * e^{-rt})^2, since it appears multiple
% times in the gradient.
coef = (1 ./ (y0 + (k - y0) * exp(-r * ts))).^2;

% Compute the gradient; this will be an n x 3 vector where each row is the
% gradient evaluated at another value of t.
grad = [y0 * k * (k - y0) * exp(-r * ts) .* ts .* coef, ...
        (y0.^2) * (1 - exp(-r * ts)) .* coef, ...
        (k.^2) * exp(-r * ts) .* coef];

% Calculate the left- and right-hand sides of the update equation
LHS = grad' * grad;
diff = ys - fvals;
RHS = (sum( [diff,diff,diff] .* grad, 1 ))';

disp( LHS )

% Calculate the value of b - a (see writeup)
b_minus_a = LHS \ RHS;

% Calculate the new values of r, k, and y0
r  = b_minus_a(1) + r;
k  = b_minus_a(2) + k;
y0 = b_minus_a(3) + y0;

end


function [ r, k, y0, V ] = logisticUpdate( ts, ys, lambda, ...
    r, k, y0, V )
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

% Get the number of data points
n = size(ts);
n = n(1);

% Calculate f over the values of t
fvals = logistic(ts, r, k, y0, V);

% Calculate 1 / (y0 + (k - y0) * e^{-rt})^2, since it appears multiple
% times in the gradient.
coef = (1 ./ (y0 + (k - y0) * exp(-r * ts))).^2;

% Compute the gradient; this will be an n x 3 vector where each row is the
% gradient evaluated at another value of t.
grad = [y0 * k * (k - y0) * exp(-r * ts) .* ts .* coef, ...
        (y0.^2) * (1 - exp(-r * ts)) .* coef, ...
        (k.^2) * exp(-r * ts) .* coef, ...
        ones(n,1)];

% Calculate the left- and right-hand sides of the update equation
diff = ys - fvals;
RHS = grad' * diff;
JtJ = grad' * grad;
% Damped version (a la Levenberg): + lambda * eye(m)
% Marquardt-Levenberg: + lambda * JtJ .* eye(m)
LHS = JtJ + lambda * eye(4);

% Calculate the value of b - a (see writeup)
b_minus_a = LHS \ RHS;

% Calculate the new values of r, k, and y0
r  = b_minus_a(1) + r;
k  = b_minus_a(2) + k;
y0 = b_minus_a(3) + y0;
V  = b_minus_a(4) + V;

end


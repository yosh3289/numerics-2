function [ ys ] = logistic( ts, r, k, y0 )
% Computes the logistic function with parameters r, k, and y0 over the
% input values stored in ts.

ys = y0 * k ./ (y0 + (k - y0) * exp(-r * ts));

end


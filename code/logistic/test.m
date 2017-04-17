clear; close all; clc;

n = 30;
xs = linspace(0,5,n);
ys = linspace(0,5,n) + 1;

xs = (xs - min(xs)) / (max(xs) - min(xs));

r  = 1;
k  = 2;
y0 = 0.5;

for i = 1:5
    [r,k,y0] = logisticUpdate(xs, ys, r, k, y0);
end
    
hold on
scatter( xs, ys )
plot( xs, logistic(xs, r, k, y0) )
hold off
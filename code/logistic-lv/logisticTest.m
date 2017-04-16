% Initial cleanup
clear; close all; clc;

% Filename for data that we're interested in
filename = '../../data/new_jersey.csv';

% Import the data
data = csvread( filename );
ts = data(:,1);
ys = data(:,2);

% Re-scale the data
% Re-scale t
ts = (ts - min(ts)) / (max(ts) - min(ts));

% Re-scale y
ys = (ys - min(ys)) / (max(ys) - min(ys));

% rescale k and y0
r  = 1;
k  = 2;
y0 = 0.5;
t0 = 0.5;
V  = 0;

% Store the current error and tolerance
error = sum( (ys - logistic(ts,r,k,y0,t0,V)).^2 );
TOL = 1e-3;

% Iterate
i = 1;
diff = Inf;
for i = 1:1000
    fprintf( '%d: %f\n', i, error )
    lambda = 3 / i;
    [r, k, y0, t0, V] = logisticUpdate(ts, ys, lambda, r, k, y0, t0, V);
    error = sum( (ys - logistic(ts,r,k,y0,t0,V)).^2 );
end

disp( [r, k, y0, t0, V] )

% Plot data alongside scatter plot
hold on
scatter( ts, ys )
plot( ts, logistic(ts, r, k, y0, t0, V) )
hold off
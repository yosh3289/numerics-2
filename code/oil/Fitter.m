% Desc: fits a model with 2 parameters to data stored in a n x 2 matrix
%
% Inputs:
% data - an n x 2 matrix containing data for fit
% func - function file containing 2 parameter model to be fit to the data. 
%   Must accept three inputs (xdata, param1, param2) and output a matrix of
%   (model predicted values, derivative wrt param1 values, derivative wrt 
%   param2 values)
% a0 - initial guess for param1
% b0 - initial guess for param2

function [a,b] = Fitter(data,func,a0,b0)          

% seperate data into x and y vectors
x = data(:,1);
y = data(:,2);

% initial parameter guesses
a = a0;
b = b0;

% Tolerance for convergence 
TOL = 1e-12;
X = Inf;

% counter = 0;
% repeatedly solve matrix equation
while abs(max(X)) > TOL
    
    % get vectors for f and partials
    [F,FA,FB] = func(x,a,b);
    
    % set up and solve matrix system
    M = [sum(FA.^2), sum(FA.*FB); sum(FA.*FB), sum(FB.^2)];
    B = [sum((y-F).*FA); sum((y-F).*FB)];
    X = M\B;
    
    % update parameter values
    a = X(1) + a;
    b = X(2) + b;       
    
%     counter  = counter + 1;
end

% plot(x,y,x,func(x,a,b),'--')

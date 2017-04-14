function [a,b] = Fitter(datafile,func,a0,b0)

% get data from csv
data = importdata(datafile);

x = data(:,1);
y = data(:,2);

% initial parameter guesses
a = a0;
b = b0;

% Tolerance for convergence 
TOL = 1e-24;
X = Inf;

% counter = 0;
% repeatedly solve matrix equation
while max(X) > TOL
    
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

plot(x,y,x,func(x,a,b),'--')

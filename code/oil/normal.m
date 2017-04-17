% Normal model for oil production rates
% x - values to evaluate the model at
% a - mean
% b - standard deviation
%
% Note: Qinf must be defined elsewhere before calling this function!

function [y,ya,yb] = normal(x,a,b)

global Qinf

% model prediction
y = (Qinf/b/sqrt(2*pi))*exp((-1/2).*((x-a)./b).^2);

% partial derivative of model wrt a
ya = (Qinf.*(x-a)./b^3./sqrt(2*pi)).*exp((-1/2).*((x-a)./b).^2);

% partial derivative of model wrt b
yb = (Qinf.*((x-a).^2-b^2)./b^4./sqrt(2*pi)).*exp((-1/2).*((x-a)./b).^2);

end
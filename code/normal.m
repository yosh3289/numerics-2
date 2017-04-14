function [y,ya,yb] = normal(x,a,b)

Qinf = 2e6;

y = (Qinf/b/sqrt(2*pi))*exp((-1/2).*((x-a)./b).^2);
ya = (Qinf.*(x-a)./b^3./sqrt(2*pi)).*exp((-1/2).*((x-a)./b).^2);
yb = (Qinf.*((x-a).^2-b^2)./b^4./sqrt(2*pi)).*exp((-1/2).*((x-a)./b).^2);

end
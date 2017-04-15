global Qinf

x=OilProductionData(:,1);
y=OilProductionData(:,2);

xpr=1850:2200;
Qinf = 2e6;
[a1,b1]=Fitter(OilProductionData,@normal,2000,40);
ypr1 = normal(xpr,a1,b1);
Qinf = 3e6;
[a2,b2]=Fitter(OilProductionData,@normal,2000,40);
ypr2 = normal(xpr,a2,b2);
Qinf = 4e6;
[a3,b3]=Fitter(OilProductionData,@normal,2000,40);
ypr3 = normal(xpr,a3,b3);

plot(x,y,'k.',xpr,ypr1,'r--',xpr,ypr2,'g--',xpr,ypr3,'b--')

legend('Data','Q_{\infty}= 2 tn barrels','Q_{\infty}= 3 tn barrels',...
    'Q_{\infty}= 4 tn barrels','Location','NorthWest');
xlabel('Year');
ylabel('Oil Production Rate (millions of barrels/year)')
title('Oil Production Rate: Normal Distribution Fit');
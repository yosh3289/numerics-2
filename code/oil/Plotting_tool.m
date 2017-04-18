clear; close all;

global Qinf

oildata = csvread('../../data/OilProductionData.csv');

x=oildata(:,1);
y=oildata(:,2);

xpr=1850:2150;
Qinf = 2e6;
[a1,b1]=Fitter(oildata,@normal,2000,40);
ypr1 = normal(xpr,a1,b1);
ym1 = normal(a1,a1,b1);
x01 = 2075.39;
y01 = 0.05*ym1;
Qinf = 3e6;
[a2,b2]=Fitter(oildata,@normal,2000,40);
ypr2 = normal(xpr,a2,b2);
ym2 = normal(a2,a2,b2);
x02 = 2112.02;
y02 = 0.05*ym2;
Qinf = 4e6;
[a3,b3]=Fitter(oildata,@normal,2000,40);
ypr3 = normal(xpr,a3,b3);
ym3 = normal(a3,a3,b3);
x03 = 2138.85;
y03 = 0.05*ym3;


plot(x,y,'k.',xpr,ypr1,'r--',xpr,ypr2,'g--',xpr,ypr3,'b--',...
    [x01,x02,x03],[y01,y02,y03],'mo',...
    [a1,a2,a3],[ym1,ym2,ym3],'co')

legend('Data','Q_{\infty}= 2 tn barrels','Q_{\infty}= 3 tn barrels',...
    'Q_{\infty}= 4 tn barrels','Oil Depletion','Maximum Production','Location','NorthWest');
xlabel('Year');
ylabel('Oil Production Rate (millions of barrels/year)')
title('Oil Production Rate: Normal Distribution Fit');
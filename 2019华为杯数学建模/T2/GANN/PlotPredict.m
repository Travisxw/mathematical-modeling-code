clc
clear all
%% 
filename='PredictData';
Time=(1979:2014);
TimePre=(2014:2039);
OLRLow=xlsread(filename,1,'B2:B62');
OLRMid=xlsread(filename,1,'F2:F62');
OLRHig=xlsread(filename,1,'J2:J62');
Tree=xlsread(filename,1,'C2:C62');
CO2=xlsread(filename,1,'D2:D62');
SSTLow=xlsread(filename,1,'E2:E62');
SSTMid=xlsread(filename,1,'I2:I62');
SSTHig=xlsread(filename,1,'M2:M62');

OUTLow=xlsread(filename,1,'O2:O62');
OUTMid=xlsread(filename,1,'P2:P62');
OUTHig=xlsread(filename,1,'Q2:Q62');

subplot(1,3,1)
plot(Time,OLRLow(1:36))
hold on
plot(TimePre,OLRLow(36:end),'p')
hold on
plot(TimePre,OLRLow(36:end),'--')
grid on
xlabel('Time')
title('OLRµÕŒ≥∂»‘§≤‚Õº')

subplot(1,3,2)
plot(Time,OLRMid(1:36))
hold on
plot(TimePre,OLRMid(36:end),'p')
hold on
plot(TimePre,OLRMid(36:end),'--')
grid on
xlabel('Time')
title('OLR÷–Œ≥∂»‘§≤‚Õº')

subplot(1,3,3)
plot(Time,OLRHig(1:36))
hold on
plot(TimePre,OLRHig(36:end),'p')
hold on
plot(TimePre,OLRHig(36:end),'--')
grid on
xlabel('Time')
title('OLR∏ﬂŒ≥∂»‘§≤‚Õº')
figure
subplot(1,3,1)
plot(Time,SSTLow(1:36))
hold on
plot(TimePre,SSTLow(36:end),'p')
hold on
plot(TimePre,SSTLow(36:end),'--')
grid on
xlabel('Time')
title('SSTµÕŒ≥∂»‘§≤‚Õº')

subplot(1,3,2)
plot(Time,SSTMid(1:36))
hold on
plot(TimePre,SSTMid(36:end),'p')
hold on
plot(TimePre,SSTMid(36:end),'--')
grid on
xlabel('Time')
title('SST÷–Œ≥∂»‘§≤‚Õº')

subplot(1,3,3)
plot(Time,SSTHig(1:36))
hold on
plot(TimePre,SSTHig(36:end),'p')
hold on
plot(TimePre,SSTHig(36:end),'--')
grid on
xlabel('Time')
title('SST∏ﬂŒ≥∂»‘§≤‚Õº')

figure
plot(Time,CO2(1:36))
hold on
plot(TimePre,CO2(36:end),'p')
hold on
plot(TimePre,CO2(36:end),'--')
grid on
xlabel('Time')
title('CO2‘§≤‚Õº')

figure
plot(Time,Tree(1:36))
hold on
plot(TimePre,Tree(36:end),'p')
hold on
plot(TimePre,Tree(36:end),'--')
grid on
xlabel('Time')
title('÷≤±ª∏≤∏«‘§≤‚Õº')








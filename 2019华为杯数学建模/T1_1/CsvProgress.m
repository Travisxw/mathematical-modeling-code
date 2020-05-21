%% 读取csv文件进行处理和绘图
%% clear
clear all
clc
%% Data Progress
load CsvData.mat

AveMeanTempWi=mean(MeanTempWi,1);
AveMeanTempSp=mean(MeanTempSp,1);
AveMeanTempSu=mean(MeanTempSu,1);
AveMeanTempAu=mean(MeanTempAu,1);
Wix=(1987:1986+length(AveMeanTempWi));
Spx=(1987:1986+length(AveMeanTempSp));
Sux=(1987:1986+length(AveMeanTempSu));
Aux=(1987:1986+length(AveMeanTempAu));
YWi=(1987:1986+length(AveMeanTempWi));
YSp=(1987:1986+length(AveMeanTempSp));
YSu=(1987:1986+length(AveMeanTempSu));
YAu=(1987:1986+length(AveMeanTempAu));
%% 

subplot(2,2,1)
plot(Wix,AveMeanTempWi)
title('Winter')
PWi = polyfit(1987:1986+length(AveMeanTempWi),AveMeanTempWi,1);
YWi=(PWi(1).*Wix+PWi(2))';
hold on
plot(Wix,YWi)
xlabel('Time')
ylabel('Temp')
PWi1=num2str(roundn(PWi(1),-3));
PWi2=num2str(roundn(PWi(2),-3));
Winame=['y=',PWi1,'X+(',PWi2,')'];
gtext(Winame)
%% 
subplot(2,2,2)
plot(Spx,AveMeanTempSp)
title('Spring')
PSp = polyfit(1987:1986+length(AveMeanTempSp),AveMeanTempSp,1);
YSp=(PSp(1).*Spx+PSp(2))';
hold on
plot(Spx,YSp)
xlabel('Time')
ylabel('Temp')
PSp1=num2str(roundn(PSp(1),-3));
PSp2=num2str(roundn(PSp(2),-3));
Spname=['y=',PSp1,'X+(',PSp2,')'];
gtext(Spname)
%% 
subplot(2,2,3)
plot(Sux,AveMeanTempSu)
title('Summer')
PSu = polyfit(1987:1986+length(AveMeanTempSu),AveMeanTempSu,1);
YSu=(PSu(1).*Spx+PSu(2))';
hold on
plot(Sux,YSu)
xlabel('Time')
ylabel('Temp')
PSu1=num2str(roundn(PSu(1),-3));
PSu2=num2str(roundn(PSu(2),-3));
Suname=['y=',PSu1,'X+(',PSu2,')'];
gtext(Suname)
%% 
subplot(2,2,4)
plot(Aux,AveMeanTempAu)
title('Autumn')
PAu = polyfit(1987:1986+length(AveMeanTempAu),AveMeanTempAu,1);
YAu=(PAu(1).*Spx+PAu(2))';
hold on
plot(Aux,YAu)
xlabel('Time')
ylabel('Temp')
PAu1=num2str(roundn(PAu(1),-3));
PAu2=num2str(roundn(PAu(2),-3));
Auname=['y=',PWi1,'X+(',PAu2,')'];
gtext(Auname)
PlotName=filename(1:end-5);
suptitle(PlotName)

















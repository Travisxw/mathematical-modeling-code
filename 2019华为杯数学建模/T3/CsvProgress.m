%% 读取csv
%% clear
clear all
clc
%% Data Progress
load CsvData.mat

%% 
MaxTempAve=max(MaxTemp);
MinTempAve=min(MinTemp);
MeanTempAve=mean(MeanTemp);
SnowTempAve=mean(SnowTemp);
MaxTempBase=mean(max(MaxTemp));
MinTempBase=mean(min(MinTemp));
MeanTempBase=mean(mean(MeanTemp));
SnowTempBase=mean(mean(SnowTemp));
[m,n]=size(MaxTemp);
%% 找结冰日数
IceNumFlag=0;
IceDayNum=zeros(1,n);
for i=1:n
    for j=1:m
        if MinTemp(j,i) < 0
            IceNumFlag=IceNumFlag+1;
        end
    end
    IceDayNum(1,i)=IceNumFlag;
    IceNumFlag=0;
end
IceDayNumBase=mean(IceDayNum);
%% 绘图
figure(1)
XAxis=(1987:1986+length(MaxTempAve));
plot(XAxis,MaxTempAve)
title('最高温温度')
PFit = polyfit(1987:1986+length(MaxTempAve),MaxTempAve,1);
YFit=(PFit(1).*XAxis+PFit(2))';
hold on
plot(XAxis,YFit)
hold on
plot([1985,2020],[MaxTempBase,MaxTempBase],'--')
xlabel('Time')
ylabel('Temp')
PFit1=num2str(roundn(PFit(1),-3));
PFit2=num2str(roundn(PFit(2),-3));
Maxname=['y=',PFit1,'X+(',PFit2,')'];
gtext(Maxname)
%% 
figure(2)
XAxis=(1987:1986+length(MinTempAve));
plot(XAxis,MinTempAve)
title('最低温温度')
PFit = polyfit(1987:1986+length(MinTempAve),MinTempAve,1);
YFit=(PFit(1).*XAxis+PFit(2))';
hold on
plot(XAxis,YFit)
hold on
plot([1985,2020],[MinTempBase,MinTempBase],'--')
xlabel('Time')
ylabel('Temp')
PFit1=num2str(roundn(PFit(1),-3));
PFit2=num2str(roundn(PFit(2),-3));
Minname=['y=',PFit1,'X+(',PFit2,')'];
gtext(Minname)
%% 
figure(3)
XAxis=(1987:1986+length(MeanTempAve));
plot(XAxis,MeanTempAve)
title('平均温温度')
PFit = polyfit(1987:1986+length(MeanTempAve),MeanTempAve,1);
YFit=(PFit(1).*XAxis+PFit(2))';
hold on
plot(XAxis,YFit)
hold on
plot([1985,2020],[MeanTempBase,MeanTempBase],'--')
xlabel('Time')
ylabel('Temp')
PFit1=num2str(roundn(PFit(1),-3));
PFit2=num2str(roundn(PFit(2),-3));
Meanname=['y=',PFit1,'X+(',PFit2,')'];
gtext(Meanname)
%% 
figure(4)
XAxis=(1987:1986+length(SnowTempAve));
plot(XAxis,SnowTempAve)
title('降雪日数')
PFit = polyfit(1987:1986+length(SnowTempAve),SnowTempAve,1);
YFit=(PFit(1).*XAxis+PFit(2))';
hold on
plot(XAxis,YFit)
hold on
plot([1985,2020],[SnowTempBase,SnowTempBase],'--')
xlabel('Time')
ylabel('Day')
Snowname=['y=',PFit1,'X+(',PFit2,')'];
gtext(Snowname)
%% 
figure(5)
XAxis=(1987:1986+length(IceDayNum));
plot(XAxis,IceDayNum)
title('霜冻日数')
PFit = polyfit(1987:1986+length(IceDayNum),IceDayNum,1);
YFit=(PFit(1).*XAxis+PFit(2))';
hold on
plot(XAxis,YFit)
hold on
plot([1985,2020],[IceDayNumBase,IceDayNumBase],'--')
xlabel('Time')
ylabel('Day')
Snowname=['y=',PFit1,'X+(',PFit2,')'];
gtext(Snowname)
%%
save ExtremeClimate MaxTempAve MinTempAve MeanTempAve SnowTempAve IceDayNum...
    MaxTempBase MinTempBase MeanTempBase SnowTempBase 















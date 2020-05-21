%% 
clear all
clc
%% 数据读取
filename='渥太华.xlsx';%替换文件名可以导入不同的数据集
[STATUS,sheets]=xlsfinfo(filename);
MaxTemp=zeros(365,length(sheets));
MinTemp=zeros(365,length(sheets));
MeanTemp=zeros(365,length(sheets));
HeatDegDays=zeros(365,length(sheets));
MeanTempWi=zeros(91,length(sheets));
MeanTempSp=zeros(92,length(sheets));
MeanTempSu=zeros(92,length(sheets));
MeanTempAu=zeros(91,length(sheets));
for i=1:length(sheets)
%     MaxTemp(:,i)=xlsread(filename,sheets{i},'F26:F390');
%     MinTemp(:,i)=xlsread(filename,sheets{i},'H26:H390');
    1986+i
    MeanTemp(:,i)=xlsread(filename,sheets{i},'J26:J390');
%     HeatDegDays(:,i)=xlsread(filename,sheets{i},'L26:L390');
end
[m,n]=find(isnan(MeanTemp));
for j=1:length(m)
    TempX=1:3;
    m(j)
    n(j)
    TempY=MeanTemp(m(j)-3:m(j)-1,n(j));
    MeanTemp(m(j),n(j))=interp1(TempX,TempY,4,'nearest','extrap');
end
MeanTempWi(1:31,:)=MeanTemp(335:end,:);
MeanTempWi(32:90,:)=MeanTemp(1:59,:);
MeanTempSp=MeanTemp(32:151,:);
MeanTempSu=MeanTemp(152:243,:);
MeanTempAu=MeanTemp(244:334,:);
save CsvData
s=mean(mean(MeanTemp))











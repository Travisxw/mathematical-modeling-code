%% 
clear all
clc
%% 数据读取
filename='渥太华.xlsx';
[STATUS,sheets]=xlsfinfo(filename);
DayNum=365;
MaxTemp=zeros(DayNum,length(sheets));
MinTemp=zeros(DayNum,length(sheets));
MeanTemp=zeros(DayNum,length(sheets));
SnowTemp=zeros(DayNum,length(sheets));

for i=1:length(sheets)
    1986+i
    MaxTemp(:,i)=xlsread(filename,sheets{i},'F26:F390');
    MinTemp(:,i)=xlsread(filename,sheets{i},'H26:H390');
    MeanTemp(:,i)=xlsread(filename,sheets{i},'J26:J390');
    SnowTemp(:,i)=xlsread(filename,sheets{i},'R26:R390');
end
%% 插补NaN数据
TempX=1:3;
[m,n]=find(isnan(MaxTemp));
for j=1:length(m)
    MaxTempY=MaxTemp(m(j)-3:m(j)-1,n(j));
    MaxTemp(m(j),n(j))=interp1(TempX,MaxTempY,4,'nearest','extrap');

end
[m,n]=find(isnan(MinTemp));
for j=1:length(m)
    MinTempY=MinTemp(m(j)-3:m(j)-1,n(j));
    MinTemp(m(j),n(j))=interp1(TempX,MinTempY,4,'nearest','extrap');

end
[m,n]=find(isnan(MeanTemp));
for j=1:length(m)
    MeanTempY=MeanTemp(m(j)-3:m(j)-1,n(j)); 
    MeanTemp(m(j),n(j))=interp1(TempX,MeanTempY,4,'nearest','extrap');
    
end
[m,n]=find(isnan(SnowTemp));
for j=1:length(m)
    SnowTempY=SnowTemp(m(j)-3:m(j)-1,n(j));
    SnowTemp(m(j),n(j))=interp1(TempX,SnowTempY,4,'nearest','extrap');
end
save CsvData












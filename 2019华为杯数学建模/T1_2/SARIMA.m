%% Init
close all
clear all
clc

load CsvData.mat
%% 季节性分析
for i=1:32
    for j=1:12
        MeanTempMonth(j,i)=sum(MeanTemp((j-1)*30+1:30*j,i))/30;
    end
end

MeanTempMonthAve=mean(MeanTempMonth);
for k=1:32
    SIndex=MeanTempMonth./MeanTempMonthAve;
end
SIndex=mean(SIndex,2)
MeanTempMonthIndex=mean(MeanTempMonth,2)
%% 
VMeanTemp=MeanTemp(:);%列向量
Years=ones(floor(length(VMeanTemp)/365),1);
for i=1:floor(length(VMeanTemp)/365)
    Years(i)=sum(VMeanTemp(365*(i-1)+1:365*i))/365;
end
% x=moveaver(Month);
x=Years;
% polyfit(1:length(Month),Month',1)
subplot(3,2,1)
plot(1:length(x),x)
grid on
xlabel('A')
title('多伦多地区1987-2018年平均温度原始时序图')

r11=autocorr(x);   %计算自相关函数
subplot(3,2,3)
stem(1:length(r11),r11);
xlabel('B')
title('多伦多地区1987-2018年原始序列自相关图')
r12=parcorr(x);   %计算偏相关函数
subplot(3,2,5)
stem(1:length(r12),r12);
xlabel('C')
title('多伦多地区1987-2018年原始序列偏相关图')

%  x=x(:);  %按照时间的先后次序，把数据变成列向量
s=12;  %周期s=120
n=10;  %预报数据的个数
m1=length(x);   %原始数据的个数
for i=s+1:m1
    y(i-s)=x(i)-x(i-s); %进行周期差分变换
end
w=diff(y);   %消除趋势性的差分运算
subplot(3,2,2)
plot(1:length(w),w)
grid on
xlabel('D')
title('多伦多地区1987-2018年平均温度差分序列图')
r111=autocorr(w) ;  %计算自相关函数
subplot(3,2,4)
stem(1:length(r111),r111)
xlabel('E')
title('多伦多地区1987-2018年差分序列自相关图')
r112=parcorr(w);   %计算偏相关函数
subplot(3,2,6)
stem(1:length(r112),r112)
xlabel('F')
title('多伦多地区1987-2018年差分序列自相关图')

k=0;
m2=length(w); %计算最终差分后数据的个数
for i=0:3
    for j=0:3
        if i==0&&j==0
            continue
        elseif i==0
            ToEstMd=arima('MALags',1:j,'Constant',0);
        elseif j==0
            ToEstMd=arima('ARLags',1:i,'Constant',0);
        else
            ToEstMd=arima('ARLags',1:i,'MALags',1:j,'Constant',0);
        end
        k=k+1;R(k)=i;M(k)=j;
        [EstMd,EstParamCov,logL,info]=estimate(ToEstMd,w');
        numParams=sum(any(EstParamCov));
        [aic,bic]=aicbic(logL,numParams,m2); %计算Akaike和Bayesian信息准则 
    end
end
fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);  %显示计算结果
check=[R,M,aic,bic]
r=R;m=M;
ToEstMd=arima('ARLags',1:r,'MALags',1:m,'Constant',0);
[EstMd,EstParamCov,logL,info]=estimate(ToEstMd,w');
w_Forecast=forecast(EstMd,n,'Y0',w')
yhat=y(end)+cumsum(w_Forecast);
for j=1:n
    x(m1+j)=yhat(j)+x(m1+j-s);
end
xhat=x(m1+1:end)
figure
plot([1987:2018],Years)
hold on
plot([2018:2028],[Years(end),xhat'],'--')
grid on
hold on
plot([2019:2028],xhat,'p')
title('多伦多平均温度时间趋势图')
ylabel('℃')
xlabel('Time')









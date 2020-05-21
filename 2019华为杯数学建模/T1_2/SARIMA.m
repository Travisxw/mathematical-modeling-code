%% Init
close all
clear all
clc

load CsvData.mat
%% �����Է���
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
VMeanTemp=MeanTemp(:);%������
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
title('���׶����1987-2018��ƽ���¶�ԭʼʱ��ͼ')

r11=autocorr(x);   %��������غ���
subplot(3,2,3)
stem(1:length(r11),r11);
xlabel('B')
title('���׶����1987-2018��ԭʼ���������ͼ')
r12=parcorr(x);   %����ƫ��غ���
subplot(3,2,5)
stem(1:length(r12),r12);
xlabel('C')
title('���׶����1987-2018��ԭʼ����ƫ���ͼ')

%  x=x(:);  %����ʱ����Ⱥ���򣬰����ݱ��������
s=12;  %����s=120
n=10;  %Ԥ�����ݵĸ���
m1=length(x);   %ԭʼ���ݵĸ���
for i=s+1:m1
    y(i-s)=x(i)-x(i-s); %�������ڲ�ֱ任
end
w=diff(y);   %���������ԵĲ������
subplot(3,2,2)
plot(1:length(w),w)
grid on
xlabel('D')
title('���׶����1987-2018��ƽ���¶Ȳ������ͼ')
r111=autocorr(w) ;  %��������غ���
subplot(3,2,4)
stem(1:length(r111),r111)
xlabel('E')
title('���׶����1987-2018�������������ͼ')
r112=parcorr(w);   %����ƫ��غ���
subplot(3,2,6)
stem(1:length(r112),r112)
xlabel('F')
title('���׶����1987-2018�������������ͼ')

k=0;
m2=length(w); %�������ղ�ֺ����ݵĸ���
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
        [aic,bic]=aicbic(logL,numParams,m2); %����Akaike��Bayesian��Ϣ׼�� 
    end
end
fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);  %��ʾ������
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
title('���׶�ƽ���¶�ʱ������ͼ')
ylabel('��')
xlabel('Time')









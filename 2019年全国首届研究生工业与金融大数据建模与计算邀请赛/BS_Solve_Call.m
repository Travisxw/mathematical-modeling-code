%% 数据准备
clear;clc;
filename='CallData.xlsx';
price=xlsread(filename,1,'T2:T132')./1000;
len=length(price);
strike=(2200:50:2900)'./1000;
rate=0.0198.*ones(len,1);
time=xlsread(filename,1,'S2:S132');
time=time./365;
value=xlsread(filename,1,'B2:P132');
[~,n]=size(value);
vol_call=ones(len,n);
%% B-S求解隐含波动率
for i=1:n
    vol_call(:,i)=blsimpv(price,strike(i),rate,time,value(:,i),{'Call'});
end
%% NaN值插值替换
[m,n]=find(isnan(vol_call));
for j=1:length(m)
    TempX=1:2:20;
    m(j);
    n(j);
    TempY1=vol_call(m(j)-10:2:m(j)-1,n(j));
    TempY2=vol_call(m(j)+1:2:m(j)+10,n(j));
    TempY=[TempY1;TempY2]';
    temp=interp1(TempX,TempY,1:20,'linear');
    vol_call(m(j),n(j))=temp(10);
end

%% 绘图
[Xstrike,Ytime]=meshgrid(strike,time);
figure(1)
mesh(Xstrike,Ytime,vol_call)
xlabel('strike')
ylabel('time')
zlabel('iv')
title('B-S隐含波动率曲面图')
n=5;
figure(2)
plot(strike,vol_call(n,:),'b*')
hold on
plot(strike,vol_call(n,:),'r')
xlabel('strike')
ylabel('IV')
title('隐含波动率曲线')
m=13;
figure(3)
plot(time,vol_call(:,m),'b*')
hold on
plot(time,vol_call(:,m),'r')
xlabel('time')
ylabel('IV')
title('隐含波动率曲线')
save BS_Solve_Call filename price strike rate time value vol_call
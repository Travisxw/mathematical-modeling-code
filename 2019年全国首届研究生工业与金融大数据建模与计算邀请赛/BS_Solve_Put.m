%% 
filename='PutData.xlsx';
price=xlsread(filename,1,'U2:U132')./1000;
len=length(price);
strike=(2200:50:2900)'./1000;
rate=0.0198.*ones(len,1);
time=xlsread(filename,1,'S2:S132');
time=time./365;
value=xlsread(filename,1,'B2:P132');
[~,n]=size(value);
vol_put=ones(len,n);
%% B-S求解隐含波动率
for i=1:n
    vol_put(:,i)=blsimpv(price,strike(i),rate,time,value(:,i),1,0,[],{'put'});
end
%% NaN值插值替换
[m,n]=find(isnan(vol_put));
for j=1:length(m)
    TempX=1:2:20;
    m(j);
    n(j);
    TempY1=vol_put(m(j)-10:2:m(j)-1,n(j));
    TempY2=vol_put(m(j)+1:2:m(j)+10,n(j));
    TempY=[TempY1;TempY2]';
    temp=interp1(TempX,TempY,1:20,'linear');
    vol_put(m(j),n(j))=temp(10);
end
%% 
[Xstrike,Ytime]=meshgrid(strike,time);
figure(1)
mesh(Xstrike,Ytime,vol_put)
xlabel('strike')
ylabel('time')
zlabel('iv')
title('隐含波动率曲面图')

n=5;
figure(2)
plot(strike,vol_put(n,:),'*')
hold on
plot(strike,vol_put(n,:))
xlabel('strike')
ylabel('IV')
title('隐含波动率曲线')

m=13;
figure(3)
plot(time,vol_put(:,m),'*')
hold on
plot(time,vol_put(:,m))
xlabel('time')
ylabel('IV')
title('隐含波动率期限结构')
save BS_Solve_Put filename price strike rate time value vol_put
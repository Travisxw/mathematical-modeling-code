%% 文件说明
% 在运行本文件之前需要先运行BS_Solve_call.m文件将数据存入工作区
%% 初始化
clear;clc;
load BS_Solve_Call;
target=vol_call(:,:);

K=strike';
S_0=price;
len=length(S_0);
r=0.0198.*ones(len,1);
q=zeros(len,1);
T=time;
%% 预处理
k=log10(K./S_0)-(r-q).*T;
%% SVI求解隐含波动率
% options = optimoptions('lsqcurvefit', 'Display', 'iter', 'PlotFcn',@optimplotfirstorderopt,'Maxfuneval',2000);
options = optimoptions('lsqcurvefit', 'Display', 'iter','Maxfuneval',2000);
f_vol=ones(size(target));
for i=1:length(target)
    [cacl,resnorm,residual]=lsqcurvefit...
        (@ f_SVI,[0.3,1,1,2.9,0.3]',k(i,:)',target(i,:)',[0,0,-0.9,min(k(i,:)),0],[max(target(i,:)),4/T(i),1,max(k(i,:)),Inf],options);
    f_vol(i,:)=f_SVI(cacl,k(i,:));
end

%% 回测看涨期权
Call=ones(size(f_vol));
Put=ones(size(f_vol));
for i=1:length(strike)
    [Call(:,i),Put(:,i)]= blsprice(price,strike(i),rate,time,f_vol(:,i));
end
error=value-Call;
%% 绘图，未插值SVI校准隐含波动率曲面
figure(8)
[Xstrike,Ytime]=meshgrid(strike,time);
mesh(Xstrike*1000,Ytime,f_vol)
xlabel('strike')
ylabel('time')
zlabel('IV')
title('SVI校准隐含波动率曲面图')
hold on
[Xstrike,Ytime]=meshgrid(strike,time);
plot3(Xstrike*1000,Ytime,target,'+')
%% 绘图
figure(9)
[Xstrike,Ytime]=meshgrid(strike,time);
mesh(Xstrike*1000,Ytime,error)
xlabel('strike')
ylabel('time')
zlabel('Error')
title('看涨期权价格回测误差图')
% hold on
% [Xstrike,Ytime]=meshgrid(strike,time);
% plot3(Xstrike*1000,Ytime,vol,'+')
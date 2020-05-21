%% �ļ�˵��
% �����б��ļ�֮ǰ��Ҫ������BS_Solve_call.m�ļ������ݴ��빤����
%% ��ʼ��
clear;clc;
load BS_Solve_Call;
target=vol_call(:,:);

K=strike';
S_0=price;
len=length(S_0);
r=0.0198.*ones(len,1);
q=zeros(len,1);
T=time;
%% Ԥ����
k=log10(K./S_0)-(r-q).*T;
%% SVI�������������
% options = optimoptions('lsqcurvefit', 'Display', 'iter', 'PlotFcn',@optimplotfirstorderopt,'Maxfuneval',2000);
options = optimoptions('lsqcurvefit', 'Display', 'iter','Maxfuneval',2000);
f_vol=ones(size(target));
for i=1:length(target)
    [cacl,resnorm,residual]=lsqcurvefit...
        (@ f_SVI,[0.3,1,1,2.9,0.3]',k(i,:)',target(i,:)',[0,0,-0.9,min(k(i,:)),0],[max(target(i,:)),4/T(i),1,max(k(i,:)),Inf],options);
    f_vol(i,:)=f_SVI(cacl,k(i,:));
end

%% �ز⿴����Ȩ
Call=ones(size(f_vol));
Put=ones(size(f_vol));
for i=1:length(strike)
    [Call(:,i),Put(:,i)]= blsprice(price,strike(i),rate,time,f_vol(:,i));
end
error=value-Call;
%% ��ͼ��δ��ֵSVIУ׼��������������
figure(8)
[Xstrike,Ytime]=meshgrid(strike,time);
mesh(Xstrike*1000,Ytime,f_vol)
xlabel('strike')
ylabel('time')
zlabel('IV')
title('SVIУ׼��������������ͼ')
hold on
[Xstrike,Ytime]=meshgrid(strike,time);
plot3(Xstrike*1000,Ytime,target,'+')
%% ��ͼ
figure(9)
[Xstrike,Ytime]=meshgrid(strike,time);
mesh(Xstrike*1000,Ytime,error)
xlabel('strike')
ylabel('time')
zlabel('Error')
title('������Ȩ�۸�ز����ͼ')
% hold on
% [Xstrike,Ytime]=meshgrid(strike,time);
% plot3(Xstrike*1000,Ytime,vol,'+')
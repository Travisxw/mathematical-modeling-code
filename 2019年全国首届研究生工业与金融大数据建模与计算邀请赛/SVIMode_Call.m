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

k_new=(k(1,1):0.0001:k(1,end));
div=length(k_new);
f_vol=ones(len,div);
for i=1:length(target)
    [cacl,resnorm,residual]=lsqcurvefit...
        (@ f_SVI,[0.3,1,1,2.9,0.3]',k(i,:)',target(i,:)',[0,0,-0.9,min(k(i,:)),0],[max(target(i,:)),4/T(i),1,max(k(i,:)),Inf],options);
    k_new=(k(i,1):0.0001:k(i,end));
    f_vol(i,:)=f_SVI(cacl,k_new);
end
%% ��ͼ
div=length(k_new);
figure(4)
[Xstrike,Ytime]=meshgrid(linspace(strike(1),strike(end),div),time);
mesh(Xstrike*1000,Ytime,f_vol)
xlabel('strike')
ylabel('time')
zlabel('IV')
title('SVIУ׼��������������ͼ')
hold on
[Xstrike,Ytime]=meshgrid(strike,time);
plot3(Xstrike*1000,Ytime,target,'+')
%% ��ͼ����ֵSVIУ׼��������������
figure(5)
n=13;%�õ�n��strike�����ݻ�ͼ
plot(linspace(K(1),K(end),div)*1000,f_vol(n,:))
hold on
plot(K*1000,target(n,:),'+')
xlabel('strike')
ylabel('IV')
title('SVIУ׼��������������ͼ')


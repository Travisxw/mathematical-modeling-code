 load CsvData.mat
 %ѡ��������
% X=max(MaxTemp);
X=min(MinTemp);
% X=mean(SnowTemp);
% X=IceDayNum;
%% ����UFͳ����
N=length(X);
UF=zeros(N,1);
for t=2:N
    x=X(1:t);
    S=0;
    n=length(x);
    for k=1:(n-1)
        for j=(k+1):n
            if x(j)>x(k)
                S=S+1;
            else
                S=S+0;
            end
        end
    end
    ES=n*(n+1)/4;
    VarS=n*(n-1)*(2*n+5)/72;
    Z=(S-ES)/sqrt(VarS);
    UF(t)=Z;
end
%% ����UBͳ����
Y=flipud(X);
UB=zeros(N,1);
for t=2:N
    x=Y(1:t);
    S=0;
    n=length(x);
    for k=1:(n-1)
        for j=(k+1):n
            if x(j)>x(k)
                S=S+1;
            else
                S=S+0;
            end
        end
    end
    ES=n*(n+1)/4;
    VarS=n*(n-1)*(2*n+5)/72;
    Z=(S-ES)/sqrt(VarS);
    UB(t)=-Z;
UB2=zeros(size(Y));
% Ҳ����ʹ��UBk2=flipud(UBk);����UBk2=flipdim(UBk,1);
for i=1:n
  UB2(i)=UB(n-i+1);
end
end
%% ��ͼ
figure(2)
plot(1:(N),UF,'r-','linewidth',1.5);
hold on
plot(1:(N),UB2,'b-.','linewidth',1.5);
plot(1:(N),1.96*ones(N,1),':','linewidth',1);
axis([1,N,-4,4]);
xlabel('t (year)','FontName','TimesNewRoman','FontSize',12);
ylabel('ͳ����','FontName','TimesNewRoman','Fontsize',12);
hold on
plot(1:(N),0*ones(N,1),'-.','linewidth',1);
plot(1:(N),1.96*ones(N,1),':','linewidth',1);
plot(1:(N),-1.96*ones(N,1),':','linewidth',1)
legend('UFͳ����','UBͳ����','0.05����ˮƽ');
title('�����MKͻ���Լ���')

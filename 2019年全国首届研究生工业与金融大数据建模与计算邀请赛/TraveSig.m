%% 
load BS_Solve_Call;
load BS_Solve_Put;
%%
nn=13;
figure(10)
dif=vol_call-vol_put;
% plot(time,dif(:,nn))
% hold on
time_new=time(time>0.3);
leng=length(time_new);
plot(time_new,dif(1:leng,nn))
ave=mean(dif(1:leng,nn));
hold on
plot(time_new,linspace(ave,ave,length(time_new)))
xlabel('�껯ʣ�ൽ����')
ylabel('�������������')
title('�����������������ͼ')
%% 
sort_diff=sort(dif(1:leng,nn));
stand=sort_diff(floor(length(sort_diff)*0.8));%0.028756366843974
plot(time_new,linspace(stand,stand,length(time_new)))
%% 
put_2800=xlsread('2800��Ȩ��������������������.xlsx',1,'B2:B85');
call_2800=xlsread('2800��Ȩ��������������������.xlsx',1,'C2:C85');
diff_cp=xlsread('2800��Ȩ��������������������.xlsx',1,'F2:F85');
%% ���׹��̷���
% ��λ Pos = 1 ��ͷ1��; Pos = 0 �ղ�
Pos = zeros(length(diff_cp),1);
% ��ʼ�ʽ�
InitialE = 50e4;
% �������¼
ReturnD = zeros(length(diff_cp),1);
% ��ָ����
scale = 10000;
for t = 2:length(diff_cp)
    % �����ź� : diff_cp>stand
    SignalBuy = (diff_cp(t)>=stand);
    % �����ź� : diff_cp<stand
    SignalSell = (diff_cp(t)<stand);
    % ��������
    if SignalBuy == 1
        % �ղֿ�1��
        if Pos(t-1) == 0
            Pos(t) = 1;
            buystrike_value=call_2800(t);
            sellstrike_value=put_2800(t);
            ReturnD(t)=(buystrike_value-sellstrike_value)*scale;
            continue;
        end
        % ƽ��ͷ
        if Pos(t-1) == 1
            Pos(t) = 1;
        end
    end
    % ��������
    if SignalSell == 1
        % ƽ��
        if Pos(t-1) == 1
            Pos(t) = 0;
            ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
            continue;
        end
    end
    % ÿ��ӯ������
    if Pos(t-1) == 1
        Pos(t) = 1;
        ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
    end
    if Pos(t-1) == 0
        Pos(t) = 0;
        ReturnD(t) = 0;
    end
    % ���һ��������������гֲ֣�����ƽ��
    if t == length(diff_cp) && Pos(t-1) ~= 0
        if Pos(t-1) == 1
            Pos(t) = 0;
            ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
        end
    end 
end
%% �ۼ�����
ReturnCum = cumsum(ReturnD);
ReturnCum = ReturnCum + InitialE;

%% �������س�
MaxDrawD = zeros(length(diff_cp),1);
for t = 2:length(diff_cp)
    C = max( ReturnCum(1:t) );
    if C == ReturnCum(t)
        MaxDrawD(t) = 0;
    else
        MaxDrawD(t) = (ReturnCum(t)-C)/C;
    end
end
MaxDrawD = abs(MaxDrawD);
MaxDraw=max(MaxDrawD)*InitialE;
%% ��ͼ
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6 scrsz(3)*4/5 scrsz(4)]*3/4);
subplot(3,1,1);
plot(ReturnCum);
grid on;
axis tight;
title('��������','FontWeight', 'Bold');

subplot(3,1,2);
plot(Pos,'LineWidth',1.8);
grid on;
axis tight;
title('��λ','FontWeight', 'Bold');

subplot(3,1,3);
plot(MaxDrawD);
grid on;
axis tight;
title(['���س�����ʼ�ʽ�',num2str(InitialE/1e4),'��'],'FontWeight', 'Bold');
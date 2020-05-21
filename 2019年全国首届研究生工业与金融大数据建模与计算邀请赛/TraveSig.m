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
xlabel('年化剩余到期日')
ylabel('隐含波动率溢价')
title('隐含波动率溢价曲线图')
%% 
sort_diff=sort(dif(1:leng,nn));
stand=sort_diff(floor(length(sort_diff)*0.8));%0.028756366843974
plot(time_new,linspace(stand,stand,length(time_new)))
%% 
put_2800=xlsread('2800行权价隐含波动率套利策略.xlsx',1,'B2:B85');
call_2800=xlsread('2800行权价隐含波动率套利策略.xlsx',1,'C2:C85');
diff_cp=xlsread('2800行权价隐含波动率套利策略.xlsx',1,'F2:F85');
%% 交易过程仿真
% 仓位 Pos = 1 多头1手; Pos = 0 空仓
Pos = zeros(length(diff_cp),1);
% 初始资金
InitialE = 50e4;
% 日收益记录
ReturnD = zeros(length(diff_cp),1);
% 股指乘数
scale = 10000;
for t = 2:length(diff_cp)
    % 买入信号 : diff_cp>stand
    SignalBuy = (diff_cp(t)>=stand);
    % 卖出信号 : diff_cp<stand
    SignalSell = (diff_cp(t)<stand);
    % 买入条件
    if SignalBuy == 1
        % 空仓开1手
        if Pos(t-1) == 0
            Pos(t) = 1;
            buystrike_value=call_2800(t);
            sellstrike_value=put_2800(t);
            ReturnD(t)=(buystrike_value-sellstrike_value)*scale;
            continue;
        end
        % 平多头
        if Pos(t-1) == 1
            Pos(t) = 1;
        end
    end
    % 卖出条件
    if SignalSell == 1
        % 平仓
        if Pos(t-1) == 1
            Pos(t) = 0;
            ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
            continue;
        end
    end
    % 每日盈亏计算
    if Pos(t-1) == 1
        Pos(t) = 1;
        ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
    end
    if Pos(t-1) == 0
        Pos(t) = 0;
        ReturnD(t) = 0;
    end
    % 最后一个交易日如果还有持仓，进行平仓
    if t == length(diff_cp) && Pos(t-1) ~= 0
        if Pos(t-1) == 1
            Pos(t) = 0;
            ReturnD(t)=(buystrike_value+sellstrike_value-call_2800(t)-put_2800(t))*scale;
        end
    end 
end
%% 累计收益
ReturnCum = cumsum(ReturnD);
ReturnCum = ReturnCum + InitialE;

%% 计算最大回撤
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
%% 绘图
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6 scrsz(3)*4/5 scrsz(4)]*3/4);
subplot(3,1,1);
plot(ReturnCum);
grid on;
axis tight;
title('收益曲线','FontWeight', 'Bold');

subplot(3,1,2);
plot(Pos,'LineWidth',1.8);
grid on;
axis tight;
title('仓位','FontWeight', 'Bold');

subplot(3,1,3);
plot(MaxDrawD);
grid on;
axis tight;
title(['最大回撤（初始资金',num2str(InitialE/1e4),'万）'],'FontWeight', 'Bold');
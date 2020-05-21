%% 
load BS_Solve_Call;
load BS_Solve_Put;
%%
nn=13;
figure(10)
dif=vol_call-vol_put;
time_new=time(time>0.3);
leng=length(time_new);
plot(time_new,dif(1:leng,nn))
ave=mean(dif(1:leng,nn));
%% 
sort_diff=sort(dif(1:leng,nn));
stand=sort_diff(floor(length(sort_diff)*0.8));%0.028756366843974
xCacl=linspace(sort_diff(1),sort_diff(end),10);
num_count=zeros(9);
for i=1:9
    num_count(i)=length(find(sort_diff>=xCacl(i)&sort_diff<xCacl(i+1)+0.00000001));
end
num_count_cusum=cumsum(num_count);
num_count_cusum=num_count_cusum(:,1)';
bar(xCacl(2:end),num_count_cusum,'w')
hold on
xx=[stand stand];
yy=[0 70];
plot(xx,yy)
xlabel('看涨看跌隐含波动率之差')
ylabel('个数统计')
title('累积频率直方图')
% 累积分布统计
% 十分之八分位数
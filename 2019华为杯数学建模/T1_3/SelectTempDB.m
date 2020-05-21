%% waveletAnalyzer
close all
clear all
clc
%% 
load temp 
%152W,10N
% x=105;
% y=40;
% 174E,38N
x=88;
y=26;
% 38E,74N
% x=20;
% y=8;
%
x=110;
y=30;
TempLen=length(Temp);
temperature=ones(TempLen,1);
for i=1:TempLen
    temperature(i,1)=Temp{i,1}(x,y);
end
for i=1:165
    temperatureY(i,1)=sum(temperature(12*(i-1)+1:12*i,1))/12;
end
figure
subplot(2,1,1)
% plot(1:TempLen,temperatureY)
plot(1:165,temperatureY)
subplot(2,1,2)
c1=cwt(temperatureY,1:164,'db4','plot');%1:64
c1=c1(:,14:end-14);
suptitle('年小波分析')
figure
subplot(1,1,1);meshc(c1);surfc(c1);shading interp;colormap(hsv);
figure

contourf(c1,10);colormap(hsv)
colorbar('horiz');
title('年小波实部时频分布等高线')

figure

a=sum(abs(c1).^2,2);
 plot(1:length(a),a)
 xlabel('时间尺度/a')
 ylabel('小波方差')
 title('年小波方差图')
 grid on


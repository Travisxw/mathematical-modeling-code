x=[49.19,49.54,48.24,46.47,43.377,45.24,66.43];
y=[123.5,97.8,123.21,71.14,79.22,75.41,115.57];
z=[11.01558904,3.836447489,10.01196642,4.742013103,8.745565068,6.989794521,-10.07070498];
[X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');
% pcolor(X,Y,Z);shading interp

name={'温哥华','温尼伯','维多利亚','魁北克市','多伦多','渥太华','库格鲁图克'};
figure

for i=1:7
    scatter3(x(i),y(i),z(i),'p')
    hold on
    legend(name{1,i})
end

hold on
mesh(X,Y,Z)
% scatter3(x,y,z,'p')
legend('温哥华','温尼伯','维多利亚','魁北克市','多伦多','渥太华','库格鲁图克','拟合曲面')




close all
clear all
 
% 绘制海表面温度数据变化
oid='sst.mnmean.nc';
% ooid='precip.mon.mean.nc'
sst=double(ncread(oid,'sst'));

nlat=double(ncread(oid,'lat'));
nlon=double(ncread(oid,'lon'));
Temp=cell(1985,1);
 
mv=ncreadatt(oid,'/sst','missing_value');
sst(find(sst==mv))=NaN;

[Nlt,Nlg]=meshgrid(nlat,nlon);
%Plot the SST data without using the MATLAB Mapping Toolbox

for i=1:1985
    Temp{i,1}=sst(:,:,i);
    pcolor(Nlg,Nlt,sst(:,:,i));shading interp;
    load coast;hold on;plot(long,lat);plot(long+360,lat);hold off
    colorbar
     pause(0.000001)
end
save Temp Temp Nlg Nlt
%% Matlab程序读取sst数据： 
close all
clear all
 
oid='sst.mon.mean.nc'%1850-2018SST数据
sst=double(ncread(oid,'sst'));
nlat=double(ncread(oid,'lat'));
nlon=double(ncread(oid,'lon'));
 
mv=ncreadatt(oid,'/sst','missing_value');
sst(find(sst==mv))=NaN;
 
[Nlt,Nlg]=meshgrid(nlat,nlon);
%% 
SST=cell(2028,1);
for i=1:2028
    SST{i,1}=sst(:,:,i);
%     pcolor(Nlg,Nlt,olr(:,:,i));shading interp;
%     load coast;hold on;plot(long,lat);plot(long+360,lat);hold off
%     colorbar
%      pause(0.000001)
end
SSTYear=cell(2028/12,1);
nannum=0;
%% 年平均
for j=1:169
    sumSST=zeros(360,180);
    for k=1:12
        sumSST=sumSST+SST{(j-1)*12+k,1};
        if isnan(sumSST)
            nannum=[nannum,j];
            break;
        end
    end
    SSTYear{j,1}=sumSST./12;
end
flag=0;
[m,n]=size(SSTYear{1,1});
%% 各纬度平均
SumLow=0;
SumMid=0;
SumHig=0;
for i=1:169
    for j=1:m
        for k=62:120
            if isnan(SSTYear{i,1}(j,k))
                continue;
            end
            SumLow=SumLow+SSTYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    LowAve(i,1)=SumLow./flag;
    SumLow=0;
    flag=0;
end
flag=0;
for i=1:169
    for j=1:m
        for k=32:61
            if isnan(SSTYear{i,1}(j,k))
                continue;
            end
            SumMid=SumMid+SSTYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    for j=1:m
        for k=121:150
            if isnan(SSTYear{i,1}(j,k))
                continue;
            end
            SumMid=SumMid+SSTYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    MidAve(i,1)=SumMid./flag;
    SumMid=0;
    flag=0;
end
flag=0;
for i=1:169
    for j=1:m
        for k=1:31
            if isnan(SSTYear{i,1}(j,k))
                continue;
            end
            SumHig=SumHig+SSTYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    for j=1:m
        for k=151:180
            if isnan(SSTYear{i,1}(j,k))
                continue;
            end
            SumHig=SumHig+SSTYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    HigAve(i,1)=SumHig./flag;
    SumHig=0;
    flag=0;
end
save T2SST SSTYear LowAve MidAve HigAve




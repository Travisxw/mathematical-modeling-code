%Matlab程序读取olr数据： 
close all
clear all
clc

oid='olr.mon.mean.nc' %1979-2012太阳辐射数据
olr=double(ncread(oid,'olr'));
nlat=double(ncread(oid,'lat'));
nlon=double(ncread(oid,'lon'));
 
mv=ncreadatt(oid,'/olr','missing_value');
ncreadatt(oid,'/olr','units');
olr(find(olr==mv))=NaN;
 
[Nlt,Nlg]=meshgrid(nlat,nlon);
OLR=cell(408,1);
for i=1:4
    OLR{i,1}=olr(:,:,i);
    pcolor(Nlg,Nlt,olr(:,:,i));shading interp;
    title('太阳辐射')
    load coast;hold on;plot(long,lat);plot(long+360,lat);hold off
    colorbar
     pause(0.000001)
end
OLRYearT=cell(34,1);
nannum=0;
for j=1:34
    sumOLR=zeros(360,181);
    for k=1:12
        sumOLR=sumOLR+OLR{(j-1)*12+k,1};
        if isnan(sumOLR)
            nannum=[nannum,j];
            break;
        end
    end
    OLRYearT{j,1}=sumOLR./12;
end
flag=1;
for i=1:34-length(nannum)+2
    if find(nannum==i)
        continue;
    end
    OLRYear{flag,1}= OLRYearT{i,1};
    flag=flag+1;
end
for i=1:length(OLRYear)
    LowAve(i,1)=mean(mean(OLRYear{i,1}(:,62:120)));
    MidAve(i,1)=(mean(mean(OLRYear{i,1}(:,32:61)))+mean(mean(OLRYear{i,1}(:,121:150))))/2;
    HigAve(i,1)=(mean(mean(OLRYear{i,1}(:,1:31)))+mean(mean(OLRYear{i,1}(:,151:181))))/2;
end



save OLR OLR OLRYear LowAve MidAve HigAve












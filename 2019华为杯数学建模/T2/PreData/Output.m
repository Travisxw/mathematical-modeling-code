%% air.mon.1981-2010.ltm
close all
clc
clear all
%% 
oid='air.mon.mean.nc'%1948-pre表面温度数据
air=double(ncread(oid,'air'));
nlat=double(ncread(oid,'lat'));
nlon=double(ncread(oid,'lon'));
 
mv=ncreadatt(oid,'/air','missing_value');
air(find(air==mv))=NaN;
[Nlt,Nlg]=meshgrid(nlat,nlon);

%% 
AIR=cell(852,1);
for i=1:852
    AIR{i,1}=air(:,:,i)-272.15;
end
AIRYear=cell(852/12,1);
nannum=0;%NaN
for j=1:71
    sumAIR=zeros(720,360);
    for k=1:12
        sumAIR=sumAIR+AIR{(j-1)*12+k,1};
        if isnan(sumAIR)
            nannum=[nannum,j];
            break;
        end
    end
    AIRYear{j,1}=sumAIR./12;
end
flag=0;
[m,n]=size(AIRYear{1,1});
SumLow=0;
SumMid=0;
SumHig=0;
for i=1:71
    for j=1:m
        for k=121:239
            if isnan(AIRYear{i,1}(j,k))
                continue;
            end
            SumLow=SumLow+AIRYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    LowAve(i,1)=SumLow./flag;
    SumLow=0;
    flag=0;
end
flag=0;
for i=1:71
    for j=1:m
        for k=61:120
            if isnan(AIRYear{i,1}(j,k))
                continue;
            end
            SumMid=SumMid+AIRYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    for j=1:m
        for k=240:300
            if isnan(AIRYear{i,1}(j,k))
                continue;
            end
            SumMid=SumMid+AIRYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    MidAve(i,1)=SumMid./flag;
    SumMid=0;
    flag=0;
end
flag=0;
for i=1:71
    for j=1:m
        for k=1:60
            if isnan(AIRYear{i,1}(j,k))
                continue;
            end
            SumHig=SumHig+AIRYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    for j=1:m
        for k=301:360
            if isnan(AIRYear{i,1}(j,k))
                continue;
            end
            SumHig=SumHig+AIRYear{i,1}(j,k);
            flag=flag+1;
        end
    end
    HigAve(i,1)=SumHig./flag;
    SumHig=0;
    flag=0;
end
save Output AIRYear LowAve MidAve HigAve
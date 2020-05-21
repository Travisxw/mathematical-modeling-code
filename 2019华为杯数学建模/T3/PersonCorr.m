%% clear
clear all
clc
%% Data Progress
load ExtremeClimate.mat
x=[MeanTempAve',MaxTempAve',MinTempAve',SnowTempAve',IceDayNum'];
[rho,p]=corr(x)
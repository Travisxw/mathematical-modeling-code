%% 
close all
clear all
clc
%% 
filename='PredictData';
input=xlsread(filename,1,'B2:M62');
output=xlsread(filename,1,'O2:Q42');

save data input output
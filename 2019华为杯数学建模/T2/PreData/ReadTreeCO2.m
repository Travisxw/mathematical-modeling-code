%% 
close all
clear all
clc
%% 
filename1='Tree.xlsx';
TimeTree=xlsread(filename1,1,'A4:A40');
Tree=xlsread(filename1,1,'C4:C40');
save Tree TimeTree Tree
%% 
filename2='globalCO2.xlsx';
TimeCO2=xlsread(filename2,1,'A3:A266');
CO2=xlsread(filename2,1,'B3:B266');
save CO2 TimeCO2 CO2

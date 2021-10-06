%test dataprocessing_30sec function
clc;clear;
name='SZ000002.csv';
name_title=extractBefore(name,".csv");
dataprocessing_30sec('E:\2021AutumnJI\2021fallPRP\PRP','E:\2021AutumnJI\2021fallPRP\PRP',name);
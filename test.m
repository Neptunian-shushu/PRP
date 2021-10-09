%test speed of cd and direst path
clc;clear;
name='SZ000002.csv';
name_title=extractBefore(name,".csv");
tic;
path1=pwd;
cd test;
cd test1;
cd test2;
cd test3;
cd test4;
cd test5;
cd test6;
cd test7;
cd test8;
cd test9;
cd test10;
rawdata=readtable(name);
cd (path1)
toc;

tic;
rawdata2=readtable(['E:\2021AutumnJI\2021fallPRP\PRP\test\test1\test2\test3\test4\test5\test6\test7\test8\test9\test10\',name]);
toc;


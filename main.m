clc,clear;
path_basic=pwd;
path_data=path_basic+"\GPSJ原始数据";
path_processed=path_basic+"\处理后数据";
if exist(path_processed)==0
   mkdir(path_processed) 
end
year_dir_list = [
    %    "非股票的高频数据2017年1月-10月",
    %    "高频原始数据2006"
    %    "高频原始数据2007缺1.1-1.15",
    %    "高频原始数据2008缺12.17-12.31",
    %    "高频原始数据2009",
    %    "高频原始数据2010",
    %    "高频原始数据2011",
    %    "高频原始数据2012",
    %    "高频原始数据2013",
    %    "高频原始数据2014",
    %    "高频原始数据2015",
    %    "高频原始数据2016",
    %    "高频原始数据2017",
    %    "高频原始数据2018"
    %    "高频原始数据2019"
        "高频原始数据2020"
];
for i=1:length(year_dir_list)%遍历所有年份文件夹
    if exist(path_processed+"\"+year_dir_list(i))==0
        mkdir(path_processed+"\"+year_dir_list(i))%同时生成保存数据的年份文件夹
    end
    %遍历sh文件夹
end
for year=1:length(year_dir_list)
    path_temp=path_data+"\"+year_dir_list(1);
    list1=dir(path_temp);
end
dataprocessing('SH600000',1);
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
    path_temp_data=path_data+"\"+year_dir_list(i);
    path_temp_processed=path_processed+"\"+year_dir_list(i);
    if exist(path_processed+"\"+year_dir_list(i))==0
        mkdir(path_processed+"\"+year_dir_list(i))%同时生成保存数据的年份文件夹
    end
    no_unzip_struct=dir(path_temp_data);
    no_unzipped=[];%files waiting to be unzipped
    for i=1:length(no_unzip_struct)
        if no_unzip_struct(i).isdir==0 && (isempty(strfind(no_unzip_struct(i).name,".rar"))~=0 || isempty(strfind(no_unzip_struct(i).name,".zip"))~=0)
            %not folder, is compressed file
            no_unzipped=[no_unzipped;string(no_unzip_struct(i).name)];
        end
    end
    %record the name of the folders after unzipping
    unzipped=[];
    for i=1:length(no_unzipped)
        if contains(no_unzipped(i),".zip")==1%zip file
            no_unzipped_temp=no_unzipped(i);
            unzipped=[unzipped;extractBefore(no_unzipped_temp,strfind(no_unzipped_temp,".zip"))];
        elseif contains(no_unzipped(i),".rar")==1%rar file
            no_unzipped_temp=no_unzipped(i);
            unzipped=[unzipped;extractBefore(no_unzipped_temp,strfind(no_unzipped_temp,".rar"))];
        end
    end
    %unzip all the files, remember to delete them later
    for i=1:length(no_unzipped)
        path_temp_no_unzip=path_temp_data+"\"+no_unzipped(i);%address of the file that needs to be unzipped
        unzip(char(path_temp_no_unzip),char(path_temp_data+"\"+unzipped(i)));
    end
    %cd into the unzipped folder twice
    for i=1:length(unzipped)
        path_temp_unzipped_=path_temp_data+"\"+unzipped(i);
        path_single=dir(path_temp_unzipped_);
        path_temp_unzipped=path_temp_unzipped_+"\"+string(path_single(3).name);
        path_temp_unzipped_processed=path_temp_processed+"\"+string(path_single(3).name);
        if exist(path_temp_unzipped_processed)==0
            mkdir(path_temp_unzipped_processed);
        end
        %SH
        path_temp_unzipped_SH=path_temp_unzipped+"\SH";
        path_temp_unzipped_SH_processed=path_temp_unzipped_processed+"\SH";
        if exist(path_temp_unzipped_SH_processed)==0
            mkdir(path_temp_unzipped_SH_processed);
        end
        SH_dir=dir(path_temp_unzipped_SH);
        %process the data
        for i=3:length(SH_dir)
            dataprocessing(SH_dir(i).folder,path_temp_unzipped_SH_processed,SH_dir(i).name,1);
        end
        %SZ
        path_temp_unzipped_SZ=path_temp_unzipped+"\SZ";
        path_temp_unzipped_SZ_processed=path_temp_unzipped_processed+"\SZ";
        if exist(path_temp_unzipped_SZ_processed)==0
            mkdir(path_temp_unzipped_SZ_processed);
        end
        SZ_dir=dir(path_temp_unzipped_SZ);
        %process the data
        for i=3:length(SZ_dir)
            dataprocessing_1min(SZ_dir(i).folder,path_temp_unzipped_SZ_processed,SZ_dir(i).name,1);
        end
        %delete the unzipped folders
        rmdir(path_temp_unzipped_,'s');
    end
    
end

%for year=1:length(year_dir_list)
%    path_temp=path_data+"\"+year_dir_list(1);
%    list1=dir(path_temp);
%end
%dataprocessing_1min('SZ000002',1);
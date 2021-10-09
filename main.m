clc;clear;
STARTYEAR=2007;
ENDYEAR=2007;
path_origin=pwd;
%enter the original data
path_year=[path_origin, '\解压后数据'];
path_processed=[path_origin,'\处理后数据'];

%if dir not exist, then make it
if ~exist(path_processed,'dir')
	mkdir(path_processed);
end

for year=STARTYEAR:ENDYEAR
    YEAR=num2str(year);
    cleanyear(path_year,path_processed,YEAR);
end

%turn back to the origin path
cd (path_origin);
ORIGIN='高频处理数据';

for i=STARTYEAR:ENDYEAR
    YEAR=num2str(i);
    FOLDERNAME=[ORIGIN,YEAR];
    transformyear(path_processed,FOLDERNAME);
end
cd (path_origin);
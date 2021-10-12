clc;clear;
STARTYEAR=2020;
ENDYEAR=2020;
path_origin=pwd;
%enter the original data
path_year=[path_origin, '\extracted'];
path_processed=[path_origin,'\processed'];

%if dir not exist, then make it
if ~exist(path_processed,'dir')
	mkdir(path_processed);
end

for year=STARTYEAR:ENDYEAR
    if exist([path_processed,'\','高频处理数据',num2str(year)])==0
        %doens't exist processed file
        if exist([path_year,'\',num2str(year)])==0
            %doesn't need to process this year, skip
            fprintf("Year %d doesn't exist, skip.\n",year);
            continue
        else
            %has not been processed
            YEAR=num2str(year);
            cleanyear(path_year,path_processed,YEAR);
            fprintf("Year %d processed.\n",year);
        end
    else
        %exist processed file
        %has been processed
        fprintf("Year %d has been processed, skip.\n",year);
        continue
    end
        
end

%turn back to the origin path
cd (path_origin);
ORIGIN='高频处理数据';

for year=STARTYEAR:ENDYEAR
    if exist([path_processed,'\',num2str(year)])==0
        %doesn't exist processed file
        if exist([path_year,'\',num2str(year)])==0
            %doesn't need to process this year, skip
            continue
        else
            %has not been processed
            FOLDERNAME=[ORIGIN,num2str(year)];
            transformyear(path_processed,FOLDERNAME);
        end
    else
        %exist processed file
        %has been procesed
        continue
    end
end
cd (path_origin);
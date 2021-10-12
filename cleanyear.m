%enter the year list, and clean the data
function cleanyear(target_path,path_output,YEAR)
cd (path_output);
%originpath=pwd;
NEWFOLDER="高频处理数据"+YEAR;
if ~exist(NEWFOLDER,'dir')
	mkdir(NEWFOLDER);
end
cd(NEWFOLDER);
newpath=pwd;

cd(target_path);
FOLDER=YEAR;
DIRECTORY1=dir(FOLDER);

for i=3:length(DIRECTORY1)
    FILENAME=fullfile(FOLDER,DIRECTORY1(i).name);
    if length(DIRECTORY1(i).name)==9
        DAY=[YEAR,FILENAME(end-6:end-3)];
    elseif length(DIRECTORY1(i).name)==12
        DAY=[YEAR,FILENAME(end-5:end-2)];
    end
    cd(newpath);
    if ~exist(DAY,'dir')
        mkdir(DAY);
    end
    
    temp_path=[target_path,'\',FILENAME(1:4),'\','ws',YEAR,FILENAME(end-5:end)];
    if exist(temp_path)~=0%exist
        datapath=temp_path;
    else
        datapath=[target_path,'\',FILENAME,'\ws',YEAR,FILENAME(end-6:end-1)];
    end
    
    %SH
    DIRSH=dir([datapath,'\SH']);
%     FILE=[datapath,'\SH\',DIRSH(3).name];
%     stockclean(FILE,newpath,DAY);
    %back to the original path
    cd ..
    cd ..
    parfor j=3:length(DIRSH)
        FILE=[datapath,'\SH\',DIRSH(j).name];
        try
            stockclean(FILE,newpath,DAY);
        catch
            sprintf('%d has THE error',j);
        end
    end
    
    %SZ
    DIRSZ=dir([datapath,'\SZ']);
    parfor j=3:length(DIRSZ)
        FILE=[datapath,'\SZ\',DIRSZ(j).name];
        try
            stockclean(FILE,newpath,DAY);
        catch
            sprintf('%d has THE error',j);
        end
    end
end
end
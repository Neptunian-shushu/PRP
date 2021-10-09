%enter the year list, and clean the data
function cleanyear(target_path,path_output,YEAR)
if ~exist(path_output,'dir')
	mkdir(path_output);
end
cd (path_output);
%originpath=pwd;
NEWFOLDER=['高频处理数据',YEAR];
if ~exist(NEWFOLDER,'dir')
	mkdir(NEWFOLDER);
end
cd(NEWFOLDER);
newpath=pwd;

cd(target_path);
FOLDER=['高频原始数据',YEAR];
DIRECTORY1=dir(FOLDER);

for i=3:length(DIRECTORY1)
    FILENAME=fullfile(FOLDER,DIRECTORY1(i).name);
    DAY=[YEAR,FILENAME(end-6:end-3)];
    
    cd(newpath);
    if ~exist(DAY,'dir')
        mkdir(DAY);
    end
    
    datapath=[target_path,'\',FILENAME,'\ws',YEAR,FILENAME(end-6:end-1)];
    
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
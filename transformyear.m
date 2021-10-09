function transformyear(target_folder,FOLDERNAME)
%FOLDERNAME='高频处理数据2020';
cd (target_folder);
DIRECTORY=dir(FOLDERNAME);
NEWFOLDERNAME=FOLDERNAME(end-3:end);
if ~exist(NEWFOLDERNAME,'dir')
    mkdir(NEWFOLDERNAME);
end
cd ..
for i=3:length(DIRECTORY)
    FILENAME=fullfile(DIRECTORY(i).folder,DIRECTORY(i).name);
    try
        transformday(FILENAME,NEWFOLDERNAME);
    catch
        sprintf('%d has THE error',i);
    end
end
end
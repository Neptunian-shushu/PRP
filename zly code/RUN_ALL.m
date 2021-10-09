STARTYEAR=2021;
ENDYEAR=2021;

for year=STARTYEAR:ENDYEAR
    path=pwd;
    YEAR=num2str(year);
    cleanyear(YEAR);
    cd(path);
end

ORIGIN='高频处理数据';
parfor i=STARTYEAR:ENDYEAR
    YEAR=num2str(i);
    FOLDERNAME=[ORIGIN,YEAR];
    transformyear(FOLDERNAME);
end



function cleanyear(YEAR)
originpath=pwd;
NEWFOLDER=['高频处理数据',YEAR];
mkdir(NEWFOLDER);
cd(NEWFOLDER);
newpath=pwd;

cd(originpath);
FOLDER=['高频原始数据',YEAR];
DIRECTORY1=dir(FOLDER);

for i=3:length(DIRECTORY1)
    FILENAME=fullfile(FOLDER,DIRECTORY1(i).name);
    DAY=[YEAR,FILENAME(end-6:end-3)];
    
    cd(newpath);
    mkdir(DAY);
    
    datapath=[originpath,'\',FILENAME,'\ws',YEAR,FILENAME(end-6:end-1)];
    
    %上交所
    DIRSH=dir([datapath,'\SH']);
%     FILE=[datapath,'\SH\',DIRSH(3).name];
%     stockclean(FILE,newpath,DAY);
    for j=3:length(DIRSH)
        FILE=[datapath,'\SH\',DIRSH(j).name];
        try
            stockclean(FILE,newpath,DAY);
        catch
            sprintf('%d has THE error',j);
        end
    end
    
    %深交所
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

function stockclean(FILENAME,NEWFOLDER,DAY)
rawdata=readtable(FILENAME);
rawdata= removevars(rawdata,{'Amount','SP2','SP3','SP4','SP5','SV2','SV3','SV4','SV5','BP2','BP3','BP4','BP5','BV2','BV3','BV4','BV5'});
data=table2cell(rawdata);

duration=30; % unit:second
t_morning=datetime(2020,01,02,09,30,00)+seconds(0:duration:7199);
t_afternoon=datetime(2020,01,02,13,00,00)+seconds(0:duration:7199);
halfdaylength=length(t_morning);
daylength=length(t_morning)+length(t_afternoon);

%Morning: 9:30-11:30
for j=1:halfdaylength
    while 1
        if data{j,1}<t_morning(j)
            if data{j+1,1}<=t_morning(j)
                data(j,:)=[];
            else
                data{j,1}=t_morning(j);
            end
        end
        
        if data{j,1}>t_morning(j)
            newrow=data(j-1,:);
            newrow{1,1}=t_morning(j);
            data=[data(1:j-1,:);newrow;data(j:end,:)];
        end
        
        if data{j,1}==t_morning(j)
            break
        end
    end
end

%Afternoon: 13:00-15:00
for j=halfdaylength+1:daylength
    jj=j-halfdaylength;
    while 1
        if data{j,1}<t_afternoon(jj)
            if data{j+1,1}<=t_afternoon(jj)
                data(j,:)=[];
            else
                data{j,1}=t_afternoon(jj);
            end
        end
        
        if data{j,1}>t_afternoon(jj)
            newrow=data(j-1,:);
            newrow{1,1}=t_afternoon(jj);
            data=[data(1:j-1,:);newrow;data(j:end,:)];
        end
        
        if data{j,1}==t_afternoon(jj)
            break
        end
    end
    
end

data=data(1:daylength,:);
result.data=data;
NEWFILENAME=FILENAME(end-11:end-4);
ADDRESS=[NEWFOLDER,'\',DAY,'\',NEWFILENAME];
save(ADDRESS,'result')
end

function transformyear(FOLDERNAME)
%FOLDERNAME='高频处理数据2020';
DIRECTORY=dir(FOLDERNAME);
NEWFOLDERNAME=FOLDERNAME(end-3:end);
mkdir(NEWFOLDERNAME);
parfor i=3:length(DIRECTORY)
    FILENAME=fullfile(DIRECTORY(i).folder,DIRECTORY(i).name);
    try
        transformday(FILENAME,NEWFOLDERNAME);
    catch
        sprintf('%d has THE error',i);
    end
end
end

function transformday(FILENAME,NEWFOLDERNAME)
%FILENAME='20180102';
DIRECTORY=dir(FILENAME);

FILE=fullfile(FILENAME,DIRECTORY(3).name);
firmname=FILE(end-11:end-4);

raw=load(FILE);
rawdata=raw.result.data;

sz=size(rawdata);
T=sz(1);
time=1:T;
time=time';

Bidprice=cell2mat(rawdata(:,6));
Askprice=cell2mat(rawdata(:,4));

FIRM={firmname,1};
firm=ones(T,1);
data=[firm,time,Bidprice,Askprice];

for i=4:length(DIRECTORY)
    ii=i-2;
    FILE=fullfile(FILENAME,DIRECTORY(i).name);
    firmname=FILE(end-11:end-4);
    
    raw=load(FILE);
    rawdata=raw.result.data;
    
    Bidprice=cell2mat(rawdata(:,6));
    Askprice=cell2mat(rawdata(:,4));
    
    FIRM_new={firmname,ii};
    FIRM=[FIRM;FIRM_new];
    
    firm=ii*ones(T,1);
    data_new=[firm,time,Bidprice,Askprice];
    data=[data;data_new];
end

ADDRESS=[NEWFOLDERNAME,'\',FILENAME(end-7:end)];
save(ADDRESS,'data','FIRM')

end
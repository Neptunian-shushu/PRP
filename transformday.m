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
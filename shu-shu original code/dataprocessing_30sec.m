function out=dataprocessing_30sec(input_folder,output_folder,name)
%name='SZ000002.csv';
name_title=extractBefore(name,".csv");
tail='.csv';

rawdata=readtable([input_folder,'\',name]);
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

size_data=size(data);
row=size_data(1);%get the row of the data
time=[];
%get the exact value of time
for i=1:row
    temp=strsplit(string(data{i,1}));
    temp=temp{2};
    time=[time;temp];
end
data(:,1)=[];%delete time in cell
a=cell2mat(data);

data=data(1:daylength,:);
result.data=data;
NEWFILENAME=FILENAME(1:8);
save(NEWFILENAME,'result')

%title={'Time','Price','Volume','SP1','SV1','BP1','BV1','isBuy'};
%result_table=table(time,a(:,1),a(:,2),a(:,3),a(:,4),a(:,5),a(:,6),a(:,7),'VariableNames',title);
%writetable(result_table,[char(output_folder),'\',name_title,'-processed',tail]);
end


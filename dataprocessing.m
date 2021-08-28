clc;clear;
filename='SH600000-1.csv';
fid=fopen(filename);
row = 0;
unit = 1;%control the step of time
while ~feof(fid)
    row = row + 1;%get the row of the table
    fgetl(fid);
end
fclose(fid);
fid=fopen(filename);
array=textscan(fid,'%s %s %*[^\n]');
time_origin=array{1,2};%get the origin time of minutes, but it needs further processing
for i=2:(row)
    temp=strsplit(time_origin{i,1},',');
    time{i-1,1}=temp{1,1};
end
fclose(fid);
time=string(cell2mat(time));
a=csvread(filename,1,1,[1,1,(row-1),16]);%read the numerical data from the csv file
j=0;%to change data
i=1;%count the number of the loop
while 1
    time_cut=strsplit(time(j+1,1),':');
    time_front=str2double(time_cut{1,2});%get the minute of the current time
    if i==1
        temp_time=time_front;%latest value of minute
    else 
        if time_front==temp_time
            time(j,:)=[];
            a(j,:)=[];
            j=j-1;
        elseif time_front == (temp_time+unit)
            temp_time=time_front;%renew the latest time
        else
            time=[time(1:j);time(j,1);time((j+1):end)];
            time(j+1,1)=time_cut{1,1}+":"+num2str(temp_time+unit)+":"+time_cut{1,3};
            a=[a(1:j,:);a(j,:);a(j+1:end,:)];
            temp_time=temp_time+unit;
            %j=j-1;
        end
    end
    sz=size(time);
    if sz(1)==(j+1)
        break;
    end
    j=j+1;i=i+1;
end
for i=1:sz(1)%sum the volume
    if i==1
    else
        a(i,2)=a(i-1,2)+a(i,2);
    end
end
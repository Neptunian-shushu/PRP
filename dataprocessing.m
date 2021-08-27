clc;clear;
filename='SH000001-1.csv';
fid=fopen(filename);
row = 0;
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
time{2,1};%get the time of minutes
fclose(fid);
a=csvread(filename,1,1,[1,1,(row-1),16]);%read the numerical data from the csv file
j=0;%to change data
for i=1:(row-1)%to change time
    time_cut=strsplit(time{i,1},':');
    time_front=time_cut{1,2};%get the minute of the current time
    if i==1
        temp_time=time_front;%latest value of minute
    else 
        if time_front==temp_time
            time{i-1,1}=[];
            a(j,:)=[];
            j=j-1;
        else
            temp_time=time_front;%renew the latest time
        end
    end
    j=j+1;
end
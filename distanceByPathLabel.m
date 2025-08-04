function [lengths, distanceByCategory]=distanceByPathLabel(data,numOfPaths)
lengths=cell(numOfPaths,3); %Create empty array with rows=number of paths columns will be path, category, distance in that order
r=1; %row counter
d=0;
for i=2:size(data,1) %Get distances of each path
    if i<size(data,1)
    if isequal(data(i,4),data(i+1,4)) %if path number is the same
        d=d+cell2mat(data(i,12)); 
        lengths(r,3)=num2cell(d);
        lengths(r,1)=data(i,4); %Get path number
        lengths(r,2)=data(i,5);
    else
        d=d+cell2mat(data(i,12)); 
        lengths(r,3)=num2cell(d);%need to add final distance for current data point
        lengths(r,1)=data(i,4); %Get path number
        lengths(r,2)=data(i,5);
        d=0;
        r=r+1; %Go to next row
    end
    else
        d=d+cell2mat(data(i,12)); 
        lengths(r,3)=num2cell(d);%need to add final distance for current data point
        lengths(r,1)=data(i,4); %Get path number
        lengths(r,2)=data(i,5);
    end
end

finalTableR=zeros(1,5); %s,di,inter,di2,deep column order
s=0;
inter=0;
de=0;
di1=0;
di2=0;
for i=1:size(lengths,1) %Get row number for finalTable by counting each label and finding which occurs most often
    if isequal(lengths(i,2),"Superficial")
        s=s+1;
    elseif isequal(lengths(i,2),"Intermediate")
       inter=inter+1;
    elseif isequal(lengths(i,2),"Deep")
       de=de+1;
    elseif isequal(lengths(i,2),"Diving1")
       di1=di1+1;
    else
       di2=di2+1;
    end        
end

finalTableR(1,1)=s;
finalTableR(1,2)=di1;
finalTableR(1,3)=inter;
finalTableR(1,4)=di2;
finalTableR(1,5)=de;

theRows=max(finalTableR);

finalTable=zeros(theRows,5);
rs=1;
ri=1;
rde=1;
rdi1=1;
rdi2=1;
for i=1:size(lengths,1)
    if isequal(lengths(i,2),"Superficial") %Put distance of superficial paths in column one
        finalTable(rs,1)=cell2mat(lengths(i,3)); 
        rs=rs+1;
    elseif isequal(lengths(i,2),"Diving1") %Put distance of intermediate paths in column two
       finalTable(rdi1,2)=cell2mat(lengths(i,3));
        rdi1=rdi1+1;
    elseif isequal(lengths(i,2),"Intermediate") %Put distance of deep paths in column three
       finalTable(ri,3)=cell2mat(lengths(i,3)); 
        ri=ri+1;
    elseif isequal(lengths(i,2),"Diving2") %Put distance of diving paths in column four
       finalTable(rdi2,4)=cell2mat(lengths(i,3)); 
        rdi2=rdi2+1;
    elseif isequal(lengths(i,2),"Deep")
        finalTable(rde,5)=cell2mat(lengths(i,3)); 
        rde=rde+1;
    end   
end

%Values for results table T
Superficial=finalTable(:,1);
Diving1=finalTable(:,2);
Intermediate=finalTable(:,3);
Diving2=finalTable(:,4);
Deep=finalTable(:,5);

%Add header to path lengths array
header={'Path' 'Category' 'Distance (um)'};
lengths=[header;lengths];

%Create row names for the tables most important for the calculations done
rowN=cell(1,size(finalTable,1));
for x=1:size(finalTable,1)
    rowN(x)=cellstr('Path Count '+string(x));
end
% rowN(end+1)=cellstr('LABEL');

distanceByCategory=table(Superficial,Diving1,Intermediate,Diving2,Deep,'RowNames',rowN);

end

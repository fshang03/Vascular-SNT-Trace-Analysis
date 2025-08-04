function zTable = sumDistanceByZ2 (dataArray)

allzValue=dataArray(3:end,10);
allDistances=dataArray(3:end,12);

holdtable=cat(2,allzValue,allDistances);
sortedTable=sortrows(holdtable,1);

i=size(unique(cell2mat(allzValue)),1);

zValue=zeros(i,1);
sumOfPaths=zeros(i,1);
r=1; %row counter
d=0;

for i=1:size(sortedTable,1) %Get distances of each path
    if i<size(sortedTable,1)
        if isequal(sortedTable(i,1),sortedTable(i+1,1)) %if z value is the same
            d=d+cell2mat(sortedTable(i,2)); 
            sumOfPaths(r)=d;
            zValue(r)=cell2mat(sortedTable(i,1)); %Get z value
        else
            d=d+cell2mat(sortedTable(i,2)); 
            sumOfPaths(r)=d;
            zValue(r)=cell2mat(sortedTable(i,1));
            d=0;
            r=r+1; %Go to next row
        end
    else
        d=d+cell2mat(sortedTable(i,2)); 
        sumOfPaths(r)=d;
        zValue(r)=cell2mat(sortedTable(i,1));
    end
end
header=["Z Values", "Sum (um)"];
zTable=table(zValue,sumOfPaths,'VariableNames',header);
end
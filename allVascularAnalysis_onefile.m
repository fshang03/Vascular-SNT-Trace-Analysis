clear;
clc;

fnames="4346L_C57GCaMP_20250114_60x_Bright_SNT_Data.traces.csv";
    fromSNT=readcell(fnames);

%Get rescale z values
ii=1;
index=zeros(1,2);
for i=2:size(fromSNT,1)
    if isequal(fromSNT(i,5),"CellRescalePoint")
        index(ii)=i;
        ii=ii+1;
    end
end

z1=cell2mat(fromSNT(index(1),3));
z2=cell2mat(fromSNT(index(2),3));
hold=z1;

if z1<z2
else
    z1=z2; %make sure lower z value is p1
    z2=hold;
end

hold=z2-z1; %Hold now equals max - min for normalization

%Take out rescale points from table
removepoints=fromSNT;
removepoints(index(1),:)=[];
removepoints(index(2)-1,:)=[];

%Count number of paths
    pathNum=0;
for i=3:size(removepoints,1)
    if isequal(removepoints(i,4),removepoints(i-1,4))
    else
        pathNum=pathNum+1;
    end
end

% plotTheVasculature2(removepoints,pathNum,fnames); %Color coded 3D plot

dataWithXYZDistance=distanceBetweenPoints2(removepoints,z1,hold); %Adds XD YD ZD and Distance between two points columns to original data
dataWithPathDistance=distanceBetweenEndPoints(dataWithXYZDistance,pathNum);

writecell(dataWithXYZDistance,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Xd Yd Zd Distance');

zTable=sumDistanceByZ2(dataWithXYZDistance);
writetable(zTable,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Distance by Z');

[lengths, distanceByCategory]=distanceByPathLabel2(dataWithXYZDistance,pathNum);
writecell(lengths,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Path Lengths');
writetable(distanceByCategory,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Distance by Category');

[theStraightPath, tortuosityByCategory]=lengthOfPath(dataWithPathDistance,lengths,pathNum);
writecell(theStraightPath,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Tortuosity');
writecell(tortuosityByCategory,"C:\Users\fshang\OneDrive - University of Rochester\Documents\NG2Akita\60x\Results\"+extractBefore(fnames,"SNT")+"Analysis1.xlsx",'Sheet','Tortuosity by Category');
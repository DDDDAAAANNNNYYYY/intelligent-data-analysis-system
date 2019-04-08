function GetIconData
% 16*16像素，数值0～１，8位色除以255，16位色除以65535
% BackgroundColor=[0.93,0.93,0.93]; % 当为png文件时，更改背景色
BackgroundColor=[0.2,0.2,0.2]; % 当为png文件时，更改背景色
[cdata,colormap] = imread('..\icon\Open.png','BackgroundColor',BackgroundColor);
new = double(cdata)/65535;
[cdata,colormap] = imread('..\icon\refresh.png','BackgroundColor',BackgroundColor);
Refresh = ind2rgb(cdata,colormap);  % 注意，打开的为png文件，却跟Zoom不一样
[cdata,colormap] = imread('..\icon\Layout.gif');
Layout = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Axis.gif');
Axis = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Copy.gif');
Copy = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Zoom.png','BackgroundColor',BackgroundColor);
Zoom = double(cdata)/65535;
[cdata,colormap] = imread('..\icon\First.gif');
First = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Previous.gif');
Previous = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Next.gif');
Next = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\Last.gif');
Last = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\print.gif');
Print = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\search1.gif');
Search = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\lineSize.png');
lineSize = cdata;
[cdata,colormap] = imread('..\icon\lookup.gif');
Lookup = ind2rgb(cdata,colormap);
[cdata,colormap] = imread('..\icon\pan.gif');
Pan = ind2rgb(cdata,colormap);
[Datacursor,~] = imread('..\icon\datacursor.png');
[AIicon,~] = imread('..\icon\AIicon.png');
%% alter the background to transparent
[ii,jj]=find(all(new==1,3));
for i=1:length(ii)
    new(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Print==1,3));
for i=1:length(ii)
    Print(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Refresh==1,3));
for i=1:length(ii)
    Refresh(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Layout==1,3));
for i=1:length(ii)
    Layout(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Axis==1,3));
for i=1:length(ii)
    Axis(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Copy==1,3));
for i=1:length(ii)
    Copy(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Zoom==1,3));
for i=1:length(ii)
    Zoom(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(First==1,3));
for i=1:length(ii)
    First(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Previous==1,3));
for i=1:length(ii)
    Previous(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Next==1,3));
for i=1:length(ii)
    Next(ii(i),jj(i),:)=nan;
end


[ii,jj]=find(all(Last==1,3));
for i=1:length(ii)
    Last(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Last==1,3));
for i=1:length(ii)
    Last(ii(i),jj(i),:)=nan;
end
    
[ii,jj]=find(all(Search==1,3));
for i=1:length(ii)
    Search(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(lineSize==1,3));
for i=1:length(ii)
    lineSize(ii(i),jj(i),:)=nan;
end
% imwrite(rgb,'lineSize.png');

[ii,jj]=find(all(Lookup==1,3));
for i=1:length(ii)
    Lookup(ii(i),jj(i),:)=nan;
end

[ii,jj]=find(all(Pan==1,3));
for i=1:length(ii)
    Pan(ii(i),jj(i),:)=nan;
end


save('icondata.mat','new','Print','Refresh','Layout','Axis','Copy','Zoom','First','Previous','Next','Last','Search','lineSize','Lookup','Pan','Datacursor','AIicon');
function createdatatip(varargin)

% clear old datatip
h1=findobj(gca,'Tag','datatip');
h2=findobj(gca,'Tag','datatipmarker');
% get the coordinates of pointer
gcaUserdata=get(gca,'UserData');
xlim=gcaUserdata.xlim;
ylim=gcaUserdata.ylim;
xdata=get(gcaUserdata.hNearestLine,'Xdata');
ydata=get(gcaUserdata.hNearestLine,'Ydata');
xy=get(gca,'currentPoint');
xPointer=xy(1,1);
% select the nearest line to plot 
if xPointer>xlim(2)  % xdata exceed xlim when axis is zoomed out
    xPointer=xlim(2);
elseif xPointer<xlim(1)
    xPointer=xlim(1);
end
if xPointer>max(xdata)
    xPointer=max(xdata);  % xlim(2) always greater than xdata(end) except axis is zoomed out
elseif xPointer<min(xdata)
    xPointer=min(xdata);
end

% 对非单调数据重新按升序排列，并剔除重复数据
if ~issorted(xdata)
    [xdata_ascend,index]=sort(xdata);
    ydata_ascend=ydata(index);
    indexValid=true(1,length(xdata_ascend));
    for j=2:length(xdata_ascend) % 保留最大值点
        if xdata_ascend(j)==xdata_ascend(j-1)  % 剔除重复数据
            indexValid(j)=false;
        end
    end
    xdata_ascend=xdata_ascend(indexValid);
    ydata_ascend=ydata_ascend(indexValid);
    
    x=interp1(xdata_ascend,xdata_ascend,xPointer,'nearest');
    y=interp1(xdata_ascend,ydata_ascend,x,'nearest');  % Nearest neighbor interpolation
else
    % 数据量较大时，上述方法速度较慢，使用旧方法
    x=interp1(xdata,xdata,xPointer,'nearest');
    y=interp1(xdata,ydata,x,'nearest');  % Nearest neighbor interpolation
end
%% plot datatip
textdisp=num2str([y;x]);
temp=['y: ';'x: '];
textdisp=[temp,textdisp];
set(h2,'Position',[x y])
% create datatip when pressing button
Position=get(gca,'Position');
y=y+0.008*(ylim(2)-ylim(1))/Position(4);
if (xlim(2)-x)/(xlim(2)-xlim(1))*Position(3)<0.03
    x=x-0.004*(xlim(2)-xlim(1))/Position(3);
      set(h1,'Position',[x y],'String',textdisp,'HorizontalAlignment','Right')
else
    x=x+0.004*(xlim(2)-xlim(1))/Position(3);
      set(h1,'Position',[x y],'String',textdisp,'HorizontalAlignment','Left')
end


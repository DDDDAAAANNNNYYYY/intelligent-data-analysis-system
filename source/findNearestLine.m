function hNearestLine=findNearestLine(varargin)
% get handle of the nearest line and save it in userdata,
% if pointer is too far from any line, hNearestLine=-1

% get the coordinates of pointer
hlines=findobj(gca,'Type','line');
xdata=get(hlines,'Xdata');
ydata=get(hlines,'Ydata');
xy=get(gca,'currentPoint');
xlim=get(gca,'xlim');
ylim=get(gca,'ylim');
if ~iscell(xdata)
    xdata={xdata};
    ydata={ydata};
end
if xlim(2)==inf; 
    for i=1:length(xdata)
        xmax(i)=max(xdata{i});
    end
    xlim(2)=max(xmax);
end
xPointer=xy(1,1);
yPointer=xy(1,2);
% select the nearest line to plot 
[m,n]=size(xdata);
y=nan(1,m);

for i=1:m
    % 对非单调数据重新按升序排列，并剔除重复数据
    [xdata_ascend,index]=sort(xdata{i});
    ydata_ascend=ydata{i}(index);
    indexValid=true(1,length(xdata_ascend));
    for j=2:length(xdata_ascend) % 保留最大值点
        if xdata_ascend(j)==xdata_ascend(j-1)  % 剔除重复数据
            indexValid(j)=false;
        end
    end
    xdata_ascend=xdata_ascend(indexValid);
    ydata_ascend=ydata_ascend(indexValid);
    
    if xPointer>=xdata_ascend(1)&&xPointer<=xdata_ascend(end)  % 不同数据文件可能具有不同的x轴取值范围
        x=interp1(xdata_ascend,xdata_ascend,xPointer,'nearest');
        y(i)=interp1(xdata_ascend,ydata_ascend,x,'nearest');  % Nearest neighbor interpolation
    end
end

absy=abs(y-yPointer);
[temp,index]=min(absy);
% don't create datatip if button press in blank
gcaUserdata.xlim=xlim;
gcaUserdata.ylim=ylim;
if absy(index)>0.1*(ylim(2)-ylim(1))
    gcaUserdata.hNearestLine=-1;
    set(gca,'UserData',gcaUserdata);
    return
else
    gcaUserdata.hNearestLine=hlines(index);
    set(gca,'UserData',gcaUserdata);
end

% creat datatip
y=y(index);
x=round(1000*x)/1000;   % round to 1ms
textdisp=num2str([y;x]);
temp=['y: ';'x: '];
textdisp=[temp,textdisp];
%text前两个或前三个参数必须为双精度数值
x=double(x);
text(x,y,'+','Tag','datatipmarker','FontSize',1,'BackgroundColor',[0 0 0]);
Position=get(gca,'Position');
y=y+0.008*(ylim(2)-ylim(1))/Position(4);
% y=round(y,3);
if (xlim(2)-x)/(xlim(2)-xlim(1))*Position(3)<0.03
    x=x-0.004*(xlim(2)-xlim(1))/Position(3);
    text(x,y,textdisp,...
                    'Tag','datatip',...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','Right',...
                    'EdgeColor','k',...
                    'BackgroundColor',[0.7 0.9 0.9]);
else
    x=x+0.004*(xlim(2)-xlim(1))/Position(3);
    text(x,y,textdisp,...
                    'Tag','datatip',...
                    'VerticalAlignment','bottom',...
                    'EdgeColor','k',...
                    'BackgroundColor',[0.7 0.9 0.9]);

end

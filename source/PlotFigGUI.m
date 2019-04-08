function PlotFigGUI
% 绘制menu和Toolbar

h_MainPlotFig=figure('Tag','Main Plot Figure',...
    'Name','Main Plot Figure',...
    'NumberTitle','off',...
    'MenuBar','none',...
    'Toolbar','none',...
    'Units','normalized',...
    'Position',[0,0.0325,1.0000,0.884],...
    'KeyPressFcn',@KeyPressFcn,...
    'CloseRequestFcn',@CloseRequestFcn);
%% Warning: figure JavaFrame property will be obsoleted in a future release.
chgicon(h_MainPlotFig,'network.png');
% change figure icon
% figIcon=javax.swing.ImageIcon('icon.ico');
% figFrame.setFigureIcon(figIcon);  % 区分大小写，SetFigureIcon不可用

% maximize the figure window
figFrame=get(handle(h_MainPlotFig),'JavaFrame');
figFrame.setMaximized(true);
% figFrame.setAlwaysOnTop(1); %将figure置顶
drawnow;
%
%%
% GetIconData;
%尽量不使用icondata.mat文件，方便生产exe
[new,Print,Refresh,Layout,Axis,Copy,Zoom,First,Previous,Next,Last,Search,lineSize,Lookup,Pan,Datacursor,AIicon]=load_icondata();
% load icondata.mat;

%%
handles.customtoolbar=uitoolbar(h_MainPlotFig,'Tag','ViewToolBar');
handles.NewIDAS=uipushtool(handles.customtoolbar,'CData',new,...
    'TooltipString','New Figure','Separator','on',...
    'ClickedCallback',@newIDAS_ClickedCallback);
handles.Print=uipushtool(handles.customtoolbar,'CData',Print,...
    'TooltipString','Print Preview','Separator','on',...
    'ClickedCallback',@printpreview);
handles.Layout=uipushtool(handles.customtoolbar,'CData',Layout,'TooltipString','Layout','ClickedCallback',@Layout_Callback);
handles.Refresh=uipushtool(handles.customtoolbar,'CData',Refresh,...
    'TooltipString','Refresh','Separator','on','ClickedCallback',{@PlotFig,'refresh'});
handles.Axis=uipushtool(handles.customtoolbar,'CData',Axis,...
    'TooltipString','Axis','Separator','on','ClickedCallback',@SetTime);
handles.Pan=uitoggletool(handles.customtoolbar,'CData',Pan,...
    'TooltipString','Pan','Separator','on','OnCallback','pan xon','OffCallback','pan off');
handles.Copy=uipushtool(handles.customtoolbar,'CData',Copy,...
    'TooltipString','Copy','Separator','on','ClickedCallback','print -dmeta');
handles.Zoom=uitoggletool(handles.customtoolbar,'CData',Zoom,...
    'TooltipString','Zoom','Separator','on','OnCallback',@zoomon,'OffCallback',@zoomoff);
handles.Datacursor=uitoggletool(handles.customtoolbar,'CData',Datacursor,...
    'TooltipString','datacursor','Separator','on','OnCallback','datacursormode on','OffCallback','datacursormode off');
handles.First=uipushtool(handles.customtoolbar,'CData',First,...
    'TooltipString','First','Separator','on','ClickedCallback',{@DispFigure,1});
handles.Previous=uipushtool(handles.customtoolbar,'CData',Previous,...
    'TooltipString','Previous','Separator','on','ClickedCallback',{@DispFigure,2});
handles.Next=uipushtool(handles.customtoolbar,'CData',Next,...
    'TooltipString','Next','Separator','on','ClickedCallback',{@DispFigure,3});
handles.Last=uipushtool(handles.customtoolbar,'CData',Last,...
    'TooltipString','Last','Separator','on','ClickedCallback',{@DispFigure,4});
handles.SetLineWidth=uipushtool(handles.customtoolbar,'CData',lineSize,...
    'TooltipString','Line Width','Separator','on','ClickedCallback',@SetLineWidth);
handles.search=uipushtool(handles.customtoolbar,'CData',Search,...
    'TooltipString','Search varible','Separator','on','ClickedCallback',@SearchVarible);
handles.lookup=uipushtool(handles.customtoolbar,'CData',Lookup,...
        'TooltipString','Atmosphere Query','Separator','on','ClickedCallback',@atomquery);
%     'TooltipString','大气数据查询','Separator','on','ClickedCallback','dos(''atomquery1dot6 &'')');
handles.AICompute=uipushtool(handles.customtoolbar,'CData',AIicon,...
        'TooltipString','Intelligent Compute','Separator','on','ClickedCallback',@AICompute);




h0_menu=uimenu('Label','File');
h01_submenu=uimenu(h0_menu,...
    'Label','New Figure',...
    'Accelerator','N',...
    'Callback',@newIDAS_ClickedCallback);
h02_submenu=uimenu(h0_menu,...
    'Label','Print Preview',...
    'Accelerator','P',...
    'Callback',@printpreview);

% --- create menu
h1_menu=uimenu('Label','Figure');
h11_submenu=uimenu(h1_menu,...
    'Label','X-Limit',...
    'Callback',@SetTime);
h12_submenu=uimenu(h1_menu,...
    'Label','Copy Figure',...
    'Callback','print -dmeta -opengl',...
    'Accelerator','F',...
    'separator','on');
h13_submenu=uimenu(h1_menu,...
    'Label','Refresh Figure',...
    'Accelerator','r',...
    'Callback',@Refresh_ClickedCallback);
%%%%%%%%%
h14_submenu=uimenu(h1_menu,...
    'Label','First Figure       Home',...
    'Callback',{@DispFigure,1},...
    'separator','on');
h15_submenu=uimenu(h1_menu,...
    'Label','Previous Figure    ←',...
    'Callback',{@DispFigure,2});
h16_submenu=uimenu(h1_menu,...
    'Label','Next Figure        →',...
    'Callback',{@DispFigure,3});
h17_submenu=uimenu(h1_menu,...
    'Label','Last Figure        End',...
    'Callback',{@DispFigure,4});
h18_submenu=uimenu(h1_menu,'Label','Layout','separator','on','Callback',@Layout_Callback);
%%%
h19_submenu=uimenu(h1_menu,...
    'Tag','Zoom',...
    'Label','Zoom on',...
    'Accelerator','Z',...
    'Callback',@zoomon,...
    'separator','on');

%%%%%%%%%%
h2_menu=uimenu('Label','Manual');
h2_submenu=uimenu(h2_menu,...
    'Label','ManualBook',...
    'Callback',@openmanual);%'winopen(''Manual.doc'')');
h3_menu=uimenu('Label','Exit');
h31_submenu=uimenu(h3_menu,...
    'Label','Exit IDAS',...
    'Accelerator','E',...
    'Callback',@CloseRequestFcn);

%% setting for print
% Setting the Figure Size and Position
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [1.5 1.5 25.7 16.6]); % [left bottom width height]
% Setting the Paper Size or Type
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperType', 'A4');
% Setting the Paper Orientation
set(gcf, 'PaperOrientation', 'Rotated');
% % Selecting a Renderer
% set(gcf, 'Renderer', 'painters'); % equal to: print -painters
% % Setting Line and Text Characteristics
% lineobj = findobj('type', 'line');
% set(lineobj, 'linewidth', 1.5);








%-----------subfunction----------------
function KeyPressFcn(varargin)
hobj=[];
eventdata=[];
% if strcmp(eventdata.Modifier{1},'control')
switch get(gcf,'CurrentKey')
    case 'home'
        DispFigure(hobj,eventdata,1);
    case 'leftarrow'
        DispFigure(hobj,eventdata,2);
    case 'rightarrow'
        DispFigure(hobj,eventdata,3);
    case 'end'
        DispFigure(hobj,eventdata,4);
    otherwise
        return
end
% end


%-----------subfunction----------------
function CloseRequestFcn(hobject,eventdata,varargin)

savepara;
h_MainPlotFig = findobj('Tag','Main Plot Figure');
delete(h_MainPlotFig);
h_IDAS = findobj('Name','IDAS');
if strcmp(get(h_IDAS,'Visible'),'off')
    delete(h_IDAS);
    clear;
end



%-----------subfunction----------------
function newIDAS_ClickedCallback(varargin)
h_IDAS = findobj('Name','IDAS');
if isempty(h_IDAS)
    IDASv2;
else
    set(h_IDAS,'Visible','on')
end





%-----------subfunction----------------
function Layout_Callback(hobj,eventdata,varargin)
global layout

handles.layout=dialog('Name','layout','NumberTitle','off',...
    'Toolbar','none','Units','normalized','Position',[0.4,0.4,0.2,0.25]);
handle.buttongroup = uibuttongroup(handles.layout,'Tag','buttongroup','Units','normalized','Position',[0.05,0.05,0.9,0.9]);
handles.layout_sel11=uicontrol(handle.buttongroup,'Style','Radio','String','1 X 1',...
    'Units','normalized','Position',[0.03,0.83,0.17,0.1]);
handles.layout_sel12=uicontrol(handle.buttongroup,'Style','Radio','String','1 X 2',...
    'Units','normalized','Position',[0.23,0.83,0.17,0.1]);
handles.layout_sel13=uicontrol(handle.buttongroup,'Style','Radio','String','1 X 3',...
    'Units','normalized','Position',[0.43,0.83,0.17,0.1]);
handles.layout_sel14=uicontrol(handle.buttongroup,'Style','Radio','String','1 X 4',...
    'Units','normalized','Position',[0.63,0.83,0.17,0.1]);
handles.layout_sel15=uicontrol(handle.buttongroup,'Style','Radio','String','1 X 5',...
    'Units','normalized','Position',[0.83,0.83,0.17,0.1]);
handles.layout_sel21=uicontrol(handle.buttongroup,'Style','Radio','String','2 X 1',...
    'Units','normalized','Position',[0.03,0.66,0.17,0.1]);
handles.layout_sel22=uicontrol(handle.buttongroup,'Style','Radio','String','2 X 2',...
    'Units','normalized','Position',[0.23,0.66,0.17,0.1]);
handles.layout_sel23=uicontrol(handle.buttongroup,'Style','Radio','String','2 X 3',...
    'Units','normalized','Position',[0.43,0.66,0.17,0.1]);
handles.layout_sel24=uicontrol(handle.buttongroup,'Style','Radio','String','2 X 4',...
    'Units','normalized','Position',[0.63,0.66,0.17,0.1]);
handles.layout_sel25=uicontrol(handle.buttongroup,'Style','Radio','String','2 X 5',...
    'Units','normalized','Position',[0.83,0.66,0.17,0.1]);
handles.layout_sel31=uicontrol(handle.buttongroup,'Style','Radio','String','3 X 1',...
    'Units','normalized','Position',[0.03,0.49,0.17,0.1]);
handles.layout_sel32=uicontrol(handle.buttongroup,'Style','Radio','String','3 X 2',...
    'Units','normalized','Position',[0.23,0.49,0.17,0.1]);
handles.layout_sel33=uicontrol(handle.buttongroup,'Style','Radio','String','3 X 3',...
    'Units','normalized','Position',[0.43,0.49,0.17,0.1]);
handles.layout_sel34=uicontrol(handle.buttongroup,'Style','Radio','String','3 X 4',...
    'Units','normalized','Position',[0.63,0.49,0.17,0.1]);
handles.layout_sel35=uicontrol(handle.buttongroup,'Style','Radio','String','3 X 5',...
    'Units','normalized','Position',[0.83,0.49,0.17,0.1]);
handles.layout_sel41=uicontrol(handle.buttongroup,'Style','Radio','String','4 X 1',...
    'Units','normalized','Position',[0.03,0.32,0.17,0.1]);
handles.layout_sel42=uicontrol(handle.buttongroup,'Style','Radio','String','4 X 2',...
    'Units','normalized','Position',[0.23,0.32,0.17,0.1]);
handles.layout_sel43=uicontrol(handle.buttongroup,'Style','Radio','String','4 X 3',...
    'Units','normalized','Position',[0.43,0.32,0.17,0.1]);
handles.layout_sel44=uicontrol(handle.buttongroup,'Style','Radio','String','4 X 4',...
    'Units','normalized','Position',[0.63,0.32,0.17,0.1]);
handles.layout_sel45=uicontrol(handle.buttongroup,'Style','Radio','String','4 X 5',...
    'Units','normalized','Position',[0.83,0.32,0.17,0.1]);
handles.layout_sel51=uicontrol(handle.buttongroup,'Style','Radio','String','5 X 1',...
    'Units','normalized','Position',[0.03,0.15,0.17,0.1]);
handles.layout_sel52=uicontrol(handle.buttongroup,'Style','Radio','String','5 X 2',...
    'Units','normalized','Position',[0.23,0.15,0.17,0.1]);
handles.layout_sel53=uicontrol(handle.buttongroup,'Style','Radio','String','5 X 3',...
    'Units','normalized','Position',[0.43,0.15,0.17,0.1]);
handles.layout_sel54=uicontrol(handle.buttongroup,'Style','Radio','String','5 X 4',...
    'Units','normalized','Position',[0.63,0.15,0.17,0.1]);
handles.layout_sel55=uicontrol(handle.buttongroup,'Style','Radio','String','5 X 5',...
    'Units','normalized','Position',[0.83,0.15,0.17,0.1]);

handles.layout_OK=uicontrol(handle.buttongroup,'Style','pushbutton','Tag','ok','string','OK',...
    'Units','normalized','Position',[0.8,0.02,0.2,0.1],'Callback',@LayoutOK_Callback);

selecthandle=eval(['handles.layout_sel',num2str(layout.m,'%1i'),num2str(layout.n,'%1i')]);
set(handle.buttongroup,'SelectedObject',selecthandle);


%-----------subfunction----------------
function LayoutOK_Callback(hobj,eventdata,varargin)

global layout nvar_selected n_windows                % 供DispFigure.m使用
global idasdata File x_label index_selected i_windows    % 保存数据，供绘制下一图

handles.buttongroup  = findobj(gcf,'tag','buttongroup');
handles.layout_selectbutton=get(handles.buttongroup,'SelectedObject');
% switch get(eventdata.NewValue,'string');
switch get(handles.layout_selectbutton,'string');
    case '1 X 1'
        layout.m=1;layout.n=1;
    case '1 X 2'
        layout.m=1;layout.n=2;
    case '1 X 3'
        layout.m=1;layout.n=3;
    case '1 X 4'
        layout.m=1;layout.n=4;
    case '1 X 5'
        layout.m=1;layout.n=5;
    case '2 X 1'
        layout.m=2;layout.n=1;
    case '2 X 2'
        layout.m=2;layout.n=2;
    case '2 X 3'
        layout.m=2;layout.n=3;
    case '2 X 4'
        layout.m=2;layout.n=4;
    case '2 X 5'
        layout.m=2;layout.n=5;
    case '3 X 1'
        layout.m=3;layout.n=1;
    case '3 X 2'
        layout.m=3;layout.n=2;
    case '3 X 3'
        layout.m=3;layout.n=3;
    case '3 X 4'
        layout.m=3;layout.n=4;
    case '3 X 5'
        layout.m=3;layout.n=5;
    case '4 X 1'
        layout.m=4;layout.n=1;
    case '4 X 2'
        layout.m=4;layout.n=2;
    case '4 X 3'
        layout.m=4;layout.n=3;
    case '4 X 4'
        layout.m=4;layout.n=4;
    case '4 X 5'
        layout.m=4;layout.n=5;
    case '5 X 1'
        layout.m=5;layout.n=1;
    case '5 X 2'
        layout.m=5;layout.n=2;
    case '5 X 3'
        layout.m=5;layout.n=3;
    case '5 X 4'
        layout.m=5;layout.n=4;
    case '5 X 5'
        layout.m=5;layout.n=5;
end
delete(gcf)
%-----------------plot----------------
n_windows = fix(nvar_selected/(layout.m*layout.n));%B = fix(A) rounds the elements of A toward zero, resulting in an array of integers
if mod(nvar_selected,layout.m*layout.n)~=0
    n_windows=n_windows+1;
end

i_windows=1;
if i_windows<n_windows && n_windows~=1
    index_plot=index_selected((layout.m*layout.n*(i_windows-1)+1):layout.m*layout.n*i_windows);
else
    index_plot=index_selected((layout.m*layout.n*(i_windows-1)+1):nvar_selected);
end
PlotAxes(File,index_plot,idasdata,layout,x_label);
EnableMenu(i_windows,n_windows);
savepara;
% ------保持修改布局前的坐标轴范围设置---------
h_MainPlotFig = findobj('Tag','Main Plot Figure');
xlim_property=get(h_MainPlotFig,'Userdata');
h_line = findobj(h_MainPlotFig,'Tag','line');
h_axes=get(h_line,'Parent');
if iscell(h_axes)
    h_axes = cell2mat(h_axes);
end
xlim=[xlim_property(1),xlim_property(2)];
set(h_axes,'xlim',xlim);



%-----------subfunction----------------
function SetTime(hObject, eventdata, handles)


h_MainPlotFig = findobj('Tag','Main Plot Figure');
xlim_property=get(h_MainPlotFig,'Userdata');  % 在PlotFig中初始化

h_line = findobj(h_MainPlotFig,'Tag','line');
h_axes=get(h_line,'Parent');
if iscell(h_axes)
    h_axes = cell2mat(h_axes);
end

% input time limits
prompt = {'Xmin :','Xmax :'};
dlg_title = 'X-Limit';
num_lines = 1;
def={num2str(xlim_property(1)),num2str(xlim_property(2))};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return
else
    xmin=str2double(answer{1});
    xmax=str2double(answer{2});
    xlim_property=[xmin xmax];
    set(h_axes,'xlim',xlim_property)
end
set(h_MainPlotFig,'Userdata',xlim_property);  % 供DispFigure、Export使用



%----------------------subfunction------------------
function zoomon(varargin)
zoom on;
h1=findobj('Tag','Zoom');
set(h1,'Label','Zoom off','Callback',@zoomoff);
h2=findobj('TooltipString','Zoom');
set(h2,'State','on');

%----------------------subfunction------------------
function zoomoff(varargin)
zoom off;
h1=findobj('Tag','Zoom');
set(h1,'Label','Zoom on','Callback',@zoomon);
h2=findobj('TooltipString','Zoom');
set(h2,'State','off');


% --- 设置线宽 ---
function SetLineWidth(varargin)

hlines=findobj(gcf,'Type','line');
LineWidth=get(hlines(1),'LineWidth');
if LineWidth==1
    set(hlines,'LineWidth',2);
else
    set(hlines,'LineWidth',1);
end


%----------------------subfunction------------------
function openmanual(varargin)

winopen('Manual.doc');
% % % %----------------------replace winopen with next function ------------------
% % % function openmanual(fileName)
% % % % directory containing winword.exe can be obtained from the following registry query for all versions of Word
% % % appexepath = winqueryreg('HKEY_LOCAL_MACHINE','SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\winword.exe','Path');
% % % wordPath = appexepath;
% % % % Open or create the specified file.
% % % fileName='Manual.doc';
% % % absFilename = fullfile(pwd,fileName);
% % % dos(['"' wordPath '\winword.exe" "' absFilename '"&']);



%-----------subfunction----------------
function SearchVarible(hObject, eventdata, handles)

global i_windows layout index_selected

% input GUI
prompt = {'varible name :'};
dlg_title = 'Search varible';
num_lines = 1;
def = {''};
answer = inputdlg(prompt,dlg_title,num_lines,def);
% search action
if isempty(answer)
    return
else
    handles=GetHandles;
    orderstr=get(handles.varorder,'string');
    varlist=get(handles.varlist,'string');
    % 判断变量所在位置,strcmpi不区分大小写
    % 变量选中方式：
    % 1. 来自排序列表
    % 2. 来自变量列表，仅部分选中
    % 3. 来自变量列表，全部选中
    index=[];
    if length(index_selected)~=length(varlist) % 仅变量列表中的部分变量绘出
        plotlist=varlist(index_selected);
        for i=1:length(plotlist)
            if strcmpi(plotlist{i},answer{1})
                index=i;
                break;
            end
        end
        if isempty(index) % 如果未找到，进一步检查变量是否存在于变量列表中
            for i=1:length(varlist)
                if strcmpi(varlist{i},answer{1})
                    index=i;
                    break;
                end
            end
            if ~isempty(index)  % 变量在列表中，提示选中
                warndlg('Absence of the searching variable！');
                return
            end
        end
    else % 变量列表中的所有变量均绘出
        for i=1:length(varlist)
            if strcmpi(varlist{i},answer{1})
                index=i;
                break;
            end
        end
    end
    if isempty(index)
        errordlg('变量不存在！');
        return
    end
    i_windows = fix(index/(layout.m*layout.n));%B = fix(A) rounds the elements of A toward zero, resulting in an array of integers
    if mod(index,layout.m*layout.n)~=0
        i_windows=i_windows+1;
    end
    i_windows=i_windows-1;% 回退至上一页
    DispFigure(hObject,eventdata,3);% 绘制下一页
end


function AICompute(hObject, eventdata, handles)
% I should creat another fig to tell this part in the late future
errordlg('Not yet upload this subprogram');
return;
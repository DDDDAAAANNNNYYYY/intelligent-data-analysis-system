function DispFigure(hobj,eventdata,flag,varargin)
% First,previous,next,last menu callback function

global  n_windows layout nvar_selected 
global idasdata File x_label index_selected i_windows

switch flag
    case 1
        i_windows=1;
    case 2
        i_windows=i_windows-1;
    case 3
        i_windows=i_windows+1;
    case 4
        i_windows=n_windows;
end

if i_windows<n_windows && n_windows~=1
    index_plot=index_selected((layout.m*layout.n*(i_windows-1)+1):layout.m*layout.n*i_windows);
else
    index_plot=index_selected((layout.m*layout.n*(i_windows-1)+1):nvar_selected);
end
PlotAxes(File,index_plot,idasdata,layout,x_label);
EnableMenu(i_windows,n_windows)

% settime
h_MainPlotFig = findobj('Tag','Main Plot Figure');
h_line = findobj('Tag','line');
h_axes=get(h_line,'Parent');
if iscell(h_axes)
    h_axes = cell2mat(h_axes);
end
xlim_property=get(h_MainPlotFig,'Userdata');  % initialize in settime
% if isequal(xlim_property,'auto')
%     set(h_axes,'XLimMode',xlim_property);
% elseif isempty(xlim_property)   % add for running DispFigure for the first time without running Settime before
%     % default 'auto'
% else
set(h_axes,'xlim',xlim_property);
% end
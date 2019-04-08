function file=GetFiletoPlot(handles,varargin)
% get the file name of the data file to plot

filelist = get(handles.filelist,'String');
index_selected=get(handles.filelist,'value');
file=filelist(index_selected);
if(get(handles.extend_comp,'value'))
    filelist_comp = get(handles.filelist_comp,'String');
    index_selected_comp=get(handles.filelist_comp,'value');
    file_comp=filelist_comp(index_selected_comp);
    file=[file;file_comp];
end

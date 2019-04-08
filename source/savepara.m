function savepara(varargin)

global layout rootpath  % initialized when import IDASpara

handles=GetHandles;
% headerfile=get(handles.editbox_headerfile,'String');
datafiles=get(handles.filelist,'String');
datafiles_comp=get(handles.filelist_comp,'String');
extendcmp=get(handles.extend_comp,'value');
newDocument=get(handles.newDocument,'value');
varlist=get(handles.varlist,'String');
fullPathName_Export=get(handles.Export,'userdata');

% if isempty(headerfile)||isempty(datafiles)||isempty(datafiles_comp)
%    return 
% end
% if iscell(headerfile)
%    headerfile=headerfile{1}; 
% end

% save layout
fid=fopen(fullfile(rootpath,'IDASpara.dat'),'wt');
fprintf(fid,'%5i%5i\n',layout.m,layout.n);
% % save hearder file
% fprintf(fid,'%s\n',headerfile);
% save filelist
fprintf(fid,'%i\n',length(datafiles));
for i=1:length(datafiles)
    fprintf(fid,'%s\n',datafiles{i});
end
% save filelist_comp
fprintf(fid,'%i\n',length(datafiles_comp));
for i=1:length(datafiles_comp)
    fprintf(fid,'%s\n',datafiles_comp{i});
end
% save varorder
orderdata=get(handles.varorder,'Userdata');
if ~isempty(orderdata)
   fprintf(fid,'%5i',orderdata); 
   fprintf(fid,'\n');
end
% save extend_comp checkbox
if extendcmp
    fprintf(fid,'%s\n','on');
else
    fprintf(fid,'%s\n','off');
end
% save newDocument checkbox
if newDocument
    fprintf(fid,'%s\n','on');
else
    fprintf(fid,'%s\n','off');
end
fprintf(fid,'%s\n',fullPathName_Export);
fclose(fid);


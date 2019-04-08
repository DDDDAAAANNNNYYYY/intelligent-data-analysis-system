function chgicon(hfig,iconFile)
% we advise to use 16*16 or larger .png file, to see more icon in the file:
% C:\Program Files\MATLAB\R2018b\toolbox\nnet\nnresource
% When the file is compiled to DLL and called by VC, the png file should be
% stored under the path of dll file or the include file path

% error(nargchk(2, 2, nargin));
% NARGCHK should not be used in the following version, please use NARGINCHK
% or NARGOUTCHK instead.
narginchk(2, 2);
if ~isequal(get(hfig,'type'),'figure')
   error('Input 1 is not a figure handle.') 
end
NumbertitleFlag=false;
if isequal(get(hfig,'Numbertitle'),'on')
    set(hfig,'Numbertitle','off');
    NumbertitleFlag=true;
end
nameFlag=false;
if isempty(get(hfig,'name'))
    set(hfig,'name','temp');
    nameFlag=true;
end
drawnow  
figName=get(hfig,'name');
mde=com.mathworks.mde.desk.MLDesktop.getInstance;  
jfig=mde.getClient(figName); % get the underlying java object of the fig.
jfig.setClientIcon(javax.swing.ImageIcon(iconFile)); %error if drawnow missing

if NumbertitleFlag
    set(hfig,'Numbertitle','on');
end
if nameFlag
    set(hfig,'name','');
end
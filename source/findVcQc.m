function findVcQc(varargin)
% query for QCOPS and velocity verdict


handles.findVcQc=dialog('Name','query for QCOPS and velocity verdict','NumberTitle','off',...
    'Toolbar','none','Units','normalized','Position',[0.4,0.4,0.2,0.25]);
handles.text_mach=uicontrol(handles.findVcQc,'Style','text',...
                                'String','Mach     =',...
                                'HorizontalAlignment','left',...
                                'Units','normalized',...
                                'fontsize',12,...
                                'Position',[0.1 0.75 0.3 0.12]);
handles.editbox_mach=uicontrol(handles.findVcQc,'Style','edit',...
                                'Tag','mach',...      
                                'string','0.6',...
                                'BackgroundColor','white',...
                                'FontSize',12,...
                                'Units','normalized',...
                                'Position',[0.4 0.75 0.4 0.12],...
                                'Callback',@calculate);
handles.text_altde=uicontrol(handles.findVcQc,'Style','text',...
                                'String','Altde     =                                   m',...
                                'HorizontalAlignment','left',...
                                'Units','normalized',...
                                'fontsize',12,...
                                'Position',[0.1 0.6 0.9 0.12]);
handles.editbox_altde=uicontrol(handles.findVcQc,'Style','edit',...
                                'Tag','altde',...         
                                'string','5000',...
                                'BackgroundColor','white',...
                                'FontSize',12,...
                                'Units','normalized',...
                                'Position',[0.4 0.6 0.4 0.12],...
                                'Callback',@calculate);
handles.result=uicontrol(handles.findVcQc,'Style','text',...
                                'Tag','result',...
                                'String',' ',...         
                                'HorizontalAlignment','left',...
                                'FontSize',12,...
                                'Units','normalized',...
                                'Position',[0.1 0.1 0.8 0.4],...
                                'visible','off');



return
end




function calculate(varargin)

handles.editbox_mach=findobj(gcf,'Tag','mach');
handles.editbox_altde=findobj(gcf,'Tag','altde');
handles.result=findobj(gcf,'Tag','result');
mach=str2double(get(handles.editbox_mach,'string'));
altde=str2double(get(handles.editbox_altde,'string'));
if isempty(mach)||isempty(altde)
    return
end
[VC,QC,PS,SOUND] = FVCQC(mach,altde);
QCOPS=QC/PS;
dispstr=strvcat(['Vc           =   ',num2str(VC,'%8.2f'),'  km/h'],...
    ['SOUND =   ',num2str(SOUND,'%8.2f'),'  m/s'],...
    ['Qc           =   ',num2str(QC,'%8.2f'),'  kg/m^2'],...
    ['Ps           =   ',num2str(PS,'%8.2f'),'  kg/m^2'],...
    ['QCOPS =   ',num2str(QCOPS,'%8.4f')]);
set(handles.result,'String',dispstr,'visible','on');

return
end




function [VC,QC,PRE,SOUND] = FVCQC(MACH,ALTDE)
% Unit:kg/m^2



% COMPUTE SOUND,DENS AND PRE

if ALTDE<=11000
    ETA=1-(2.25569E-5*ALTDE);
    ZTA=ETA^4.2561;
    SOUND=340.43*sqrt(ETA);
else
    ETA=0.751874;
    ZTA=exp(0.5208-1.576883E-4*ALTDE);
    SOUND=295.1891;
end
PRE=10332.27*ETA.*ZTA;

          
% COMPUTE VC
P0=10332.27;
A0=340.43;

FM=MACH;
PP0=PRE./P0;
Q1=((1.0+0.2*FM.*FM)^3.5-1.0)*PP0 ;
if FM>1;  Q1=(166.921*FM^7/(7*FM*FM-1.0)^2.5-1.0)*PP0;  end
QC=Q1*P0;
if Q1<=0.892929
    VC=A0*sqrt(5*((Q1+1)^(2./7)-1));
else
    GG=(Q1+1)/166.921;
    VC0=FM*SOUND/A0;
    EM2=7*VC0*VC0-1;
    VC1=VC0-EM2*((VC0^7-GG*EM2^2.5)/(7.*VC0^6*(2.*VC0^2-1.)));
    while abs(VC1-VC0)>1e-5
        VC0=VC1;
        EM2=7*VC0*VC0-1;
        VC1=VC0-EM2*((VC0^7-GG*EM2^2.5)/(7.*VC0^6*(2.*VC0^2-1.)));
    end
    VC=VC1*A0;  
end
VC=VC*3.6;


return
end
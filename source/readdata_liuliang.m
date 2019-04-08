function [Time,vars]=readdata_liuliang(File,qtotal_position,varlist)

if ~iscell(File)
    File={File};
end

nfile=length(File);
nvar=length(varlist);

idasdata=repmat([],nfile);
for iFile=1:nfile
    idasdata{iFile}.File=File{iFile};
    idasdata{iFile}.varlist=varlist;
    fid=fopen(File{iFile});
    skipline=fgetl(fid);
    data=fscanf(fid,'%f');
    data=reshape(data,nvar+1,[]);
    Time(iFile,:)=data(1,:);
    vars(iFile,:)=data(qtotal_position+1,:);
    fclose(fid);
end

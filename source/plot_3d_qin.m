function plot_3d_qin()
% fid=fopen('00000174.bin','rt');
% while ~feof(fid)
%     dataten=fread(fid);
%     
% end
% 
% fclose (fid)
close all;
load 00000052_飞六圈后航线偏移失控后校电调.BIN-295418.mat
val=NTUN;
var=NTUN_label;
len_var=length(NTUN_label);
indx=[0 0 0 0];
i=1;
j=1;
while j<len_var
    if strcmpi(var{j},'DPosX')
        indx(i)=j;
        i=i+1;
    end
    if strcmpi(var{j},'DPosY')
        indx(i)=j;
        i=i+1;
    end
    if strcmpi(var{j},'PosX')
        indx(i)=j;
        i=i+1;
    end
    if strcmpi(var{j},'PosY')
        indx(i)=j;
        i=i+1;
    end
    j=j+1;
end
dx=val(:,indx(1));
dy=val(:,indx(2));
x=val(:,indx(3));
y=val(:,indx(4));
z=POS(:,6);
del=[3000:1:(length(z)-length(y)+3000-1)];
z(del)=[];
dz=ones(length(z),1)*20;
figure;
title('3-D track');
hold on;
plot3(dx,dy,dz,'LineWidth',1);
plot3(x,y,z,'LineWidth',2);
grid on;
legend('desired','reality');
xlabel('x');
ylabel('y');
zlabel('alt');

end
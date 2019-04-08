function PositionMatrix=Coordinate(i_plot,layout)

        
column=fix((i_plot-1)/layout.m);
row=layout.m-mod(i_plot-1,layout.m)-1;
        
%% 右边始终留0.005的空白，当n=1时左边空白太多       
% a=0.08-0.01*layout.n;  % outPosition-Position
% b=0.08-0.01*layout.m;  % outPosition-Position
% width=0.995/layout.n-a; % 0.995: 右边至少留0.005的空白
% height=0.945/layout.m-b; % 0.945: 上边留0.055的空白
% x0=(a+width)*column+a; 
% y0=(b+height)*row+b;
% PositionMatrix=[x0,y0,width,height];            
     
%% 右边至少留0.005的空白，当列减少时适当左移
% a=0.08-0.01*layout.n;  % outPosition-Position
% a=0.041;  % outPosition-Position y轴刻度能完全显示
a=0.034;  % outPosition-Position y轴刻度“-25.7603”能完全显示
% a=0.04+0.002*(4-layout.n)^2;  % outPosition-Position % 也可固定宽度0.04
b=0.08-0.01*layout.m;  % outPosition-Position
width=0.995/layout.n-a; % 0.995: 右边至少留0.005的空白
height=0.945/layout.m-b; % 0.945: 上边留0.055的空白
x0=(a+width)*column+a; % 当列减少时适当左移
y0=(b+height)*row+b;
PositionMatrix=[x0,y0,width,height];            

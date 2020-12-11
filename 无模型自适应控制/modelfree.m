function [sys,x0,str,ts] = modelfree(t,x,u,flag,c,d)
switch flag,
  case 0 %初始化
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 2 %更新数据
    sys=mdlUpdates(x,u);
  case 3 %输出数据
    sys=mdlOutputs(t,x,u,c,d);
  case {1,4,9} %终止
    sys=[];
    otherwise %报错
    error(['Unhandled flag=',num2str(flag)]);
end;
%% 初始化
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 3;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   
sys = simsizes(sizes);
x0  = [0.2,0.2,0]; 
%x0  = [1,1,0]; 
str = [];
ts  = [-1 0];
%% 更新数据
function sys = mdlUpdates(x,u)
f = x(2)+u(3)*(u(2)-x(2)*x(3))/(0.1+x(3)*x(3));
% f = x(2)+0.1*u(3)*(u(2)-x(2)*x(3))/(0.1+x(3)*x(3));
sys = [u(1);f;x(3)];
%% 数据输出
function sys = mdlOutputs(t,x,u,c,d)
sys = c*x(2)*u(1)/(d+x(2)*x(2));


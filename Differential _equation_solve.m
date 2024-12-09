clear
close all
format rat

% s=dsolve('D2y =cos(2*x) - Dy','y(0) =1','Dy(0) = 0','x');
% 求解析解，D?y表示y的?次导数
% simplify(s)

% [f,g]= dsolve('Df = f + g','Dg = -f + g','f(0)=1','g(0) = 2','x');
%求解微分方程组

%龙格库塔法(Runge-Kutta法)

xfun = @(t, x)t ^ 2; %定义赋值函数t对应x,x对应y
[tout, xout] = ode45(xfun, [0, 40], 0.1) %方程数值解，四五阶RK法
% [tout,xout]=ode23(xfun,[tinitial,tfinal],x0) %二三阶RK法
% [tout,xout]=ode113(xfun,[0,40],0.1)
plot(tout, xout)
% ode系列数值求解形如  /  =   ( , )的微分方程组, 并绘图。
% xfun: 输入参数，函数必须恰有t,x两个变量，用函数文件定义的fun.m则用@fun或‘fun’调用。
% t0：输入参数，t的初始值。
% tfinal：输入参数，t的终值。
% x0：输入参数，x的初始值。
% tout: 离散的自变量值， xout: 离散的函数值。

% 线性常系数微分方程，用常数变易法
% r=roots([1,1]);%参数为特征方程系数矩阵,返回特征方程解

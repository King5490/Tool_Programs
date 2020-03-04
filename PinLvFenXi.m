clf
clc
clear
format rat

syms G s

G=(2*s^0)/(1*s^3+3*s^2+2*s+0);%系统开环(闭环)方程(不是多项式展开形式)
[num_s,den_s]=numden(G);%提取系统方程的分子分母(输出的数组是符号型的需要数据转换)

num=double(coeffs(num_s,s,'all'));%系统开环函数分子(数据转换后)
den=double(coeffs(den_s,s,'all'));%系统开环函数分母(数据转换后)

% num=[0 2];%系统开环函数分子(系统方程已分解,可以直接得到)
% den=[1,3,2,0];%系统开环函数分母(系统方程已分解,可以直接得到)

w=logspace(-1,1,200);%10^-1到10^1之间对数规律取200个数

figure(1),nyquist(num,den);%奈奎斯特

[mag,phase,w]=bode(num,den,w);
[Gm,Pm,Wcg,Wcp]=margin(mag,phase,w);
% 增益或称幅值裕度（单位不是dB，想要dB为单位话用bode图）、相角裕度、相角交界频率wcg、截止频率wcp

figure(2),bode(num,den)%伯德图


sys=tf(num,den);%系统方程
sys1=feedback(sys,1);%系统单位负反馈
figure(3),step(sys1);%闭环阶跃相应

% cloop()函数已弃用,建议用feedback()函数
% [num1,den1]=cloop(num,den);%求闭环系统函数
% figure(3),step(num1,den1)%闭环阶跃相应




% 校正环节(或者额外增加的环节)
% numc=[1]
% denc=[1]
% 
% numaf=conv(num,numc)%只能计算两个
% denaf=conv(den,denc)
% 
% [magaf,phaseaf,waf]=bode(numaf,denaf,w)
% [Gmaf,Pmaf,Wcgaf,Wcpaf]=margin(magaf,phaseaf,w)
% 
% sysaf=tf(numaf,denaf);%校正后系统开环方程
% sysc=feedback(sysaf,1);%系统单位负反馈
% 
% figure(4)
% hold on
% subplot(2,2,1),nyquist(numaf,denaf);
% subplot(2,2,2),bode(numaf,denaf);
% subplot(2,2,3),step(sysc)


% 其他函数(注意:有些函数的入口参数注意不能是符号型的而返回的是符号型的)
% F=laplace(f,t,s)拉普拉斯变换,自变量由t->s
% f=ilaplace(F,s,t)拉普拉斯逆变换,自变量由s->t
% sys=tf(num,den)%得到系统sys
% printsys(num,den,'s')%输入分子分母打印出系统方程
%
% conv(num,numc)%只能计算两个多项式系数数组相乘
%
% [r,p,k]=residue(num,den)%部分因式展开,r为留数,p为极点(与r一一对应,若存在重根,则p中相同的数第1个为r1/(s+k)^1,第n个为rn/(s+k)^n),k为展开后剩余的多项式
% [num,den]=residue(r,p,k)%上述逆运算
%
% [n,d]=numden(G)%提取系统方程的分子分母
% coeffs(G,s,'All') %多项式展开返回系数一维符号型数组(可计算多参数多项式)
% sym2poly(G)%多项式展开(只可计算单参数多项式)逆向函数poly2sym()
% sys=feedback(G,H)%(G,H需事先设定).其中G是传递函数,H为反馈函数,表示一个控制系统G,对其进行负反馈H(要求正反馈用-H),求闭环函数
%
% sys = parallel(sys1,sys2)%系统并联
% sys = series(sys1,sys2)%系统串联
%  
% sys=zpk(z,p,k)%根据零极点建立系统函数(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% [z,p,k]=tf2zp(num,den)%多项式传递函数模型转换为零极点增益模型
% [num,den]=zp2tf(z,p,k)%零极点增益模型转换为多项式传递函数模型
% [p,z] = pzmap(sys)%零极点(图)
%  
% rlocus(sys)%绘制根轨迹


% [A,B,C,D]=tf2ss(num,den)%由系统方程的分子分母求状态空间表达式的4个矩阵
% [num,den]=ss2tf(a,b,c,d)%上述逆运算

% symvar(Fx)%该函数返回的是符号函数中的自变量
% f=matlabFunction(Fx)%转化后的函数就可以直接带入数值求解了
% f(x,y,z)%求函数值
 
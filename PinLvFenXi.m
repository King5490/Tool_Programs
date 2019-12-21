clf
clc
clear

w=logspace(-1,1,200);%10^-1到10^1之间对数规律取200个数

num=[0 0 2];%系统开环函数分子
den=[1,3,2,0];%系统开环函数分母

figure(1),nyquist(num,den);%奈奎斯特

[mag,phase,w]=bode(num,den,w);
[Gm,Pm,Wcg,Wcp]=margin(mag,phase,w);
%增益或称幅值裕度（单位不是dB，想要dB为单位话用bode图）、相角裕度、相角交界频率wcg、截止频率wcp

figure(2),bode(num,den)%伯德图

[num1,den1]=cloop(num,den);%求闭环系统函数
figure(3),step(num1,den1)%闭环阶跃相应


%校正环节(或者额外增加的环节)
% numc=[1]
% denc=[1]
% 
% numaf=conv(num,numc)
% denaf=conv(den,denc)
% 
% [numaf1,denaf1]=cloop(numaf,denaf)
% 
% [magaf,phaseaf,waf]=bode(numaf,denaf,w)
% [Gmaf,Pmaf,Wcgaf,Wcpaf]=margin(magaf,phaseaf,w)
% figure(4)
% hold on
% subplot(2,2,1),nyquist(numaf,denaf);
% subplot(2,2,2),bode(numaf,denaf);
% subplot(2,2,3),step(numaf1,denaf1)


% 其他函数
% sys=tf(num,den)%得到系统sys
% sys=feedback(G,H)%(G,H需事先设定).其中G是传递函数,H为反馈函数,表示一个控制系统G,对其进行负反馈H(要求正反馈用-H),求闭环函数
% 
% sys = parallel(sys1,sys2)%系统并联
% sys = series(sys1,sys2)%系统串联
%  
%  
% sys=zpk(z,p,k)%根据零极点建立系统函数(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% [z,p,k]=tf2zp(num,den)%多项式传递函数模型转换为零极点增益模型
% [num,den]=zp2tf(z,p,k)%零极点增益模型转换为多项式传递函数模型
% [p,z] = pzmap(sys)%零极点(图)
%  
%  rlocus(sys)%绘制根轨迹
 
 

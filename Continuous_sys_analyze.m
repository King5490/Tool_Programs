clear
close all
format rat

syms G s

G = (2 * s ^ 0) / (1 * s ^ 3 + 3 * s ^ 2 + 2 * s + 0); %系统开环(闭环)方程(不是多项式展开形式)
[num_s, den_s] = numden(G); %提取系统方程的分子分母(输出的数组是符号型的需要数据转换)

num = double(coeffs(num_s, s, 'all')); %系统开环函数分子(数据转换后)
den = double(coeffs(den_s, s, 'all')); %系统开环函数分母(数据转换后)
num = num ./ den(1); %分子标准化
den = den ./ den(1); %分母标准化

% tf型转多项式
% [num,den] = tfdata(sys);%提取tf型系统分子分母系数
% num_sym = poly2sym(num,s);%把分子系数转换为多项式
% den_sym = poly2sym(den,s);%把分母系数转换为多项式
% sys_sym = num_sym/den_sym;%得到系统对应的多项式

% num = [0 2];%系统开环函数分子(系统方程已分解,可以直接得到)
% den = [1,3,2,0];%系统开环函数分母(系统方程已分解,可以直接得到)

w = logspace(-1, 1, 200); %10^-1到10^1之间对数规律取200个数

figure(1), nyquist(num, den); %奈奎斯特

[mag, phase, w] = bode(num, den, w);
[Gm, Pm, Wx, Wc] = margin(mag, phase, w);
% 增益或称幅值裕度（单位不是dB，想要dB为单位话用bode图）、相角裕度、相角交界频率（穿越频率）wx、截止（剪切）频率wc

figure(2), bode(num, den); %伯德图

sys = tf(num, den); %系统方程
sys1 = feedback(sys, 1); %系统单位负反馈
figure(3), step(sys1); %闭环单位阶跃响应;impulse(sys)单位冲击响应

% cloop()函数已弃用,建议用feedback()函数
% [num1,den1] = cloop(num,den);%求闭环系统函数
% figure(3);step(num1,den1);%闭环阶跃响应

%求取稳态误差
rs = tf([1], [1 0]) %输入的拉氏变换
sys_fz = (1 - sys) * tf([1 0], [1]) * rs; %输出减去输入乘s
% Hs=tf([1],[1]);%Hs为反馈回路传递函数,单位负反馈为+1,,单位正反馈为-1
% sys_fz = (1-sys)*tf([1 0],[1])*rs*Hs;%调整为从输入定义的稳态误差
ess = dcgain(sys_fz) %相当于终值定理,从输出定义的稳态误差求取

% 校正环节(或者额外增加的环节)
% numc = [1];
% denc = [1];
%
% numaf = conv(num,numc);%只能计算两个
% denaf = conv(den,denc);
%
% [magaf,phaseaf,waf] = bode(numaf,denaf,w);
% [Gmaf,Pmaf,Wcgaf,Wcpaf] = margin(magaf,phaseaf,w);
%
% sysaf = tf(numaf,denaf);%校正后系统开环方程
% sysc = feedback(sysaf,1);%系统单位负反馈
%
% figure(4)
% hold on
% subplot(2,2,1),nyquist(numaf,denaf);
% subplot(2,2,2),bode(numaf,denaf);
% subplot(2,2,3),step(sysc);

% *******其他常用函数*******(注意:有些函数的入口参数注意不能是符号型的而返回的是符号型的)

% F = laplace(f,t,s);%拉普拉斯变换,自变量由t->s
% f = ilaplace(F,s,t);%拉普拉斯逆变换,自变量由s->t
% sys = tf(num,den);%得到系统sys(tf),sys.num{1};sys.den{1}各为系统的分子分母系数(同原num,den为展开式系数)
% [num,den]=tfdata(sys,'v');%提取系统方程的分子分母系数,不需要数据转化
%
% sys = tf(num,den,'iodelay',0.12);%sys.iodelay=传输延时时间;inputdelay,outputdelay输入输出滞后时间(单位s)
%
% printsys(num,den,'s')%输入分子分母打印出系统方程(只能打印真分式,即因果系统)
% yx=poly2str(coe,'x');%输出多项式表达式到yx中
% sprintf('所求关系式为: y=%s',yx)%打印出多项式表达式
%
% conv(u,v) %多项式乘法,只能计算两个多项式系数数组相乘(如果u和v是多项式系数的向量,则对它们进行去卷积相当于两个多项式相乘)
% [q,r] = deconv(u,v);%多项式除法,使用长除法将向量v从向量u中解卷积,并返回商q和余数r,使得u=conv(v,q)+r
%
% [r,p,k] = residue(num,den);%部分因式展开,r为留数,p为极点(与r一一对应,若存在重根,则p中相同的数第1个为r1/(s+p),第n个为rn/(s+p)^n),k为展开后剩余的多项式
% [num,den] = residue(r,p,k);%上述逆运算
%
% [n,d] = numden(G);%提取系统方程的分子分母
% coeffs(G,s,'All') %多项式展开返回系数一维符号型数组(可计算多参数多项式)
% sym2poly(G) %多项式展开(只可计算单参数多项式)逆向函数poly2sym()
% sys = feedback(G,H);%(G,H需事先设定).其中G是传递函数,H为反馈函数,表示一个控制系统G,对其进行负反馈H(要求正反馈用-H),求闭环函数
%
% sys = parallel(sys1,sys2);%系统并联
% sys = series(sys1,sys2);%系统串联
%
% sys = zpk(z,p,k);%根据零极点建立系统函数(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% sys.z{1}=z,sys.p{1}=p,sys.k{1}=k
% [z,p,k] = tf2zp(num,den);%多项式传递函数模型转换为零极点增益模型
% [num,den] = zp2tf(z,p,k);%零极点增益模型转换为多项式传递函数模型
% [p,z] = pzmap(sys);%零极点(图)
%
% rlocus(sys);%绘制根轨迹
% [K,POLES] = rlocfind(sys);%K为所选极点的开环增益
% rltool(sys);%根轨迹设计器
%
% [u,t] = gensig(type,tau,Tf,Ts);%生成指定的信号%type信号类型;tau信号周期;Tf持续时间(三个参数时省略);Ts采样时间;
% t = [0:0.01:100];%时间范围 u = ones(size(t));%位置输入(阶跃响应) u = t;%速度输入 u = 0.5.*t.^2;%加速度输入
% lsim(sys,u,t);%绘制系统指定信号输入的相应图形

% [y,t,x] = lsim(sys,u,t);%t y为系统特定输入下的输出序列
% ess = y(find(t == max(t)))-u(find(t == max(t))) %给定时间内的伪稳态误差(从输出定义)

% 拉氏变换法求稳态误差
% sys1 = sys*rs-rs;%从输出定义的稳态误差的拉氏变换

% Hs=tf([1],[1]);%Hs为反馈回路传递函数,单位负反馈为+1,,单位正反馈为-1
% sys1=rs*(1-sys)*Hs;%为了从输入定义稳态误差的拉氏变换

% [num,den] = tfdata(sys1);
% num_sym = poly2sym(num,s);
% den_sym = poly2sym(den,s);
% sym_sys = num_sym/den_sym;
% ess = limit(s*sym_sys,s,0) %终值定理求稳态误差(默认从输出定义)

% [A,B,C,D] = tf2ss(num,den);%由系统方程的分子分母求状态空间表达式的4个矩阵
% [num,den] = ss2tf(a,b,c,d);%上述逆运算

% symvar(Fx)%该函数返回的是符号函数中的自变量
% f = matlabFunction(Fx);%转化后的函数就可以直接带入数值求解了
% f(x,y,z)%求函数值

clear
close all
format rat

syms G sys s t k Ts

Ts = 1; %采样时间

G = 1 / (s + 1);
[num_s, den_s] = numden(G); %提取系统方程的分子分母(输出的数组是符号型的需要数据转换)
num = double(coeffs(num_s, s, 'all')); %系统开环函数分子(数据转换后)
den = double(coeffs(den_s, s, 'all')); %系统开环函数分母(数据转换后)
num = num ./ den(1); %分子标准化
den = den ./ den(1); %分母标准化
sys = tf(num, den);

% num_d = [1 1];
% den_d = [0.2 1];
% sysd=tf(num_d,den_d,Ts);%直接创建离散系统,系统变量为z
% sysd=tf(num_d,den_d,Ts,'variable','z^-1');%系统变量为z^-1,各系数为z降阶排列时的系数

g = ilaplace(G, s, t); %拉普拉斯逆变换
gd = compose(g, k * Ts); %创造嵌套函数,此处用作变量替换
% fd = subs(g,t,k*Ts);%变量替换
Gz = ztrans(gd); %z变换
pretty(Gz); %将所得系统方程化为书面形式打印出来

% sysd = c2d(sys,Ts,'method');%s域系统方程离散化,所得方程为多项式形式
% 若根据s函数直接求z变换,用c2d(k,Ts,'imp'),'imp'称为"脉冲响应不变法"实为直接求Z变换
% method:'zoh'零阶保持器法;'tustin'双线性变换法;'foh'一阶保持器法;'imp'脉冲响应不变法;
% 默认的是'zoh'(系统前串联上零阶保持器后直接z变换)
% 后项差法分见下文程序
% [F,G]=c2d(A,B,Ts);%连续状态空间方程离散化 A->F;B->G;C不变;D不变
% sys = d2c(sysd,'method');%离散化方程连续化
% [num,den] = tfdata(sysd);%提取出tf型系统的相关参数(需要转化数据类型)上述两变换结果均为tf型系统
% num = cell2mat(num);分子数据类型转化
% den = cell2mat(den);分母数据类型转化

figure(1), dnyquist(NUM, DEN, Ts); %绘制离散奈奎斯特图
figure(2), [MAG, PHASE, W] = dbode(NUM, DEN, Ts); %绘制离散伯德图

% *******其他常用函数*******(本文涉及大多数函数均可使用状态空间表达式)

% [U,T] = gensig(type,tau,Tf,Ts);%生成指定的信号%type信号类型;tau信号周期;Tf持续时间(三个参数时省略);Ts采样时间;
% dlsim(NUM,DEN,U);%绘制系统指定信号输入的相应图形
% dinitial(sysd,x0);%绘制离散零输入相应曲线(sysd为ss型系统),x0初始状态矩阵

% dstep(num,den);%离散闭环单位阶跃响应(状态空间表达式亦可)
% dimpulse(num,den);%离散闭环单位脉冲响应(状态空间表达式亦可)
% step(sys);%连续闭环单位阶跃响应;impulse(sys)%连续单位冲击响应

% symvar(Fx)%该函数返回的是符号函数中的自变量
% f = matlabFunction(Fx);%转化后的函数就可以直接带入数值求解了
% f(x,y,z)%求函数值

% 后项差分法系统z变化
% Gd = subs(G,s,(1-z^(-1))/Ts);
% Gd = subs(Gd,z,s);%后项差分后的系统表达式
% [num_d,den_d] = numden(Gd);
% num1 = double(coeffs(num_d,s,'all'));
% den1 = double(coeffs(den_d,s,'all'));
% sysd = tf(num1,den1,Ts)

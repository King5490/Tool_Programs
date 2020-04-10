clear
close all
format rat

syms  G sys s t k Ts

G = 1/(s+1);
[num_s,den_s] = numden(G);%提取系统方程的分子分母(输出的数组是符号型的需要数据转换)
num = double(coeffs(num_s,s,'all'));%系统开环函数分子(数据转换后)
den = double(coeffs(den_s,s,'all'));%系统开环函数分母(数据转换后)
num = num./den(1);%分子标准化
den = den./den(1);%分母标准化
sys = tf(num,den);

g = ilaplace(G,s,t);%拉普拉斯逆变换
gd = compose(g,k*Ts);%创造嵌套函数,此处用作变量替换
% fd = subs(g,t,k*Ts);%变量替换
Gz = ztrans(gd);%z变换
pretty(Gz);%将所得系统方程化为书面形式打印出来

% sysd = c2d(sys,Ts,'method');%s域系统方程离散化,所得方程为多项式形式
% 若根据s函数直接求z变换,用c2d(k,Ts,'imp'),'imp'称为"脉冲响应不变法"实为直接求Z变换
% method:'zoh'零阶保持器法;'foh'一阶保持器法;'tustin'双线性变换法;'imp'脉冲响应不变法;默认的是'zoh'
% sys = d2c(sysd,'method');%离散化方程连续化
% [num,den] = tfdata(sys);%提取出tf型系统的相关参数上述两变换结果均为tf型系统

% step(sys)%闭环单位阶跃相应;impulse(sys)%单位冲击响应

% symvar(Fx)%该函数返回的是符号函数中的自变量
% f = matlabFunction(Fx);%转化后的函数就可以直接带入数值求解了
% f(x,y,z)%求函数值

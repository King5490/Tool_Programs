clc
clear
format rat

syms G s

G=6*(s+1)/(s*(s+2)*(s+3));

[num_s,den_s]=numden(G);%提取系统方程的分子分母(输出的数组是符号型的需要数据转换)
num=double(coeffs(num_s,s,'all'));%系统开环函数分子(数据转换后)
den=double(coeffs(den_s,s,'all'));%系统开环函数分母(数据转换后)
sys=tf(num,den);

% sys=tf(num,den)%分子分母得sys(tf型)
% sys=ss(A,B,C,D)%状态空间矩阵得sys(ss型)
% sys=zpk(z,p,k)%零极点得sys(zpk型)(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% 各型系统有不同的参数,可能为元组如sys.num{1}=num(tf型),sys.z{1}=z(zpk型);sys.ts(非元组)等可单独设置
%
% [A,B,C,D]=tf2ss(num,den)%三种系统表达形式均可两两之间直接任意互换,函数随之变为 *2*
% [num,den]=ss2tf(A,B,C,D)
% [z,p,k]=ss2zp(A,B,C,D)

% T=eye(3)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(T))%状态空间表达式之间的互换,其中T为变换矩阵,,T为单位矩阵,则不变,
% 注意变换方程为:X1=TX,而不是常见的X=TX1,所以要与用户习惯的变换方程一致,必须用T的逆代入上式
%
% [P,J]=jordan(A)单独求矩阵约旦型函数,J为所求约旦型,P为变换矩阵(inv(P)为惯用人为计算得到的形式)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(P))%求系统的约旦型


% [Gc,T]=canon(sys,'type')% 其中sys为原系统模型(tf型)，而返回的As,Bs,Cs,Ds位指定的标准型的状态方程模型，
% T为变换矩阵(注意变换方程为：Xs=TX),这里的type为变换类型，有两个选项：
% 'modal':模型标准型为对角标准型(非约旦型); 'companion':模型标准型为伴随标准型(由系统方程套用公式的来的那种).


% [V,D]=eig(A)求矩阵的特征矩阵及特征值,对角矩阵D和矩阵V,其列是对应的右特征向量,使得 A*V = V*D。
% T=balance(sys.A)%改善A矩阵的条件(没啥用)

% printsys(num1,den1,'s')%打印tf型系统方程


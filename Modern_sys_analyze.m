clear
close
format rat

syms G s

G=6*(s+1)/(s*(s+2)*(s+3));

[num_s,den_s]=numden(G);%提取系统方程的分子分母(输出的数组是符号型的需要数据转换)
num=double(coeffs(num_s,s,'all'));%系统开环函数分子(数据转换后)
den=double(coeffs(den_s,s,'all'));%系统开环函数分母(数据转换后)
sys=tf(num,den);

[A,B,C,D]=tf2ss(num,den)
 if rank(ctrb(A,B))==size(A)%能控性分析
    Co='能控'
 else
     Co='不能控'
 end

  if rank(obsv(A,C))==size(A)%能观性分析
    Ob='能观'
 else
     Ob='不能观'
 end

% sys=tf(num,den)%分子分母得sys(tf型)
% sys=ss(A,B,C,D)%状态空间矩阵得sys(ss型)
% sys=zpk(z,p,k)%零极点得sys(zpk型)(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% 各型系统有不同的参数,可能为元组如sys.num{1}=num(tf型),sys.z{1}=z(zpk型);sys.ts(非元组)等可单独设置
%
% [num,den]=tfdata(sys)%提取出tf型系统的相关参数
% [A,B,C,D,Ts]=ssdata(sys)%提取出ss型系统的相关参数,Ts若不存在,则为0,可不写
% [z,p,k,Ts]=zpkdata(sys,'v')%参数'v'为强制提取(以上提取的参数均可用sys.*单独代替)
%
% [A,B,C,D]=tf2ss(num,den)%三种系统表达形式均可两两之间直接任意互换,函数随之变为 *2*
% [num,den]=ss2tf(A,B,C,D)
% [z,p,k]=ss2zp(A,B,C,D)

% T=eye(3)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(T))%状态空间表达式之间的互换,其中T为变换矩阵,,T为单位矩阵,则不变,
% 注意变换方程为:X1=TX,而不是常见的X=TX1,所以要与用户习惯的变换方程一致,必须用T的逆代入上式
%
% [P,J]=jordan(A)%单独求矩阵约旦型函数,J为所求约旦型,P为变换矩阵(inv(P)为惯用人为计算得到的形式)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(P))%求系统的约旦型

% eAt=ilaplace(inv(s*eye(size(A))-A),s,t)%拉普拉斯逆变换求状态转移矩阵


% [Gc,T]=canon(sys,'type')% 其中sys为原系统模型(tf型)，而返回的As,Bs,Cs,Ds位指定的标准型的状态方程模型，
% T为变换矩阵(注意变换方程为：Xs=TX),这里的type为变换类型，有两个选项：
% 'modal':模型标准型为对角标准型(非约旦型); 'companion':模型标准型为伴随标准型(能控I型或者能控II型).


% [V,D]=eig(A)求矩阵的特征矩阵及特征值,对角矩阵D和矩阵V,其列是对应的右特征向量,使得 A*V = V*D。
% T=balance(sys.A)%改善A矩阵的条件(没啥用)

% printsys(num,den,'s')%打印tf型系统方程
% step(sys)闭环单位阶跃相应;impulse(sys)单位冲击响应

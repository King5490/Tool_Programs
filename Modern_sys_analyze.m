clear
close all
format rat

syms G s

G = 6 * (s + 1) / ((s + 1.1) * (s + 2) * (s + 3));

[num_s, den_s] = numden(G); %提取系统方程的分子分母(输出的数组是符号型的需要数据转换)
num = double(coeffs(num_s, s, 'all')); %系统开环函数分子(数据转换后)
den = double(coeffs(den_s, s, 'all')); %系统开环函数分母(数据转换后)
num = num ./ den(1); %分子标准化
den = den ./ den(1); %分母标准化
sys = tf(num, den);

[A, B, C, D] = tf2ss(num, den);
sys_ss = ss(A, B, C, D); % 将传递函数模型转换为状态空间模型
M = ctrb(A, B); %能控性分析 %也可用Wc = gram(sys,'c');
M1 = rref(M); %化简矩阵为阶梯最简型

if rank(M) == size(A) %求秩后比较
    Co = '能控'
else
    Co = '不能控'
end

N = obsv(A, C); %能观性分析 %也可用Wo = gram(sys,'o');
N1 = rref(N); %化简矩阵为阶梯最简型

if rank(N) == size(A) %求秩后比较
    Ob = '能观'
else
    Ob = '不能观'
end

% 判断系统的稳定性
eigenvalues_A = eig(A);

if all(real(eigenvalues_A) < 0)
    disp('系统是稳定的');

    % 计算可控性格拉姆矩阵
    Wc = gram(sys_ss, 'c');

    % 计算可控性格拉姆矩阵的特征值和特征向量
    [Vc, Dc] = eig(Wc);

    % 按特征值从大到小排列特征向量
    [sorted_eigenvalues_c, idx_c] = sort(diag(Dc), 'descend');
    sorted_Vc = Vc(:, idx_c);

    % 输出结果，’*‘代表零
    % disp('可控性格拉姆矩阵 Wc：');
    % disp(Wc);
    disp('可控性格拉姆矩阵的特征值（按降序排列）：');
    disp(sorted_eigenvalues_c');
    disp('可控性格拉姆矩阵的特征向量（按特征值降序排列）：');
    disp(sorted_Vc);

    % 计算观测性格拉姆矩阵
    Wo = gram(sys_ss, 'o');

    % 计算观测性格拉姆矩阵的特征值和特征向量
    [Vo, Do] = eig(Wo);

    % 按特征值从大到小排列特征向量
    [sorted_eigenvalues_o, idx_o] = sort(diag(Do), 'descend');
    sorted_Vo = Vo(:, idx_o);

    % 输出结果，’*‘代表零
    % disp('观测性格拉姆矩阵 Wo：');
    % disp(Wo);
    disp('观测性格拉姆矩阵的特征值（按降序排列）：');
    disp(sorted_eigenvalues_o');
    disp('观测性格拉姆矩阵的特征向量（按特征值降序排列）：');
    disp(sorted_Vo);
else
    disp('系统是不稳定的，无法计算格拉姆矩阵');
end

[Abar, Bbar, Cbar, T, K] = ctrbf(A, B, C, D); %能控性分解,Abar,Bbar,Cbar为变换后的矩阵,T为转换时的相似变换阵
[abar, bbar, cbar, t, k] = obsvf(A, B, C, D); %能观性分解,abar,bbar,cbar为变换后的矩阵,T为转换时的相似变换阵
% K(k)是一个行向量,是系统能控(观)矩阵各个块的秩,sum(K)为系统的可控(观)状态的数量

sysr = minreal(sys); %最小实现的求取(sys可为任意系统型);sminreal(sys)会保留原ss系统阶数进行最小实现

if Ob == '能观'

    P = [-3 -4] %向量P中是期望的闭环极点

    % G=(acker(A',C',P))'%求全维状态观测器增益矩阵
    % G=(place(A',C',P))'%求全维状态观测器增益矩阵,与上函数差异见下文极点配置

    % *****以下为降维观测器的设计*****

    T = eye(size(A)); %构造变换矩阵T,把原状态方程转化为C=[0,I]型
    T(size(A, 1), :) = C;

    for n = 1:size(A, 1) - 1
        L = logical(C);
        L(n) = ~L(n);
        T(n, :) = L;
    end

    T = inv(T);

    [A1, B1, C1, D1] = ss2ss(A, B, C, D, inv(T)) %转化后A1=[A11 A12;A21 A22],C1=[0,I]

    n = find(C1); %自动求A11,A21
    n = n(1) - 1;
    A11 = A1(1:n, 1:n);
    A21 = A1(n + 1:size(A1, 2), 1:n);

    % A11 = [0 0;1 0]%手动输入不能从输出y检测到的能观对
    % A21 = [1 1]%手动输入不能从输出y检测到的能观对

    % G = (acker(A11',A21',P))'%降维观测器方程中的变换矩阵G
    % G = (place(A11',A21',P))'%降维观测器方程中的变换矩阵G,与上函数差异见下文极点配置

else
    disp('*****此状态方程不能观,无法求取状态观测器*****')
    pause
end

% 判断系统是否渐进稳定
% P = lyap(A',eye(size(A)));n1=0;
% for n = 1:size(A)
%     Pn = P(1:n,1:n);
%     if det(Pn) > 0
%         n1 = n1+1;
%     end
% end
% if n1 == size(A)
%    disp('系统渐进稳定')
%	 pause
% else
%    disp('系统不渐进稳定')
%	 pause
% end

%% *******其他常用函数*******

% G = C*inv(s*eye(size(A))-A)*B

% sys = tf(num,den);%分子分母得sys(tf型)
% sys = ss(A,B,C,D);%状态空间矩阵得sys(ss型)
% sys = zpk(z,p,k);%零极点得sys(zpk型)(k为零极点增益)zpk([z1,z2],[p1,p2],k)
% 各型系统有不同的参数,可能为元组如sys.num{1}=num(tf型),sys.z{1}=z(zpk型);sys.ts(非元组)等可单独设置
%
% sys = tf(num,den,'iodelay',0.12);%sys.iodelay=传输延时时间;inputdelay,outputdelay输入输出延时间(单位s)
%
% [num,den] = tfdata(sys);%提取出tf型系统的相关参数;sys.num sys.den;返回的是Cell型数据需要转换
% celldisp(dsys.den);打印出cell类型数据
% num = cell2mat(num); den = cell2mat(den);Cell型数据转换为char,下同
% [num,den]=tfdata(sys,'v');%提取系统方程的分子分母系数,不需要数据转化,不带V参数将提取出cell型
% [A,B,C,D,Ts] = ssdata(sys,'v');%提取出ss型系统的相关参数,Ts若不存在,则为0,可不写
% [z,p,k,Ts] = zpkdata(sys,'v');%参数'v'为强制提取,可提取出char型数据(不带V参数可用sys.*单独代替)
%
% [A,B,C,D] = tf2ss(num,den);%三种系统表达形式均可两两之间直接任意互换,函数随之变为 *2*
% [num,den] = ss2tf(A,B,C,D);
% [z,p,k] = ss2zp(A,B,C,D);

% T = eye(3);
% [A1,B1,C1,D1] = ss2ss(A,B,C,D,inv(T));%状态空间表达式之间的互换,其中T为变换矩阵,,T为单位矩阵,则不变,
% 注意变换方程为:X1=TX,而不是常见的X=TX1,所以要与用户习惯的变换方程一致,必须用T的逆代入上式
%
% [P,J] = jordan(A);%单独求矩阵约旦型函数,J为所求约旦型,P为变换矩阵(T=P)
% [A1,B1,C1,D1] = ss2ss(A,B,C,D,inv(P));%求系统的约旦型(inv(P)把人为计算型变为入口参数型)

% eAt = ilaplace(inv(s*eye(size(A))-A),s,t);%拉普拉斯逆变换求状态转移矩阵

% 系统非齐次方程特定输入的解
% K = 1;%输入倍数
% x0=[x10;x20];%系统初始状态,可代数,也可用符号变量,行数等于系统状态变量数
% K倍的单位脉冲响应
% xt = eAt*x0 + eAt*B*K
% K倍的单位阶跃输入响应
% xt = eAt*x0 + A^(-1)*(eAt-eye(size(A)))*B*K
% K倍的单位斜坡输入响应
% xt = eAt*x0 + (A^(-2)*(eAt-eye(size(A)))-A^(-t))*B*K

% [Gc,T] = canon(sys,'type');%其中sys为原系统模型(tf型),而返回的As,Bs,Cs,Ds位指定的标准型的状态方程模型
% T为变换矩阵(注意变换方程为：Xs=TX),这里的type为变换类型,有两个选项：
% 'modal':模型标准型为对角标准型(对角线型); 'companion':模型标准型为友矩阵型(默认能控II型,不能控报错).

% P = lyap(A',Q)%求解李雅普诺夫方程,Q通常选为单位阵,因为matlab内部算法,A需要加转置

% K = acker(A,B,P);%极点配置函数,向量P中是期望的闭环极点,不适用于多变量系统极点配置,适用于多重期望极点
% K = place(A,B,P);%多变量系统极点配置,但不适用含有多重期望极点的问题;应注意 新的A矩阵 = A-B*K

% initial(sys,x0);%绘制零输入相应曲线(sys为ss型系统),x0初始状态矩阵
% [u,t] = gensig(type,tau,Tf,Ts);%生成指定的信号%type信号类型;tau信号周期;Tf持续时间(三个参数时省略);Ts采样时间;
% lsim(sys,u,t);%绘制系统指定信号输入的相应图形

% A = A'%矩阵转置
% [V,D] = eig(A);%求矩阵的特征矩阵及特征值,对角矩阵D和矩阵V,其列是对应的右特征向量,使得 A*V = V*D。
% Adet = det(A);%求方阵的行列式值
% T = balance(sys.A);%改善A矩阵的条件(没啥用)

% [sysb,g] = balreal(sys); %LTI系统参数根据格拉姆矩阵进行可控性和观测性的平�

% u = [1,a2,a1,a0];%三阶友矩阵的原型,第一个元素必须是1
% A = compan(u);%创建友矩阵
% A = fliplr(flipud(A));调整为常见型,最后一行为[-a0 -a1 -a2]

% A = flipud(A);%将数组从上向下翻转
% A = fliplr(A);%围绕垂直中轴按左右方向翻转其各列,可用作反序处理
% A = rot90(A,k);%将数组A按逆时针方向旋转k*90度,其中 k 是一个整数

% printsys(num,den,'s')%打印tf型系统方程
% step(sys)%闭环单位阶跃响应;impulse(sys)%单位冲击响应

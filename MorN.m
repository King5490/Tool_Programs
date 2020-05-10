clear
close all
format
syms x

A=[-1 -2 -3
    0 -1  1
    1  0 -1];
B=[2;0;1];
C=[1 1 0];
D=0;
sys = ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);%求系统传递函数
num = num./den(1);%分子标准化
den = den./den(1);%分母标准化

if(num(1) ~= 0)
    disp('分子分母同阶,无法计算能控I的C')
    pause
end

BBN = fliplr(num);%系统方程分子系数翻转
BBN = BBN(1:size(A));%去除后一位

[Gc,T] = canon(sys,'companion');%计算能控II型

% tcm = [1      0
%        den(2) 1];%此变换矩阵的调整矩阵,只针对二阶矩阵

% tcm = [1      0      0
%        den(2) 1      0
%        den(3) den(2) 1];%此变换矩阵的调整矩阵,只针对三阶矩阵
	
	
% tcm = [1      0      0      0
%        den(2) 1      0      0
%        den(3) den(2) 1      0
%        den(4) den(3) den(2) 1];%此变换矩阵的调整矩阵,只针对四阶矩阵

% tzjz = x*eye(size(A))-A%系统特征矩阵
% tzfc = det(tzjz)%系统特征方程


%能控1
% AC1 = Gc.A'
% BC1 = flipud(Gc.B)
% CC1 = BBN
% DC1 = 0;
% TC1 = fliplr(ctrb(A,B))*tcm


% 能控2
% AC2 = Gc.A
% BC2 = Gc.B
% CC2 = Gc.C
% DC2 = 0;
% TC2 = ctrb(A,B)


% 能观1
% AO1 = Gc.A'
% BO1 = Gc.C'
% CO1 = Gc.B'
% DO1 = 0;
% TO1 = inv(obsv(A,C))


% 能观2
% AO2 = Gc.A
% BO2 = BBN'
% CO2 = rot90(Gc.B,3)
% DO2 = 0;
% TO2 = inv(rot90(tcm,2)*flipud(obsv(A,C)))



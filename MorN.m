clear
close all
format
syms x

A=[-1 -2 -3;
    0 -1 1;
    1 0 -1];
B=[2;0;1];
C=[1 1 0];
D=[0];
sys=ss(A,B,C,D);
[num,den] = ss2tf(A,B,C,D);

if(num(1)~=0)
    disp('���ӷ�ĸͬ��,�޷������ܿ�I��C')
    pause
end

BBN=fliplr(num);%ϵͳ���̷���ϵ����ת
BBN=BBN(1:size(A));%ȥ����һλ

[Gc,T] = canon(sys,'companion');

tcm=[1 0 0;
    -Gc.A(3,3) 1 0;
    -Gc.A(2,3) -Gc.A(3,3) 1];%�˱任����ĵ�������,ֻ������׾���

% tzjz=x*eye(size(A))-A%ϵͳ��������
% tzfc=det(tzjz)%ϵͳ��������


%�ܿ�1
% AC1=fliplr(rot90(Gc.A,3))
% BC1=flipud(Gc.B)
% CC1=BBN
% DC1=[0];
% TC1=fliplr(ctrb(A,B))*tcm


% �ܿ�2
% AC2=Gc.A
% BC2=Gc.B
% CC2=Gc.C
% DC2=[0];
% TC2=ctrb(A,B)


% �ܹ�1
% AO1=fliplr(rot90(Gc.A,3))
% BO1=rot90(Gc.C,3)
% CO1=rot90(Gc.B)
% DO1=[0];
% TO1=inv(obsv(A,C))


% �ܹ�2
% AO2=Gc.A
% BO2=rot90(BBN,3)
% CO2=rot90(Gc.B,3)
% DO2=[0];
% TO2=inv(rot90(tcm,2)*flipud(obsv(A,C)))



clc
clear
format rat

syms G s

G=6*(s+1)/(s*(s+2)*(s+3));

[num_s,den_s]=numden(G);%��ȡϵͳ���̵ķ��ӷ�ĸ(����������Ƿ����͵���Ҫ����ת��)
num=double(coeffs(num_s,s,'all'));%ϵͳ������������(����ת����)
den=double(coeffs(den_s,s,'all'));%ϵͳ����������ĸ(����ת����)
sys=tf(num,den);

% sys=tf(num,den)%���ӷ�ĸ��sys(tf��)
% sys=ss(A,B,C,D)%״̬�ռ�����sys(ss��)
% sys=zpk(z,p,k)%�㼫���sys(zpk��)(kΪ�㼫������)zpk([z1,z2],[p1,p2],k)
% 
% [A,B,C,D]=tf2ss(num,den)%����ϵͳ������ʽ��������֮��ֱ�����⻥��,��֮ *2*
% [num1,den1]=ss2tf(A,B,C,D)
% [z,p,k] = ss2zp(A,B,C,D)

% T=eye(3)
% [A1,B1,C1,D1]= ss2ss(A,B,C,D,inv(T))%״̬�ռ����ʽ֮��Ļ���,����TΪ�任����,,TΪ��λ����,�򲻱�,
% ע��任����Ϊ��X1=TX,�����ǳ�����X=TX1,����Ҫ���û�ϰ�ߵı任����һ��,������T���������ʽ
% 
% [Gc,T]=canon(sys,'type')% ����sysΪԭϵͳģ��(tf��)�������ص�As,Bs,Cs,Dsλָ���ı�׼�͵�״̬����ģ�ͣ�
% TΪ�任����(ע��任����Ϊ��Xs=TX),�����typeΪ�任���ͣ�������ѡ�
% 'modal':ģ�ͱ�׼��Ϊ�ԽǱ�׼��(Լ����); 'companion':ģ�ͱ�׼��Ϊ�����׼��.


% [V,D]=eig(A)������������������ֵ,�ԽǾ���D�;���V,�����Ƕ�Ӧ������������,ʹ�� A*V = V*D��
% T = balance(sys.A)%����A���������

% printsys(num1,den1,'s')%��ӡtf��ϵͳ����

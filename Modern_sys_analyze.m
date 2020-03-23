clear
close
format rat

syms G s

G=6*(s+1)/(s*(s+2)*(s+3));

[num_s,den_s]=numden(G);%��ȡϵͳ���̵ķ��ӷ�ĸ(����������Ƿ����͵���Ҫ����ת��)
num=double(coeffs(num_s,s,'all'));%ϵͳ������������(����ת����)
den=double(coeffs(den_s,s,'all'));%ϵͳ����������ĸ(����ת����)
sys=tf(num,den);

[A,B,C,D]=tf2ss(num,den)
M=ctrb(A,B)%�ܿ��Է���
M1=rref(M)%�������Ϊ���������
 if rank(M)==size(A)%���Ⱥ�Ƚ�
    Co='�ܿ�'
 else
     Co='���ܿ�'
 end
N=obsv(A,C)%�ܹ��Է���
N1=rref(N)%�������Ϊ���������
  if rank(N)==size(A)%���Ⱥ�Ƚ�
    Ob='�ܹ�'
 else
     Ob='���ܹ�'
 end

% sys=tf(num,den)%���ӷ�ĸ��sys(tf��)
% sys=ss(A,B,C,D)%״̬�ռ�����sys(ss��)
% sys=zpk(z,p,k)%�㼫���sys(zpk��)(kΪ�㼫������)zpk([z1,z2],[p1,p2],k)
% ����ϵͳ�в�ͬ�Ĳ���,����ΪԪ����sys.num{1}=num(tf��),sys.z{1}=z(zpk��);sys.ts(��Ԫ��)�ȿɵ�������
%
% [num,den]=tfdata(sys)%��ȡ��tf��ϵͳ����ز���
% [A,B,C,D,Ts]=ssdata(sys)%��ȡ��ss��ϵͳ����ز���,Ts��������,��Ϊ0,�ɲ�д
% [z,p,k,Ts]=zpkdata(sys,'v')%����'v'Ϊǿ����ȡ(������ȡ�Ĳ���������sys.*��������)
%
% [A,B,C,D]=tf2ss(num,den)%����ϵͳ�����ʽ��������֮��ֱ�����⻥��,������֮��Ϊ *2*
% [num,den]=ss2tf(A,B,C,D)
% [z,p,k]=ss2zp(A,B,C,D)

% T=eye(3)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(T))%״̬�ռ���ʽ֮��Ļ���,����TΪ�任����,,TΪ��λ����,�򲻱�,
% ע��任����Ϊ:X1=TX,�����ǳ�����X=TX1,����Ҫ���û�ϰ�ߵı任����һ��,������T���������ʽ
%
% [P,J]=jordan(A)%���������Լ���ͺ���,JΪ����Լ����,PΪ�任����(inv(P)Ϊ������Ϊ����õ�����ʽ)
% [A1,B1,C1,D1]=ss2ss(A,B,C,D,inv(P))%��ϵͳ��Լ����

% eAt=ilaplace(inv(s*eye(size(A))-A),s,t)%������˹��任��״̬ת�ƾ���


% [Gc,T]=canon(sys,'type')% ����sysΪԭϵͳģ��(tf��)�������ص�As,Bs,Cs,Dsλָ���ı�׼�͵�״̬����ģ�ͣ�
% TΪ�任����(ע��任����Ϊ��Xs=TX),�����typeΪ�任���ͣ�������ѡ�
% 'modal':ģ�ͱ�׼��Ϊ�ԽǱ�׼��(��Լ����); 'companion':ģ�ͱ�׼��Ϊ�����׼��(�ܿ�I�ͻ����ܿ�II��).


% [V,D]=eig(A)������������������ֵ,�ԽǾ���D�;���V,�����Ƕ�Ӧ������������,ʹ�� A*V = V*D��
% T=balance(sys.A)%����A���������(ûɶ��)


% printsys(num,den,'s')%��ӡtf��ϵͳ����
% step(sys)�ջ���λ��Ծ��Ӧ;impulse(sys)��λ�����Ӧ

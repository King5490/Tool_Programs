clf
clc
clear
format rat

syms G s

G=(2*s^0)/(1*s^3+3*s^2+2*s+0);%ϵͳ����(�ջ�)����(���Ƕ���ʽչ����ʽ)
[num_s,den_s]=numden(G);%��ȡϵͳ���̵ķ��ӷ�ĸ(����������Ƿ����͵���Ҫ����ת��)

num=double(coeffs(num_s,s,'all'));%ϵͳ������������(����ת����)
den=double(coeffs(den_s,s,'all'));%ϵͳ����������ĸ(����ת����)

% num=[0 2];%ϵͳ������������(ϵͳ�����ѷֽ�,����ֱ�ӵõ�)
% den=[1,3,2,0];%ϵͳ����������ĸ(ϵͳ�����ѷֽ�,����ֱ�ӵõ�)

w=logspace(-1,1,200);%10^-1��10^1֮���������ȡ200����

figure(1),nyquist(num,den);%�ο�˹��

[mag,phase,w]=bode(num,den,w);
[Gm,Pm,Wcg,Wcp]=margin(mag,phase,w);
% �����Ʒ�ֵԣ�ȣ���λ����dB����ҪdBΪ��λ����bodeͼ�������ԣ�ȡ���ǽ���Ƶ��wcg����ֹƵ��wcp

figure(2),bode(num,den)%����ͼ


sys=tf(num,den);%ϵͳ����
sys1=feedback(sys,1);%ϵͳ��λ������
figure(3),step(sys1);%�ջ���Ծ��Ӧ

% cloop()����������,������feedback()����
% [num1,den1]=cloop(num,den);%��ջ�ϵͳ����
% figure(3),step(num1,den1)%�ջ���Ծ��Ӧ




% У������(���߶������ӵĻ���)
% numc=[1]
% denc=[1]
% 
% numaf=conv(num,numc)%ֻ�ܼ�������
% denaf=conv(den,denc)
% 
% [magaf,phaseaf,waf]=bode(numaf,denaf,w)
% [Gmaf,Pmaf,Wcgaf,Wcpaf]=margin(magaf,phaseaf,w)
% 
% sysaf=tf(numaf,denaf);%У����ϵͳ��������
% sysc=feedback(sysaf,1);%ϵͳ��λ������
% 
% figure(4)
% hold on
% subplot(2,2,1),nyquist(numaf,denaf);
% subplot(2,2,2),bode(numaf,denaf);
% subplot(2,2,3),step(sysc)


% ��������(ע��:��Щ��������ڲ���ע�ⲻ���Ƿ����͵Ķ����ص��Ƿ����͵�)
% F=laplace(f,t,s)������˹�任,�Ա�����t->s
% f=ilaplace(F,s,t)������˹��任,�Ա�����s->t
% sys=tf(num,den)%�õ�ϵͳsys
% printsys(num,den,'s')%������ӷ�ĸ��ӡ��ϵͳ����
%
% conv(num,numc)%ֻ�ܼ�����������ʽϵ���������
%
% [r,p,k]=residue(num,den)%������ʽչ��,rΪ����,pΪ����(��rһһ��Ӧ,�������ظ�,��p����ͬ������1��Ϊr1/(s+k)^1,��n��Ϊrn/(s+k)^n),kΪչ����ʣ��Ķ���ʽ
% [num,den]=residue(r,p,k)%����������
%
% [n,d]=numden(G)%��ȡϵͳ���̵ķ��ӷ�ĸ
% coeffs(G,s,'All') %����ʽչ������ϵ��һά����������(�ɼ�����������ʽ)
% sym2poly(G)%����ʽչ��(ֻ�ɼ��㵥��������ʽ)������poly2sym()
% sys=feedback(G,H)%(G,H�������趨).����G�Ǵ��ݺ���,HΪ��������,��ʾһ������ϵͳG,������и�����H(Ҫ����������-H),��ջ�����
%
% sys = parallel(sys1,sys2)%ϵͳ����
% sys = series(sys1,sys2)%ϵͳ����
%  
% sys=zpk(z,p,k)%�����㼫�㽨��ϵͳ����(kΪ�㼫������)zpk([z1,z2],[p1,p2],k)
% [z,p,k]=tf2zp(num,den)%����ʽ���ݺ���ģ��ת��Ϊ�㼫������ģ��
% [num,den]=zp2tf(z,p,k)%�㼫������ģ��ת��Ϊ����ʽ���ݺ���ģ��
% [p,z] = pzmap(sys)%�㼫��(ͼ)
%  
% rlocus(sys)%���Ƹ��켣


% [A,B,C,D]=tf2ss(num,den)%��ϵͳ���̵ķ��ӷ�ĸ��״̬�ռ���ʽ��4������
% [num,den]=ss2tf(a,b,c,d)%����������

% symvar(Fx)%�ú������ص��Ƿ��ź����е��Ա���
% f=matlabFunction(Fx)%ת����ĺ����Ϳ���ֱ�Ӵ�����ֵ�����
% f(x,y,z)%����ֵ
 
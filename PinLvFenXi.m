clf
clc
clear

w=logspace(-1,1,200);%10^-1��10^1֮���������ȡ200����

num=[0 0 2];%ϵͳ������������
den=[1,3,2,0];%ϵͳ����������ĸ

figure(1),nyquist(num,den);%�ο�˹��

[mag,phase,w]=bode(num,den,w);
[Gm,Pm,Wcg,Wcp]=margin(mag,phase,w);
%�����Ʒ�ֵԣ�ȣ���λ����dB����ҪdBΪ��λ����bodeͼ�������ԣ�ȡ���ǽ���Ƶ��wcg����ֹƵ��wcp

figure(2),bode(num,den)%����ͼ

[num1,den1]=cloop(num,den);%��ջ�ϵͳ����
figure(3),step(num1,den1)%�ջ���Ծ��Ӧ


%У������(���߶������ӵĻ���)
% numc=[1]
% denc=[1]
% 
% numaf=conv(num,numc)
% denaf=conv(den,denc)
% 
% [numaf1,denaf1]=cloop(numaf,denaf)
% 
% [magaf,phaseaf,waf]=bode(numaf,denaf,w)
% [Gmaf,Pmaf,Wcgaf,Wcpaf]=margin(magaf,phaseaf,w)
% figure(4)
% hold on
% subplot(2,2,1),nyquist(numaf,denaf);
% subplot(2,2,2),bode(numaf,denaf);
% subplot(2,2,3),step(numaf1,denaf1)


% ��������
% sys=tf(num,den)%�õ�ϵͳsys
% sys=feedback(G,H)%(G,H�������趨).����G�Ǵ��ݺ���,HΪ��������,��ʾһ������ϵͳG,������и�����H(Ҫ����������-H),��ջ�����
% 
% sys = parallel(sys1,sys2)%ϵͳ����
% sys = series(sys1,sys2)%ϵͳ����
%  
%  
% sys=zpk(z,p,k)%�����㼫�㽨��ϵͳ����(kΪ�㼫������)zpk([z1,z2],[p1,p2],k)
% [z,p,k]=tf2zp(num,den)%����ʽ���ݺ���ģ��ת��Ϊ�㼫������ģ��
% [num,den]=zp2tf(z,p,k)%�㼫������ģ��ת��Ϊ����ʽ���ݺ���ģ��
% [p,z] = pzmap(sys)%�㼫��(ͼ)
%  
%  rlocus(sys)%���Ƹ��켣
 
 

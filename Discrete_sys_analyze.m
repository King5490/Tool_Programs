clear
close
format rat

syms  G sys s t k Ts

G=1/(s+1);
[num_s,den_s]=numden(G);%��ȡϵͳ���̵ķ��ӷ�ĸ(����������Ƿ����͵���Ҫ����ת��)
num=double(coeffs(num_s,s,'all'));%ϵͳ������������(����ת����)
den=double(coeffs(den_s,s,'all'));%ϵͳ����������ĸ(����ת����)
sys=tf(num,den);

g=ilaplace(G,s,t);%������˹��任
gd=compose(g,k*Ts);%����Ƕ�׺���,�˴����������滻
% fd=subs(g,t,k*Ts);%�����滻
Gz=ztrans(gd);%z�任
pretty(Gz)%������ϵͳ���̻�Ϊ������ʽ��ӡ����

% sysd=c2d(sys,Ts,'method')%s��ϵͳ������ɢ��,���÷���Ϊ����ʽ��ʽ
% ������s����ֱ����z�任,��c2d(k,Ts,'imp'),'imp'��Ϊ"������Ӧ���䷨"ʵΪֱ����Z�任
% method:'zoh'��ױ�������;'foh'һ�ױ�������;'tustin'˫���Ա任��;'imp'������Ӧ���䷨;Ĭ�ϵ���'zoh'
% sys=d2c(sysd,'method')%��ɢ������������
% [num,den]=tfdata(sys)%��ȡ��tf��ϵͳ����ز����������任�����Ϊtf��ϵͳ

% step(sys)%�ջ���λ��Ծ��Ӧ;impulse(sys)%��λ�����Ӧ

% symvar(Fx)%�ú������ص��Ƿ��ź����е��Ա���
% f=matlabFunction(Fx)%ת����ĺ����Ϳ���ֱ�Ӵ�����ֵ�����
% f(x,y,z)%����ֵ

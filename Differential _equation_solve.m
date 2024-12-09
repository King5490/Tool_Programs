clear
close all
format rat

% s=dsolve('D2y =cos(2*x) - Dy','y(0) =1','Dy(0) = 0','x');
% ������⣬D?y��ʾy��?�ε���
% simplify(s)

% [f,g]= dsolve('Df = f + g','Dg = -f + g','f(0)=1','g(0) = 2','x');
%���΢�ַ�����

%���������(Runge-Kutta��)

xfun = @(t, x)t ^ 2; %���帳ֵ����t��Ӧx,x��Ӧy
[tout, xout] = ode45(xfun, [0, 40], 0.1) %������ֵ�⣬�����RK��
% [tout,xout]=ode23(xfun,[tinitial,tfinal],x0) %������RK��
% [tout,xout]=ode113(xfun,[0,40],0.1)
plot(tout, xout)
% odeϵ����ֵ�������  /  =   ( , )��΢�ַ�����, ����ͼ��
% xfun: �����������������ǡ��t,x�����������ú����ļ������fun.m����@fun��fun�����á�
% t0�����������t�ĳ�ʼֵ��
% tfinal�����������t����ֵ��
% x0�����������x�ĳ�ʼֵ��
% tout: ��ɢ���Ա���ֵ�� xout: ��ɢ�ĺ���ֵ��

% ���Գ�ϵ��΢�ַ��̣��ó������׷�
% r=roots([1,1]);%����Ϊ��������ϵ������,�����������̽�

clear
close all
format

t_s = 0.01; %��������
f_s=1/t_s; %����Ƶ��(Hz)
t_start = 0; %��ʼʱ��
t_end = 10; %����ʱ��
t = t_start : t_s : t_end; %���ɲ�������
N=numel(t)-1; %�������м����
y = 1+2*cos(2*pi*2*t+pi*45/180)+3*cos(2*pi*5*t+75*pi/180); %�����ź�����

figure(1)
plot(t,y);
grid on
title('ԭʼ�ź�ʱ��ͼ');
xlabel('t/(s)'); %x���������
ylabel('�źŷ�ֵ/(mv)'); %y���������

figure(2)
Y = fft(y,N); %��FFT�任
Ayy =abs(Y); %ȡģ
F=([1:N]-1)*f_s/N; %�����ʵ�ʵ�Ƶ��ֵ
% plot(Ayy(1:N)); %��ʾ��FFTģֵ����
plot(F,Ayy(1:N)); %��ʾFFTģֵ���
grid on
title('FFT ģֵͼ');
xlabel('������');%x���������
ylabel('�źŷ�ֵ/(�޵�λ)');%y���������

figure(3)
Ayy=Ayy/(N/2); %�����ʵ�ʵķ���
Ayy(1)=Ayy(1)/2; %ֱ������ʵ�ʷ�ֵ
F=([1:N]-1)*f_s/N; %�����ʵ�ʵ�Ƶ��ֵ
plot(F(1:N/2),Ayy(1:N/2)); %��ʾ������FFTģֵ���
grid on
title('����-Ƶ��ͼ');
xlabel('Ƶ��/(Hz)'); %x���������
ylabel('�źŷ�ֵ/(mv)');%y���������

figure(4)
Pyy=[1:N/2];
for i=1:N/2
Pyy(i)=phase(Y(i)); %������λ
%Pyy(i)=angle(Y(i)); %������λ,ͬ��
%Pyy(i)=Pyy(i)*180/pi; %��λ����Ϊ�Ƕ�
end
stem(F(1:N/2),Pyy(1:N/2)); %��ʾ��λͼ

disp('��ѯ��Ƶ�ʶ�Ӧ��λΪ:'); %��ѯ����ʾ�ض���ֵ
disp(Pyy(find(F== 2)));

grid on
title('��λ-Ƶ��ͼ');
xlabel('Ƶ��/(Hz)'); %x���������
ylabel('��λ/(��)'); %y���������
% ylabel('��λ/(��)'); %y���������


% *******FFTͼ��Ĵ����任********
% Druation = t_end -t_start;  %�������ʱ��
% Sampling_points = numel(Y); %��������
% t2 = F-f_s/2;
% 
% figure(5)
% subplot(5,1,1);
% plot(t,y);
% title('ԭʼ�ź�ͼ'); %����ԭʼ�ź�ͼ
% 
% subplot(5,1,2);
% plot(F,abs(Y));
% title('fft transform');
% 
% subplot(5,1,3);
% shift_f = abs(fftshift(Y));
% plot(F-f_s/2,shift_f);
% title('shift fft transform'); %��0Ƶ�ʷ���(ֱ������)�Ƶ���������
% 
% subplot(5,1,4);
% plot(t2(length(t2)/2:length(t2)),shift_f(length(shift_f)/2:length(shift_f)));
% title('shift fft transform cut'); %������Ƶ�ʲ���
% 
% subplot(5,1,5);
% plot(F(1:length(F)/2),abs(Y(1:length(F)/2)));
% title('fft cut'); %��ȡfft�����ǰ�벿��


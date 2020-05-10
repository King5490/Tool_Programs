clear
close all
format

t_s = 0.01; %采样周期
f_s=1/t_s; %采样频率(Hz)
t_start = 0; %起始时间
t_end = 10; %结束时间
t = t_start : t_s : t_end; %生成采样序列
N=numel(t)-1; %采样序列间隔数
y = 1+2*cos(2*pi*2*t+pi*45/180)+3*cos(2*pi*5*t+75*pi/180); %生成信号序列

figure(1)
plot(t,y);
grid on
title('原始信号时域图');
xlabel('t/(s)'); %x轴变量名称
ylabel('信号幅值/(mv)'); %y轴变量名称

figure(2)
Y = fft(y,N); %做FFT变换
Ayy =abs(Y); %取模
F=([1:N]-1)*f_s/N; %换算成实际的频率值
% plot(Ayy(1:N)); %显示的FFT模值序列
plot(F,Ayy(1:N)); %显示FFT模值结果
grid on
title('FFT 模值图');
xlabel('序列数');%x轴变量名称
ylabel('信号幅值/(无单位)');%y轴变量名称

figure(3)
Ayy=Ayy/(N/2); %换算成实际的幅度
Ayy(1)=Ayy(1)/2; %直流分量实际幅值
F=([1:N]-1)*f_s/N; %换算成实际的频率值
plot(F(1:N/2),Ayy(1:N/2)); %显示换算后的FFT模值结果
grid on
title('幅度-频率图');
xlabel('频率/(Hz)'); %x轴变量名称
ylabel('信号幅值/(mv)');%y轴变量名称

figure(4)
Pyy=[1:N/2];
for i=1:N/2
Pyy(i)=phase(Y(i)); %计算相位
%Pyy(i)=angle(Y(i)); %计算相位,同上
%Pyy(i)=Pyy(i)*180/pi; %相位换算为角度
end
stem(F(1:N/2),Pyy(1:N/2)); %显示相位图

disp('查询点频率对应相位为:'); %查询并显示特定点值
disp(Pyy(find(F== 2)));

grid on
title('相位-频率图');
xlabel('频率/(Hz)'); %x轴变量名称
ylabel('相位/(π)'); %y轴变量名称
% ylabel('相位/(°)'); %y轴变量名称


% *******FFT图像的处理及变换********
% Druation = t_end -t_start;  %计算采样时间
% Sampling_points = numel(Y); %采样点数
% t2 = F-f_s/2;
% 
% figure(5)
% subplot(5,1,1);
% plot(t,y);
% title('原始信号图'); %绘制原始信号图
% 
% subplot(5,1,2);
% plot(F,abs(Y));
% title('fft transform');
% 
% subplot(5,1,3);
% shift_f = abs(fftshift(Y));
% plot(F-f_s/2,shift_f);
% title('shift fft transform'); %将0频率分量(直流分量)移到坐标中心
% 
% subplot(5,1,4);
% plot(t2(length(t2)/2:length(t2)),shift_f(length(shift_f)/2:length(shift_f)));
% title('shift fft transform cut'); %保留正频率部分
% 
% subplot(5,1,5);
% plot(F(1:length(F)/2),abs(Y(1:length(F)/2)));
% title('fft cut'); %截取fft结果的前半部分


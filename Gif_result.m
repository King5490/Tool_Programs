clear
close all
format

xlabel('X轴');
ylabel('Y轴');
box on;
t=0:0.1:10; 
Nt=size(t,2);
x=2*cos(t(1:Nt));
y=sin(t(1:Nt));
%循环绘图
for i=1:Nt
    cla;
    hold on;
    plot(x,y)
    plot(x(i),y(i),'o');
    pause(0.05);%帧间隔时间
    
    %将结果保存为gif
    frame=getframe(gcf);%捕捉当前帧
    imind=frame2im(frame);%返回与帧关联的图像数据
    [imind,cm] = rgb2ind(imind,256);%将RGB图像转换为索引图像
    if i==1
         imwrite(imind,cm,'test.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
    else
         imwrite(imind,cm,'test.gif','gif','WriteMode','append','DelayTime',1e-4);
    end
end


% 用背景擦除的方法,动态的划线,并且动态改变坐标系
% t=[0]
% m=[sin(t);cos(t)]
% p = plot(t,m,'EraseMode','background','MarkerSize',5);%相当于创建一个plot类,line()型也适用
% x=-1.5*pi;
% axis([x x+2*pi -1.5 1.5]);
% grid on;
% for i=1:1000
%     t=[t 0.1*i];                   %Matrix 1*(i+1)
%     m=[m [sin(0.1*i);cos(0.1*i)]]; %Matrix 2*(i+1)
%     set(p(1),'XData',t,'YData',m(1,:));%直接申请子类1
%     set(p(2),'XData',t,'YData',m(2,:));%直接申请子类2
%     drawnow;%立即刷新状态
%     x=x+0.1;
%     axis([x x+2*pi -1.5 1.5]);%移动坐标轴
%     pause(0.5);%帧时间
% end


% ******其他函数*******
% Pn = animatedline(x,y);%创建动态线条
% addpoints(Pn,x(i),y(i));%在动态线条内增加点
% clearpoints(an);%清除动态线条内点，但是Pn依旧在
% [x,y] = getpoints(an);%返回动态线条内点值
% drawnow;%立即刷新图像,更新点的状态
% 
% figure('ButtonDownFcn',@(src,event) pause(5));%在图中空白处单击鼠标键,暂停动图5秒.


clear
close all
format

xlabel('X��');
ylabel('Y��');
box on;
t=0:0.1:10; 
Nt=size(t,2);
x=2*cos(t(1:Nt));
y=sin(t(1:Nt));
%ѭ����ͼ
for i=1:Nt
    cla;
    hold on;
    plot(x,y)
    plot(x(i),y(i),'o');
    pause(0.05);%֡���ʱ��
    
    %���������Ϊgif
    frame=getframe(gcf);%��׽��ǰ֡
    imind=frame2im(frame);%������֡������ͼ������
    [imind,cm] = rgb2ind(imind,256);%��RGBͼ��ת��Ϊ����ͼ��
    if i==1
         imwrite(imind,cm,'test.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
    else
         imwrite(imind,cm,'test.gif','gif','WriteMode','append','DelayTime',1e-4);
    end
end


% �ñ��������ķ���,��̬�Ļ���,���Ҷ�̬�ı�����ϵ
% t=[0]
% m=[sin(t);cos(t)]
% p = plot(t,m,'EraseMode','background','MarkerSize',5);%�൱�ڴ���һ��plot��,line()��Ҳ����
% x=-1.5*pi;
% axis([x x+2*pi -1.5 1.5]);
% grid on;
% for i=1:1000
%     t=[t 0.1*i];                   %Matrix 1*(i+1)
%     m=[m [sin(0.1*i);cos(0.1*i)]]; %Matrix 2*(i+1)
%     set(p(1),'XData',t,'YData',m(1,:));%ֱ����������1
%     set(p(2),'XData',t,'YData',m(2,:));%ֱ����������2
%     drawnow;%����ˢ��״̬
%     x=x+0.1;
%     axis([x x+2*pi -1.5 1.5]);%�ƶ�������
%     pause(0.5);%֡ʱ��
% end


% ******��������*******
% Pn = animatedline(x,y);%������̬����
% addpoints(Pn,x(i),y(i));%�ڶ�̬���������ӵ�
% clearpoints(an);%�����̬�����ڵ㣬����Pn������
% [x,y] = getpoints(an);%���ض�̬�����ڵ�ֵ
% drawnow;%����ˢ��ͼ��,���µ��״̬
% 
% figure('ButtonDownFcn',@(src,event) pause(5));%��ͼ�пհ״���������,��ͣ��ͼ5��.


clear
close all
format

x1 = linspace(0,100,20);%如需外部导入数据见额外函数
% x1 = 0:5:100
y1 = [0 nan];%缺失值用nan代替

% yc = y1(find(x1 == 20));%查询x1对应的y1
% yp = spline(x1,y1,[2.333]);%线性预测x1对应的y1

plot(x1,y1,'+');
hold on;
k1 = polyfit(x1,y1,1);

yx=poly2str(k1,'x');%输出多项式表达式到yx中
ans1=sprintf('拟合曲线方程为: y=%s',yx);%打印出多项式表达式

x = linspace(min(x1),max(x1));
y = k1(1)*x+k1(2);
plot(x,y);

grid on;
box on;
legend('实验数据','拟合数据');%曲线名称标注
xlabel('位移/(mm)');%x轴变量名称
ylabel('电压/(V)');%y轴变量名称

xlim([8.00 12.00]);%作图x轴范围
ylim([-4.00 4.00]);%作图y轴范围
% rectangle();%框选部分特定区域
title('V-△X特性曲线');%图片名称
gtext(ans1);%自定义添加曲线名称
% annotation();%可添加更复杂注释


[maxy,num] = max(abs(k1(1)*x1+k1(2)-y1));
% 求最大非线性偏差(绝对值)，num为误差最大处向量位置
fxxwc = abs(maxy/max(y1)) %计算一维的非线性误差




% *******其他函数*******(如需更多拟合功能,使用 Curve Fitting 工具箱)

% [num,txt,raw] = xlsread('C:\Users\Desktop\fileName.xlsx');
% num返回的是excel中的数据,txt输出的是文本内容,raw输出的是未处理数据
% [A,B,C] = textread('filename',format);%读取.txt文件内容,format为读取特定参数
% A = importdata('-pastespecial');%将当前剪贴板数据导入A

% A = reshape(A1,[m,n]);%调整数据为 m*n 阶矩阵

% M = mean(A,'all');%计算A的所有元素的均值
% M = median(A,'all');%计算A的所有元素的中位数
% S = std(A);%计算A每一列的标准差
% V = var(A);%计算A的方差
% C = cov(A);%计算A的协方差
% R = corrcoef(A,B);%返回两个随机变量A和B之间的相关系数

% A1 = [1 3 NaN 4 NaN NaN 5];
% NUM = numel(A1)计算数据总个数
% S = sum(isnan(A1));%计算缺失值数目
% R = rmmissing(A1);%删除缺失值
% A = standardizeMissing(A1,'indicator');%indicator为缺失值替换值
% A = fillmissing(A1,'method');%A为补全缺失值后的数据
%
% TF = isoutlier(A1,'method');%TF为离群值替换为1的零矩阵,使用sum(TF)统计离群值数量
% B = rmoutliers(A1,'method');%B为删除离群值后的数据
% B = filloutliers(A1,'method');%B为检测并替换数据中的离群值后的数据
%
% B = smoothdata(A1,'method');%B为平滑后的数据
%
% R = rescale(A1,l,u);%数据映射到指定缩放范围 l下限(默认0),u上限(默认1)
% N = normalize(A1,'method');%归一化数据


% x = logspace(0,10);%对数取值
% semilogx(x,y);%按照 x 轴的对数刻度绘制数据
% semilogy(x,y);
% loglog(x,y);%双对数坐标轴图

% stem(x,y);%绘制离散序列数据(针状图)
% scatter(x,y);%散点图scatter3(x,y,z)三维散点图
% line(x,y);%画线指令,不会覆盖之前的图像
% polar(theta,rho);%极坐标绘制
% plot3();%绘制三维曲线(输入点集)
% ezplot();%符号函数图像的绘制,ezplot3()

% fplot(@(x) exp(x),[-3 0]);%二维隐函数的绘制
% fimplicit(f);
% f=@(x,y,z) x.^2+y.^2-1;
% fimplicit3(f);%三维隐函数的绘制
% fplot3()

% [x,y] = meshgrid(0:1:10,0:1:10);%点阵的生成
% z = 12-x.^3-y.^3;
% surf(x,y,z);%三维面绘制
% mesh(x,y,z);%三维网线面绘制

% p = polyfit(x,y,n);%返回阶数为n的多项式p(x)的系数,降阶排序
% y = polyval(p,x);%计算多项式p(x)在x的每个点处的值,p为降阶排序

% f1 = figure(1);%返回图窗属性并创建图窗,关闭图窗后f1属性移除
% figure(Name,Value);%自定义图窗属性,例如figure('name','图窗名字');
% subplot(m,n,p)%将当前图窗划分为m×n网格,并在p子图窗后接绘图,后接等指令等,会覆盖当前前的图窗的之前内容

% 保存图窗内容函数
% print(句柄,存储格式,文件名);%句柄:“Figure 3”,句柄是3
% gcf获取当前窗口句柄,故print多图时需要紧跟plot等画图指令
% 存储格式:-dpng;-djpe;-dbitmap
%
% saveas(句柄,['储存目录目录\文件名','储存格式']);%保存默认格式的图窗,即所见不一定为所得
% saveas(get_param('simulink_name','Handle'),'result.bmp');%保存simulink模块图
% saveas 如果只有一幅图,句柄设为gcf,如果有多副,句柄需单独设置
%
% frame=getframe(gcf);%获取坐标系中的图像文件数据
% imwrite(frame.cdata,['储存目录目录','result.jpg','.jpg']);%可用于制作gif动图,保存结果所见即所得


% ****插值补全数据****
%
% 分段线性插值(使用线性插值返回一维函数在特定查询点的插入值)
% xq=[];缺失的y1对应的x1
% yq=interp1(x1,y1,xq,'method');%默认method为 linear (spline线性度高)
% method: linear,nearest,next,previous,pchip,cubic,v5cubic,makima,spline
% plot(xq,yq,'o');
%
%
% 三次样条插值
% xq = [];%缺失的y1对应的x1
% yq = spline(x1,y1,xq);
%
%
% meshgrid格式的二维网格数据的插值
% [xq,yq] = meshgrid(0:1:10);%缺失的z1对应的x1,y1
% zq = interp2(x1,y1,z1,xq,yq,'method');%默认方法为 linear
% method: linear,nearest,cubic,makima,spline
% surf(xq,yq,zq);


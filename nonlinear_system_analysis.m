clc;
clear;
close all;

%% 定义系统参数常量
a = 1;
b = 2;
c = 3;
k = 5;
theta = 6;

%% 定义系统动力学微分方程
n = 3;
syms X [n 1] real % 系统用到的状态变量

f = [
     -a * X1
     -b * X2 + k - c * X1 * X3
     theta * X1 * X2
     ];
g = [
     X3
     0
     0
     ];
u = [1];
h = [
     X3
     ];
X_dot = f + g * u;

% 定义系统的初始条件，方便后续的画图，注意与上文的状态维数相同
x0 = [1; 1; 1]; % 初始条件
tspan = [0, 150]; % 时间范围
arrow_step = 10; % 每隔多少步绘制一个箭头
slice_num = 4; % 切片数量
margin = 1; % 各轴边距

% 选择要绘制的变量，2到3个
var_indices = [1, 3]; % 选择对应的变量的序号进行绘制

% 设置找寻的范围
range = repmat([-Inf, Inf], length(X), 1);
% 求解微分方程计算出平衡点
equilibrium_points = vpasolve(X_dot == 0, X, range);
equilibrium_points = struct2array(equilibrium_points);

stable_points = [];
unstable_points = [];

% 遍历每个平衡点，判断是否为稳定平衡点
for i = 1:size(equilibrium_points, 1)
    x_eq = equilibrium_points(i, :);

    A = jacobian(X_dot, X);
    A_eq = double(subs(A, X, x_eq'));

    eigenvalues = eig(A_eq);

    if all(real(eigenvalues) < 0)
        stable_points = [stable_points; x_eq];
    else
        unstable_points = [unstable_points; x_eq];
    end

end

disp('Stable Equilibrium Points:');
disp(stable_points);
disp('Unstable Equilibrium Points:');
disp(unstable_points);

% 绘制指定初始化条件的系统轨迹
X_dot_fun = matlabFunction(X_dot, 'Vars', {X});

% 设置求解选项输出统计信息
options = odeset('OutputFcn', @odeplot, 'Stats', 'on');
figure(1);

try

    [t, x] = ode45(@(t, x) X_dot_fun(x), tspan, x0, options);
catch
    disp('The system is likely stiff.');
    disp('ode45 solver failed or required very small step size.');
    [t, x] = ode15s(@(t, X) X_dot_fun(X), tspan, x0, options);
end

x_range = NaN(length(X), 2);
slice_step = NaN(length(X), 1);
X_vals = [];

for i = 1:length(X)
    x_range(i, 1) = min(double(equilibrium_points(:, i))) - margin;
    x_range(i, 2) = max(double(equilibrium_points(:, i))) + margin;
    slice_step(i) = (x_range(i, 2) - x_range(i, 1)) / slice_num;
    X_vals = [X_vals; x_range(i, 1):slice_step(i):x_range(i, 2)];
end

figure(2);
% 绘制相图
if length(var_indices) == 3
    [v1_vals, v2_vals, v3_vals] = meshgrid(X_vals(var_indices(1), :), X_vals(var_indices(2), :), X_vals(var_indices(3), :));
    x_mesh = 0 * ones(length(X), numel(v1_vals));
    x_mesh(var_indices(1), :) = reshape(v1_vals, [1, numel(v1_vals)]);
    x_mesh(var_indices(2), :) = reshape(v2_vals, [1, numel(v2_vals)]);
    x_mesh(var_indices(3), :) = reshape(v3_vals, [1, numel(v3_vals)]);

    X_dot_mesh = X_dot_fun(x_mesh);
    % 画箭头
    quiver3(double(x_mesh(var_indices(1), :)), double(x_mesh(var_indices(2), :)), double(x_mesh(var_indices(3), :)), double(X_dot_mesh(var_indices(1), :)), double(X_dot_mesh(var_indices(2), :)), double(X_dot_mesh(var_indices(3), :)));

    hold on;

    % 标注平衡点
    if ~isempty(stable_points)
        plot3(stable_points(:, var_indices(1)), stable_points(:, var_indices(2)), stable_points(:, var_indices(3)), 'go', 'MarkerSize', 10, 'LineWidth', 2);
    end

    if ~isempty(unstable_points)
        plot3(unstable_points(:, var_indices(1)), unstable_points(:, var_indices(2)), unstable_points(:, var_indices(3)), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    end

    % 绘制轨迹
    plot3(x(:, var_indices(1)), x(:, var_indices(2)), x(:, var_indices(3)), 'b', 'LineWidth', 2);

    xlabel(['x' num2str(var_indices(1))]);
    ylabel(['x' num2str(var_indices(2))]);
    zlabel(['x' num2str(var_indices(3))]);
    title('非线性系统的三维相图');
    grid on;
    hold off;

elseif length(var_indices) == 2
    % 二维相图
    [v1_vals, v2_vals] = meshgrid(X_vals(var_indices(1), :), X_vals(var_indices(2), :));
    x_mesh = 0 * ones(length(X), numel(v1_vals));
    x_mesh(var_indices(1), :) = reshape(v1_vals, [1, numel(v1_vals)]);
    x_mesh(var_indices(2), :) = reshape(v2_vals, [1, numel(v2_vals)]);

    X_dot_mesh = X_dot_fun(x_mesh);
    % 画箭头
    quiver(double(x_mesh(var_indices(1), :)), double(x_mesh(var_indices(2), :)), double(X_dot_mesh(var_indices(1), :)), double(X_dot_mesh(var_indices(2), :)));

    hold on;

    % 标注平衡点
    if ~isempty(stable_points)
        plot(stable_points(:, var_indices(1)), stable_points(:, var_indices(2)), 'go', 'MarkerSize', 10, 'LineWidth', 2);
    end

    if ~isempty(unstable_points)
        plot(unstable_points(:, var_indices(1)), unstable_points(:, var_indices(2)), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    end

    % 绘制轨迹
    plot(x(:, var_indices(1)), x(:, var_indices(2)), 'b', 'LineWidth', 2);

    xlabel(['x' num2str(var_indices(1))]);
    ylabel(['x' num2str(var_indices(2))]);
    title('非线性系统的二维相图');
    grid on;
    hold off;
end

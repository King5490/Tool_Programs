clc
clear
close all

% 本程序只考虑了静态反馈线性化，如果想要求出非线性系统起点状态和终点状态之间的解析路径表示，可以使用python的control工具箱。
% 不能静态反馈线性化的系统是可能经过内源动态反馈线性化。
% 代码原理及其公式来源为: Nonlinear Systems and Controls Second Edition -- Jürgen Adamy

%% 定义系统参数变量
a = 1;
b = 2;
c = 3;
d = 4;
k = 5;
theta = 6;

%% 定义系统动力学微分方程，参考如下仿射控制非线性系统形式
% \dot{x} = f(x) + g(x) * u
% y = h(x)

n = 3;
syms X [n 1] real % 系统用到的状态变量

f = [
     -a * X1
     -b * X2 + k - c * X1 * X3
     theta * X1 * X2
     ];
g = [
     1 0 0
     0 1 0
     0 0 1
     ];

u = ones(size(g, 2), 1); % 注意u的列数必然为1
% 系统的虚拟输出，全状态线性化的输出和输入的维数是相同的
h = [
     X1
     X2
     X3
     ];

%% 系统分析
if is_observable(f, h, X)
    disp('系统全局可观测');
else
    disp('系统非全局可观测');
    X0 = zeros(n, 1);
    fprintf('系统在[');

    for i = 1:length(X0)
        fprintf('%d', X0(i));

        if i < length(X0)
            fprintf(', ');
        end

    end

    if is_locally_observable(f, h, X, X0)

        fprintf(']点处局部可观测\n');
    else
        fprintf(']点处局部不可观测\n');
    end

end

if is_controllable(f, g, X)
    disp('系统可控');
else
    disp('系统不可控');
end

% 初始化全状态线性化辅助矩阵 GX
GX = g;
all_is_involutive = true;

for i = 1:n - 1

    if ~is_involutive(GX)
        all_is_involutive = false;
        break;
    end

    adf_i_g = [];

    for j = 1:size(g, 2)
        adf_i_g = [adf_i_g, lie_bracket(f, GX(:, end - size(g, 2) + j), X)];
    end

    GX = [GX, adf_i_g];
end

% 判断是否可以全状态反馈线性化
if rank(GX) == n && all_is_involutive
    disp('系统可以全状态反馈线性化');
    disp('GX:')
    disp(GX)
else
    disp('系统不能全状态反馈线性化');
end

% 计算系统的相对阶和解耦矩阵，用于判断系统是否可以输入-输出反馈线性化
relative_degree = ones(size(h, 1), 1);
D = [];

for i = 1:size(h, 1)
    Lf_n_h = h;

    while sum(relative_degree) <= n
        Lg_Lf_n_h = lie_derivative(g, Lf_n_h, X);

        if Lg_Lf_n_h == 0
            Lf_n_h = lie_derivative(f, Lf_n_h, X);
            relative_degree(i) = relative_degree(i) + 1;
        else
            D_i = [];
            L = lie_derivative_kth(f, relative_degree(i) - 1, h(i), X);

            for j = 1:size(g, 2)
                D_i = [D_i, lie_derivative(g(:, j), L, X)];
            end

            D = [D; D_i];
            break
        end

    end

end

total_relative_degree = sum(relative_degree);

if total_relative_degree <= n && det(D) ~= 0
    disp('系统的相对阶为：');
    disp(relative_degree);
    fprintf('该系统的总相对阶为：%d\n', total_relative_degree);

    if total_relative_degree ~= n
        zero_dynamics_order = n - total_relative_degree;
        fprintf('系统可进行输入 - 输出部分反馈线性化，零动力系统阶数为：%d\n', zero_dynamics_order);
    else
        disp('系统可进行输入-输出反馈线性化');
    end

else
    fprintf('该系统无相对阶，不可进行输入-输出反馈线性化\n');
end

%% 辅助函数定义
function Lf_h = lie_derivative(f, h, X)
    % 计算向量场 f 对标量函数 h 的李导数 Lf_h
    % f 是向量场，h 是标量函数，X 是状态变量的符号向量

    Lf_h = jacobian(h, X) * f;
end

function Lf_k_h = lie_derivative_kth(f, k, h, X)
    % k次李导数计算函数
    Lf_k_h = h;

    for i = 1:k
        Lf_k_h = lie_derivative(f, Lf_k_h, X);
    end

end

function adf_g = lie_bracket(f, g, X)
    % 计算向量场 f 和 g 的李括号 [f, g]
    % f 和 g 是向量场，X 是状态变量的符号向量

    Lf_g = lie_derivative(f, g, X);
    Lg_f = lie_derivative(g, f, X);

    % 计算李括号
    adf_g = Lf_g - Lg_f;
end

function adf_k_g = lie_bracket_kth(f, k, g, X)
    % k次李括号计算函数
    adf_k_g = g;

    for i = 1:k

        for j = 1:size(g, 2)
            adf_k_g = lie_bracket(f, adf_k_g(:, end - size(g, 2) + j), X);
        end

    end

end

function is_involutive = is_involutive(input_set)
    % 对合检测函数

    set_rank = rank(input_set);
    is_involutive = true;

    if set_rank == size(input_set, 1)
        return;
    else

        for i = 1:size(input_set, 2)

            for j = (i + 1):size(input_set, 2)
                Lij = lie_bracket(input_set(:, i), input_set(:, j), X);

                if rank([input_set, Lij]) > set_rank
                    is_involutive = false;
                    return;
                end

            end

        end

    end

end

function is_observable = is_observable(f, h, X)
    % 判断自治非线性系统是否弱全局可观
    % f 是系统的状态方程，h 是输出方程，X 是状态变量的符号向量

    n = length(X);
    O = jacobian(h, X); % 初始化可观性矩阵

    % 计算可观性矩阵
    Lf_nh = h;

    for i = 1:n - 1
        Lf_nh = lie_derivative(f, Lf_nh, X);
        O = [O; jacobian(Lf_nh, X)];
    end

    % 判断可观性矩阵的秩
    if rank(O) == n
        is_observable = true;
    else
        is_observable = false;
    end

end

function is_observable = is_locally_observable(f, h, X, X0)
    % 判断自治非线性系统是否弱局部可观
    % f 是系统的状态方程，h 是输出方程，X 是状态变量的符号向量，X0为观测点

    n = length(X);
    O = jacobian(h, X); % 初始化可观性矩阵

    % 计算可观性矩阵
    Lf_nh = h;

    for i = 1:n - 1
        Lf_nh = lie_derivative(f, Lf_nh, X);
        O = [O; jacobian(Lf_nh, X)];
    end

    O_const = subs(O, X, X0);

    % 判断可观性矩阵的秩
    if rank(O) == n
        is_observable = true;
    else
        is_observable = false;
    end

end

function is_controllable = is_controllable(f, g, X)
    % 判断非线性系统是否可控
    % f 是系统的状态方程，g 是输入矩阵，X 是状态变量的符号向量

    n = length(X);
    C = g; % 初始化可控性矩阵

    % 计算可控性矩阵
    for i = 1:n - 1
        adf_i_g = [];

        for j = 1:size(g, 2)
            adf_i_g = [adf_i_g, lie_bracket(f, C(:, end - size(g, 2) + j), X)];
        end

        C = [C, adf_i_g];
    end

    % 判断可控性矩阵的秩
    if rank(C) == n
        is_controllable = true;
    else
        is_controllable = false;
    end

end

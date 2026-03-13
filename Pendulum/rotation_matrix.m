% 原代码地址：https://github.com/DongHT/Multibody_dynamics_formula_derivation_and_simulation
% 仅学习使用，本人添加注释，优化部分代码
%%%%%% 清理工作区、命令行窗口、关闭图窗 %%%%%%
clear;
clc;
close;

%%%%%% 旋转矩阵 %%%%%%
% 绕 Z 轴旋转/yaw 偏航角/psi 普赛角
psi = (30)*(pi/180);
% 绕 Y 轴旋转/pitch 俯仰角/theta 西塔
theta = (45)*(pi/180);
% 绕 X 轴旋转/roll 横滚角/phi 弗爱
phi = (60)*(pi/180);

Rz = [cos(psi) -sin(psi) 0; sin(psi) cos(psi) 0; 0 0 1];
Ry = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
Rx = [1 0 0; 0 cos(phi) -sin(phi); 0 sin(phi) cos(phi)];

%%%%%% 旋转顺序 %%%%%%
% Z-> Y-> X
% Z-> X-> Y
% Y-> Z-> X
% Y-> X-> Z
% X-> Z-> Y
% X-> Y-> Z
Rzyx = Rz*Ry*Rx;
Rzxy = Rz*Rx*Ry;
Ryzx = Ry*Rz*Rx;
Ryxz = Ry*Rx*Rz;
Rxzy = Rx*Rz*Ry;
Rxyz = Rx*Ry*Rz;

%%%%%% 图形绘制 %%%%%%
% fig = figure(888);  % 创建叫 Figure 888 的图窗
fig = figure;  % 创建图窗
% 图窗编号关闭
% 图窗位置（像素） 左下角 x=200, y=200, width=640, height=480
% 拯救者 16 inch
set(fig, ...
    'Name', '旋转顺序', ...
    'NumberTitle', 'off', ...
    'Color', 'w', ...
    'Position', [50 50 1280 720]);

for i = 1:9
    subplot(3,3,i);  % 3*3
    hold on;  % 保持当前内容
    grid on;  % 绘制网格
    box on;  % 显示坐标轴边框
    % gca 获取当前坐标轴
    % 'TickLabelInterpreter', 'none'  % 刻度标签解释器
    set(gca, ...
        'GridLineStyle', '-.', ...  % 网格线的线形
        'GridAlpha', 0.5);  % 网格线的透明度
    xlim([1 6]);  % x 轴的取值
    ylim([-1 1]);  % y 轴的取值
    % 线性索引转换回行和列形式
    [row,col] = ind2sub(size(Rzyx),i);
    plot([Rzyx(i),Rzxy(i),Ryzx(i),Ryxz(i),Rxzy(i),Rxyz(i)], '-or');
    title(['$$\rm{row:}\,$$',num2str(row),'$$\,\,\rm{column:}$$',num2str(col)], 'Interpreter','latex');
end

% syms psi theta phi;
% Rz = [cos(psi) -sin(psi) 0;
%       sin(psi)  cos(psi) 0;
%          0          0    1];
% Ry = [ cos(theta) 0 sin(theta);
%             0     1     0;
%       -sin(theta) 0 cos(theta)];
% Rx = [1    0         0;
%       0 cos(phi) -sin(phi);
%       0 sin(phi)  cos(phi)];
% 
% Rzyx = Rz*Ry*Rx;
% Rzxy = Rz*Rx*Ry;
% Ryzx = Ry*Rz*Rx;
% Ryxz = Ry*Rx*Rz;
% Rxzy = Rx*Rz*Ry;
% Rxyz = Rx*Ry*Rz;
% 
% latex_Rzyx = latex(Rzyx);
% latex_Rzxy = latex(Rzxy);
% latex_Ryzx = latex(Ryzx);
% latex_Ryxz = latex(Ryxz);
% latex_Rxzy = latex(Rxzy);
% latex_Rxyz = latex(Rxyz);

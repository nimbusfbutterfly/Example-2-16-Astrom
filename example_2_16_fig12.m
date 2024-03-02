clc; clear all; close all;

a_true = -0.8;
b_true = 0.5;
max = 1000;
Noise = 0.5 * randn(max, 1, 2);
y = zeros(max, 1);
u = zeros(max, 1);
% u=ones(max,1);
u(1:50, 1) = ones(50, 1);
T = 100;
for i = 101:max
    u(i) = u(i - T);
end

for t = 2:max
    y(t) = 0.8 * y(t - 1) + 0.5 * u(t - 1) + Noise(t);
end

mean(Noise);

theta = zeros(2, 1);
a(1) = theta(1);
b(1) = theta(2);
forgetting_factors = [1, 0.999, 0.99, 0.95];

figure('Name', 'Effect of Forgetting Factor in RLS', 'NumberTitle', 'off');

for j = 1:length(forgetting_factors)
    landa = forgetting_factors(j);
    
    % RLS Algorithm with forgetting factor landa
    P = 100 * eye(2);
    theta = zeros(2, 1);
    a(1) = theta(1);
    b(1) = theta(2);

    for i = 2:max
        phiint = [-y(i - 1); u(i - 1)];
        K = P * phiint * inv(landa * eye(1) + phiint' * P * phiint);
        theta = theta + K * (y(i) - phiint' * theta);
        P = (eye(2) - K * phiint') * P / landa;
        a(i) = theta(1);
        b(i) = theta(2);
    end

    subplot(2, 2, j);
    t = 1:max;
    plot(t, a_true * ones(size(t)));
    hold on;
    plot(t, b_true * ones(size(t)));
    hold on;
    plot(a);
    hold on;
    plot(b);
    xlabel('Time (second)');
    title(['RLS with \lambda = ' num2str(landa)]);
    legend('a', 'b', '$$\hat{a}$$', '$$\hat{b}$$', 'Interpreter', 'Latex');
    grid on;
    a(max);
    b(max);
    P;
    hold off;
end

sgtitle("Figure 12-2");

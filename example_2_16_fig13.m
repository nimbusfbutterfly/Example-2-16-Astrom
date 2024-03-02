clc;clear all;close all;
a_true = -0.8;
b_true = 0.5;
max=1000;
Noise=0.5*randn(max,1,2);
Sigma=0.5;
y=zeros(max,1);
u=zeros(max,1);
% u=ones(max,1);
u(1:50,1)=ones(50,1);
T=100;
for i=101:max
    u(i)=u(i-T);
end
for t=2:max
    y(t)=0.8*y(t-1)+0.5*u(t-1)+Noise(t);
end
mean(Noise);
P=100*eye(2);
theta=zeros(2,1);
a(1)=theta(1);
b(1)=theta(2);

landa=1;
%  RLS Algorithm with forgetting factor landa=1
for i=2:max
    phiint=[-y(i-1);u(i-1)];
    K=P*phiint*inv(landa*eye(1)+phiint'*P*phiint);
    theta=theta+K*(y(i)-phiint'*theta);
    P=(eye(2)-K*phiint')*P/landa;
    a(i)=theta(1);
    b(i)=theta(2);
end
figure;
sgtitle("Figure 13-2");
subplot(2,2,1);
t=1:max;
plot(t, a_true * ones(size(t)));
title('RLS');
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
xlabel('Time (second)');
legend('a','b','$$\hat{a}$$','$$\hat{b}$$','Interpreter','Latex');
grid on;
a(max)
b(max)
P
hold off;
%% Part b
clear P;
gama=0.01;
P=gama;
for i=2:max
    phiint=[-y(i-1);u(i-1)];
    P=gama;
    
    theta=theta+P*phiint*(y(i)-phiint'*theta);
   
    a(i)=theta(1);
    b(i)=theta(2);
end
subplot(2,2,2);
t=1:max;
plot(t, a_true * ones(size(t)));
title('LMS');
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
xlabel('Time (second)');
legend('a','b','$$\hat{a}$$','$$\hat{b}$$','Interpreter','Latex');
grid on;
disp(['a: ', num2str(a(max))]);
disp(['b: ', num2str(b(max))]);
P
hold off;
%% Part c
clear P;
gama=0.01;
alpha=0.1;
for i=2:max
    phiint=[-y(i-1);u(i-1)];
    P=gama/(alpha+phiint'*phiint);
    
    theta=theta+P*phiint*(y(i)-phiint'*theta);
    a(i)=theta(1);
    b(i)=theta(2);
end
subplot(2,2,3);
t=1:max;
plot(t, a_true * ones(size(t)));
title('PA');
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
xlabel('Time (second)');
legend('a','b','$$\hat{a}$$','$$\hat{b}$$','Interpreter','Latex');
grid on;
a(max)
b(max)
P
hold off;
%% Part d
clear P;
gama=0.2;
Sigma=0;
for i=2:max
    phiint=[-y(i-1);u(i-1)];
    Sigma=Sigma+phiint'*phiint;
    P=gama/Sigma;
    K=P*phiint;
    theta=theta+K*(y(i)-phiint'*theta);
    a(i)=theta(1);
    b(i)=theta(2);
end
subplot(2,2,4);
t=1:max;
plot(t, a_true * ones(size(t)));
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
title('SA');
xlabel('Time (second)');
legend('a','b','$$\hat{a}$$','$$\hat{b}$$','Interpreter','Latex');
grid on;

a(max)
b(max)
P
hold off;
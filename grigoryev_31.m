% ПЗ 31, Григорьев Юрий
clc;
syms t; syms x(t); syms dx(t); syms Cheb3(t); syms xi(t); syms T0(t); syms T1(t); syms T2(t); syms Tayl4(t);

% A)
T0(t) = 1;
T1(t) = t;
T2(t) = 2*t*T1 - T0;
T3(t) = 2*t*T2 - T1;
a = -1; b = 1;
x(t) = (t+1)*tan(t);
xi(t) = 1/sqrt(1-t^2);
xnorm = L2_norm(x, a, b);
Cheb3(t) = scalar_mult(x, T0, xi, a, b)*T0 + scalar_mult(x, T1, xi, a, b)*T1 + scalar_mult(x, T2, xi, a, b)*T2 + scalar_mult(x, T3, xi, a, b)*T3;
Cheb3 = Cheb3 / xnorm; % ортонормализация

% вывод графика
figure
hold on;
grid on;
title('Аппроксимация многочленами Чебышёва I рода функции', x);
axis([-2 2 -2 20]);
fplot(x, "-");
fplot(Cheb3, "--");
hold off;


% B)
Tayl4(t) = 0;
i = 0;
t0 = 0;
while i <= 4
    dx(t) = diff(x, i);
    Tayl4 = Tayl4 + dx(t0)*t^i/factorial(i);
    i = i + 1;
end
Tayl4 = Tayl4 / xnorm;

% вывод графика
figure
hold on;
grid on;
title('Аппроксимация многочленами Тейлора функции', x);
axis([-2 2 -2 20]);
fplot(x, "-");
fplot(Tayl4, "--");
hold off;

% оценка качества аппроксимации вблизи нуля
t1 = 0.2; t2 = 0.1;
syms x_diff_cheb(t); syms x_diff_tayl(t);
x_diff_cheb(t) = x - Cheb3; x_diff_tayl(t) = x - Tayl4;
ChebyshevQuality_Near0 = vpa(abs(x_diff_cheb(t1)) + abs(x_diff_cheb(t2)), 3)/2; % для многочленов Чебышёва I рода
TaylorQuality_Near0 = vpa(abs(x_diff_tayl(t1)) + abs(x_diff_tayl(t2)), 3)/2; % для многочленов Тейлора
ChebyshevQuality_Near0
TaylorQuality_Near0

% оценка качества равномерной аппроксимации
x_diff_interval = -1:0.05:1;
for i = 1:length(x_diff_interval)
    xdc_values(i) = vpa(x_diff_cheb(i), 3);
    xdt_values(i) = vpa(x_diff_tayl(i), 3);
end
M = max(xdc_values);
ChebyshevQuality_uniform = vpa(abs(M));
M = max(xdt_values);
TaylorQuality_uniform = vpa(abs(M));
ChebyshevQuality_uniform
TaylorQuality_uniform

function res = L2_norm(x, a, b)
    syms t;
    res = sqrt(vpa(int(x^2, t, a, b), 10));
end

function res = scalar_mult(x, y, xi, a, b) % скалярное произведение в весовом пространстве L2
    syms t;
    res = vpa(int(x * y * xi, t, a, b), 10);
end
% ПЗ 29, Григорьев Юрий
clc;
syms t; syms x(t); syms P0(t); syms P1(t); syms P2(t); syms S1(t); syms S2(t);

x(t) = 1 + abs(t);

P0(t) = 1/sqrt(2);
P1(t) = sqrt(3/2)*t;
P2(t) = sqrt(5/2)*(3/2 * t^2 - 1/2);

a = -1; b = 1;

c0 = scalar_mult(x, P0, a, b);
c1 = scalar_mult(x, P1, a, b);
c2 = scalar_mult(x, P2, a, b);

S1(t) = c0 * P0 + c1 * P1;
S2(t) = S1 + c2 * P2;

% вывод графика для многочлена 1 степени
figure
hold on;
grid on;
axis([-2 2 0 5]);
fplot(x, "-");
fplot(S1, "--");
hold off;

% вывод графика для многочлена 2 степени
figure
hold on;
grid on;
axis([-2 2 0 5]);
fplot(x, "-");
fplot(S2, "--");
hold off;

function res = scalar_mult(x, y, a, b) % скалярное произведение в пространстве Лебега L2:(a,b)
    syms t;
    res = vpa(int(x * y, t, a, b), 5);
end
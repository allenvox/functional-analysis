% ПЗ 30, Григорьев Юрий
clc;
syms t; syms x1(t); syms x2(t); syms T1(t); syms T(t); syms Trig7(t); syms Leg7(t); syms Pk(t);

x1(t) = t;
x2(t) = t^2;

T1(t) = 1/sqrt(2);
Trig7(t) = (scalar_mult(x1, T1, -1, 0) + scalar_mult(x2, T1, 0, 1))*T1;
i = 1;
while i < 7
    T(t) = i*pi*t;
    a = scalar_mult(x1, sin(T), -1, 0) + scalar_mult(x2, sin(T), 0, 1);
    b = scalar_mult(x1, sin(T), -1, 0) + scalar_mult(x2, sin(T), 0, 1);
    Trig7 = Trig7 + a*cos(T) + b*sin(T);
    i = i + 1;
end

% вывод графика для тригонометрической аппроксимации
figure
hold on;
grid on;
axis([-1 1 -2 2]);
fplot(x1, [-1 0]);
fplot(x2, [0 1]);
fplot(Trig7, "--");
hold off;

Leg7(t) = 0;
i = 0;
while i < 7
    Pk(t) = t^i;
    Leg7 = Leg7 + (scalar_mult(x1, Pk, -1, 0) + scalar_mult(x2, Pk, 0, 1))*Pk;
    i = i + 1;
end
Leg7 = Leg7 / sqrt(vpa(int(x1^2, t, -1, 0) + int(x2^2, t, 0, 1), 5)); % ортонормализация многочлена Лежандра

% вывод графика для аппроксимации многочленами Лежандра
figure
hold on;
grid on;
axis([-1 1 -2 2]);
fplot(x1, [-1 0]);
fplot(x2, [0 1]);
fplot(Leg7, "--");
hold off;

function res = scalar_mult(x, y, a, b) % скалярное произведение в пространстве Лебега L2:(a,b)
    syms t;
    res = vpa(int(x * y, t, a, b), 5);
end
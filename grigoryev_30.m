% ПЗ 30, Григорьев Юрий
clc;
syms t; syms x(t); syms x1(t); syms x2(t); syms T1(t); syms T(t); syms Trig7(t); syms Leg7(t); syms Trig6(t); syms Leg6(t); syms Pk(t);

% A)
x1(t) = t;
x2(t) = t^2;

Ck2sum = 0; % переменная для последующего вычисления точности аппроксимации
T1(t) = 1/sqrt(2);
Trig7(t) = (scalar_mult(x1, T1, -1, 0) + scalar_mult(x2, T1, 0, 1))*T1;
i = 1;
while i < 7
    T(t) = i*pi*t;
    a = scalar_mult(x1, cos(T), -1, 0) + scalar_mult(x2, cos(T), 0, 1);
    b = scalar_mult(x1, sin(T), -1, 0) + scalar_mult(x2, sin(T), 0, 1);
    Ck = a*cos(T) + b*sin(T);
    Ck2sum = Ck2sum + (a + b)^2;
    Trig7 = Trig7 + Ck;
    i = i + 1;
end

% вывод графика для тригонометрической аппроксимации
figure
hold on;
grid on;
title('Тригонометрическая аппроксимация функции 1');
axis([-1 1 -2 2]);
fplot(x1, [-1 0]);
fplot(x2, [0 1]);
fplot(Trig7, "--");
hold off;

xnorm = sqrt(vpa(int(x1^2, t, -1, 0) + int(x2^2, t, 0, 1), 10));
% точность аппроксимации
trignorm = sqrt(xnorm^2 - Ck2sum);

Ck2sum = 0;
Leg7(t) = 0;
i = 0;
while i < 7
    Pk(t) = t^i;
    Ck = scalar_mult(x1, Pk, -1, 0) + scalar_mult(x2, Pk, 0, 1);
    Ck2sum = Ck2sum + Ck^2;
    Leg7 = Leg7 + Ck*Pk;
    i = i + 1;
end

Leg7 = Leg7 / xnorm; % ортонормализация многочлена Лежандра

% точность аппроксимации
legnorm = sqrt(xnorm^2 - Ck2sum);

% вывод графика для аппроксимации многочленами Лежандра
figure
hold on;
grid on;
title('Аппроксимация многочленами Лежандра функции 1');
axis([-1 1 -2 2]);
fplot(x1, [-1 0]);
fplot(x2, [0 1]);
fplot(Leg7, "--");
hold off;

fprintf("A) ");
if(trignorm < legnorm)
    fprintf("Тригонометрическая аппроксимация оказалась точнее:\n");
else
    fprintf("Аппроксимация многочленами Лежандра оказалась точнее:\n");
end
trignorm
legnorm



% B)
x(t) = log(1 - t^2);

Ck2sum = 0;
T1(t) = 1/sqrt(2);
Trig6(t) = scalar_mult(x, T1, -1, 1)*T1;
i = 1;
while i < 6
    T(t) = i*pi*t;
    a = scalar_mult(x, cos(T), -1, 1);
    b = scalar_mult(x, sin(T), -1, 1);
    Ck = a*cos(T) + b*sin(T);
    Ck2sum = Ck2sum + (a + b)^2;
    Trig6 = Trig6 + Ck;
    i = i + 1;
end

% вывод графика для тригонометрической аппроксимации
figure
hold on;
grid on;
title('Тригонометрическая аппроксимация функции', x);
axis([-1 1 -5 0.5]);
fplot(x, "-");
fplot(Trig6, "--");
hold off;

trignorm = sqrt(xnorm^2 - Ck2sum);

xnorm = sqrt(vpa(int(x^2, t, -1, 1), 10));
Leg6(t) = 0;
Ck2sum = 0;
i = 0;
while i < 6
    Pk(t) = t^i;
    Ck = scalar_mult(x, Pk, -1, 1);
    Ck2sum = Ck2sum + Ck^2;
    Leg6 = Leg6 + Ck*Pk;
    i = i + 1;
end
Leg6 = Leg6 / xnorm; % ортонормализация многочлена Лежандра

% точность аппроксимации
legnorm = sqrt(xnorm^2 - Ck2sum);

% вывод графика для аппроксимации многочленами Лежандра
figure
hold on;
grid on;
title('Аппроксимация многочленами Лежандра функции', x);
axis([-1 1 -5 0.5]);
fplot(x, "-");
fplot(Leg6, "--");
hold off;

fprintf("B) ");
if(trignorm < legnorm)
    fprintf("Тригонометрическая аппроксимация оказалась точнее:\n");
else
    fprintf("Аппроксимация многочленами Лежандра оказалась точнее:\n");
end
trignorm
legnorm

function res = scalar_mult(x, y, a, b) % скалярное произведение в пространстве Лебега L2:(a,b)
    syms t;
    res = vpa(int(x * y, t, a, b), 10);
end
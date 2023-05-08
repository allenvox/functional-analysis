% ПЗ 38, Григорьев Юрий
clc;
syms t; syms y(t); syms eK(t); syms dK(t); syms cK(t); syms res(t); syms S10(t);
y(t) = exp(t) * (t^2 + 2 * t - 2) - 11 * t^3 + 6 * t;
lambda = 1;

S10(t) = 0; % частичная сумма ряда Фурье (до 10 порядка)
k = 0;
while k <= 10
    eK(t) = legendreP(k, t); % многочлен Лежандра k-го порядка по переменной t
    eK = eK / L2_norm(eK, -1, 1); % ортонормализация многочленов Лежандра
    dK(t) = scalar_mult(y, eK, -1, 1); % k-ый коэффициент Фурье
    lambdaK = k*(k+1); % k-е собственное число опреатора A
    cK(t) = dK/(lambdaK - lambda);
    S10 = S10 + cK * eK;
    k = k + 1;
end

% вывод графика частичной суммы ряда Фурье
figure
hold on;
grid on;
title('Частичная сумма ряда Фурье');
axis([-1.2 1.2 2.1 2.8]);
fplot(S10, "-");
hold off;

res(t) = aX(S10) - lambda * S10;

% вывод графиков функций A[x] - lambda*X и Y
figure
hold on;
grid on;
title('Наложение графиков решения и исходной функции');
axis([-1.2 1.2 -8 12]);
fplot(y, "-");
fplot(res, "--");
hold off;

function res = scalar_mult(x, y, a, b) % скалярное произведение в пространстве Лебега L2:(a,b)
    syms t;
    res = int(x * y, t, a, b);
end

function res = aX(x) % A[x]
    syms t;
    res = (t^2 - 1) * diff(x, 2) + 2 * t * diff(x, 1);
end

function res = L2_norm(x, a, b) % норма в пространстве Лебега L2:(a,b)
    syms t;
    res = sqrt(vpa(int(x^2, t, a, b), 10));
end
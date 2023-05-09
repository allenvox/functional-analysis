% ПЗ 40, Григорьев Юрий
clc;
syms t; syms s; syms K(t, s); syms K6(t, s); syms y(t); syms xk(t);

% разложение ядра на многочлен Тейлора 6 степени
K(t, s) = 3 * s * (sqrt(4 + t^2 + s^2) - 2);
K6(t, s) = taylor(K, t, 'Order', 7);

eps = 0.001;
y(t) = 4 * t^2 * (1 - t)^2;

xk(t) = 1; % начальное приближение

norm_I_A1 = 2.06868;
norm_I_A = C_norm(I_AX(xk) - y, 0, 1);
norm_Xk_X = norm_I_A * norm_I_A1;

while norm_Xk_X > eps
    xk = int(K6 * xk(s), s, 0, 1) + y;
    norm_I_A = C_norm(I_AX(xk) - y, 0, 1);
    norm_Xk_X = norm_I_A * norm_I_A1;
end

figure
hold on;
grid on;
title('График приближённого решения (~X)');
axis([0 1 -1 1]);
fplot(xk, "-");
hold off;

figure
hold on;
grid on;
title('Подстановка приближённого решения в оператор (I - A) и функция Y');
axis([0 1 -1 1]);
fplot(y, "-");
fplot(I_AX(xk), "--");
hold off;

function res = I_AX(x) % оператор (I - A)[x]
    syms t; syms s;
    res = x - int(3 * s * (sqrt(4 + t^2 + s^2) - 2) * x, s, 0, 1);
end

function res = C_norm(x, a, b) % норма в пространстве C:(a,b)
    syms t;
    res = vpa(int(x, t, a, b), 10);
end
% ПЗ 15, Григорьев Юрий
clc;

syms t;
syms f0(t);
f0(t) = t; % начальное приближение

syms f(t);
f(t) = t + atan(f0(t)) * (t^2 - 1)/2; % Ф

syms alpha(t);
alpha(t) = (t^2 - 1)/2; % коэффициент сжатия
eps = 1e-2;
a = -1.5;
b = 1.5;

apriori = int16(round(log(eps * (1 - alpha(a)) / maximum(f0, f, a, b)) / log(alpha(a))));
fprintf("alphaMax = %f, eps = %.e, apr = %d\n", alpha(a), eps, apriori);

% итерации
i = 0;
while i < apriori
    f0(t) = xn;
    xn = f(f0);
    i = i + 1;
end

hold on;
grid on;
plot(a:b, f(a:b));
title('Приближённое решение нелинейного уравнения в пространстве непрерывных функций C[-1.5;1.5]');
hold off;

function max = maximum(x0, x1, a, b)
    max = 0.0;
    for i = a:1:b
        value = abs(x0(i) - x1(i));
        if (value > max)
            max = value;
        end
    end
end
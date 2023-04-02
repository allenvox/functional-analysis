% ПЗ 15, Григорьев Юрий
clc;

syms t; syms f0(t); syms f(t); syms alpha(t);
f0(t) = t; % начальное приближение
f(t) = t + atan(f0(t)) * (t^2 - 1)/2; % Ф
alpha(t) = (t^2 - 1)/2; % коэффициент сжатия
epsilon = 1e-2;
a = -1.5;
b = 1.5;

apriori = int16(round(log(epsilon * (1 - alpha(a)) / maximum(f0, f, a, b)) / log(alpha(a))));
fprintf("alphaMax = %f, eps = %.e, apr = %d\n", alpha(a), epsilon, apriori);

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

function max = maximum(xn1, xn, a, b)
    max = 0.0;
    for i = a:1:b
        value = abs(xn1(i) - xn(i));
        if (value > max)
            max = value;
        end
    end
end
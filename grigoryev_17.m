% ПЗ 17, Григорьев Юрий
clc;
% переменные
syms t;
syms s;
syms x(t)
x(t) = sin(t)^2 + 2 * sin(t) + 1 - 2 * exp(sin(t)); % точное решение
% метод простых итераций
syms x0(t)
x0(t) = t; % начальное приближение
syms xn(t)
xn(t) = int(cos(s) * x0(s), s, pi, t) + sin(t) - sin(t)^3 / 3 - 1;
syms fixed(t)
fixed(t) = 0;
i = 0;
while i < 10
    if i == 5
        fixed = xn;
        out(fixed, x, 6);
    end
    x0(t) = xn;
    xn(t) = int(cos(s) * x0(s), s, pi, t) + sin(t) - sin(t)^3 / 3 - 1;
    i = i + 1;
end

fixed = xn;
out(fixed, x, 10);

function out = out(f, exact_solution, iteration)
    figure
    hold on;
    grid on;
    axis([-5 20 -2 7]);
    fplot(exact_solution, "-")
    fplot(f, "--")
    title('Iteration', iteration)
    hold off;
    out = 0;
end
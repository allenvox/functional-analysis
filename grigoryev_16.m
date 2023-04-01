% ПЗ 16, Григорьев Юрий
clc;
alpha = 1/3;
eps = 1e-5;
syms t;
syms s;
syms f0(t);
f0(t) = t;
syms f(t);
f(t) = (1/7) * int(f0(s) * (t+s)^2, s, 0, 1) - 2*t^2;
apriori = int16(round(log(eps * (1 - alpha) / maximum(f0, f, 0, 1)) / log(alpha)) + 1);
fprintf("lambda = 1/7, alpha = %f, eps = %.e, apriori = %d iterations\n", alpha, eps, apriori);
i = 0;
while i < apriori
    f0(t) = f(t);
    f(t) = (1/7) * int(f0(s) * (t+s)^2, s, 0, 1) - 2*t^2;
    i = i + 1;
end
f(t) % вывод приближённого решения

syms solution(t);
solution(t) = t^2 * (-2-16189/131083) - 23373*t/131083 - 17703/262166; % точное решение

m = maximum(f, solution, 0, 1); % расстояние между приближённым и точным решением
fprintf("max = %f < 1e-5", m);

hold on;
grid on;
fplot(f, "-");
fplot(solution, "--");
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
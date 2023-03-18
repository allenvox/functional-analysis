% ПЗ 13, Григорьев Юрий
clc;
epsilon = 1e-5; % точность
v = 2;
u = 4;
alfa = 0.5;
coef = alfa / (1 - alfa);
% преобразованная функция вида Ф[x] = x
f = inline("x - (2*x + x/(1+x^2)^2 - 4 - acot(x))/4");
x0 = f(0); % начальное приближение
xn = f(x0);
apriori = int16(round(log(epsilon * (1 - alfa) / abs(x0 - xn)) / log(alfa)) + 1);;

i = 0;
while and(i < apriori, coef * abs(xn - x0) > eps) % апостериорная оценка
    x0 = xn;
    xn = f(x0);
    i = i + 1;
end
fprintf("epsilon = %f, v = %f, u = %f, alfa = %f\napriori = %d iterations\nx = %f, %d iterations\n", epsilon, v, u, alfa, apriori, xn, i);

% локализуем корень графическим способом
x = -1.0:0.01:3.0;
y = 2*x + x/(1+x.^2) - 4 - acot(x);
plot(x,y);
grid on;
% видим - корень лежит в промежутке (2.0; 2.2) => ответ найден верно
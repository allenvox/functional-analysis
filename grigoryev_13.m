% ПЗ 13, Григорьев Юрий
clc;
epsilon = 1e-5; % точность
v = 2;
u = 4;
alpha = 0.5;
coef = alpha / (1 - alpha);
% преобразованная функция вида Ф[x] = x
f = inline("x - (2*x + x/(1+x^2)^2 - 4 - acot(x))/4");
x0 = f(0); % начальное приближение
xn = f(x0);

apriori = int16(round(log(epsilon * (1 - alpha) / abs(x0 - xn)) / log(alpha)) + 1);;

i = 0;
while and(i < apriori, coef * abs(xn - x0) > eps) % апостериорная оценка
    x0 = xn;
    xn = f(x0);
    i = i + 1;
end
fprintf("epsilon = %f, v = %f, u = %f, alpha = %f\napriori = %d iterations\nx = %f, %d iterations\n", epsilon, v, u, alpha, apriori, xn, i);


% локализуем корень графическим способом
hold on; % возможность наложения графиков в одном окне
grid on; % координатная сетка

% часть графика (-1;0) (испр. функции арккотангенса)
% x1 = -1.0:0.01:-0.001;
% y1 = 2*x1 + x1/(1+x1.^2) - 4 - acot(x1) - 2.4;

% часть графика (0;3)
x2 = 0.0:0.01:3.0;
y2 = 2*x2 + x2/(1+x2.^2) - 4 - acot(x2);
% plot(x1,y1,x2,y2);
plot(x2,y2);

y3 = 0;
plot(x2,y3,'.','color','red'); % ось абсцисс
% видим - корень лежит в промежутке (2.1; 2.2) => ответ найден верно
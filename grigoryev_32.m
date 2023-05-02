% ПЗ 32, Григорьев Юрий
clc;
syms t; syms x(t); syms y(t); syms xi(t); syms Cheb3(t); syms xi(t); syms T0(t); syms T1(t); syms T2(t); syms Tayl4(t);

xi(t) = sqrt(1-t^2);
x(t) = 0;
k = 0;
while k <= 30 % full approximation in Chebyshev polynomials from c0 to c60
    x = x + ((-1)^(k+1))*sqrt(8)*chebyshevU(2*k, t)/((2*k-1)*(2*k+3)*sqrt(pi));
    k = k + 1;
end

% hypothesis
y(t) = abs(t);

% plotting both polynomial approximation & hypothesis
figure
hold on;
grid on;
axis([-1.3 1.3 -1 3]);
fplot(x, "-");
fplot(y, "--");
hold off;

function res = L2_norm(x, xi, a, b)
    syms t;
    res = sqrt(vpa(int((x*xi)^2, t, a, b), 10));
end

function res = scalar_mult(x, y, xi, a, b) % скалярное произведение в весовом пространстве L2
    syms t;
    res = vpa(int(x * y * xi, t, a, b), 10);
end
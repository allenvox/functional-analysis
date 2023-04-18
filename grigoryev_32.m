% ПЗ 32, Григорьев Юрий
clc;
syms t; syms x(t); syms y(t); syms xi(t); syms Cheb3(t); syms xi(t); syms T0(t); syms T1(t); syms T2(t); syms Tayl4(t);

xi(t) = sqrt(1-t^2);
x(t) = (2*sqrt(2))/(3*sqrt(pi));
k = 0;
while k < 10 % full approximation in Chebyshev polynomials
    x = x + (chebyshevU(2*k, t)*(2*sqrt(2)/sqrt(pi))*(-1)^(k+1))/((2*k-1)*(2*k+3));
    k = k + 1;
end

% hypothesis
y(t) = 1.3*abs(t) + 2*sqrt(2)/(3*sqrt(pi));

% plotting both polynomial approximation & hypothesis
figure
hold on;
grid on;
axis([-1.3 1.3 -1 5]);
fplot(x, "-");
fplot(y, "--");
hold off;

% comparing norms
x_norm = L2_norm(x, xi, -1, 1)
y_norm = L2_norm(y, xi, -1, 1)

k = 0;
while k < 8 % comparing Fourier coefficients
    c_y = scalar_mult(y, chebyshevU(k, t), xi, -1, 1);
    c_x = scalar_mult(x, chebyshevU(k, t), xi, -1, 1);
    diff_between_hypothesis_and_approx = abs(c_y - c_x)
    k = k + 1;
end

function res = L2_norm(x, xi, a, b)
    syms t;
    res = sqrt(vpa(int((x*xi)^2, t, a, b), 10));
end

function res = scalar_mult(x, y, xi, a, b) % скалярное произведение в весовом пространстве L2
    syms t;
    res = vpa(int(x * y * xi, t, a, b), 10);
end
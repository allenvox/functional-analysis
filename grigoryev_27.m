% ПЗ 27, Григорьев Юрий
clc;
syms t;

a = -1; b = 1;

e0 = 1;
e0e0 = scalar_mult(e0, e0, a, b);

c01 = scalar_mult(t, e0, a, b) / e0e0;
e1 = t - c01 * e0;
e1
e1e1 = scalar_mult(e1, e1, a, b);

c02 = scalar_mult(t^2, e0, a, b) / e0e0;
c12 = scalar_mult(t^2, e1, a, b) / e1e1;
e2 = t * t - c02 * e0 - c12 * e1;
e2
e2e2 = scalar_mult(e2, e2, a, b);

c03 = scalar_mult(t^3, e0, a, b) / e0e0;
c13 = scalar_mult(t^3, e1, a, b) / e1e1;
c23 = scalar_mult(t^3, e2, a, b) / e2e2;
e3 = t * t * t - c03 * e0 - c13 * e1 - c23 * e2;
e3
e3e3 = scalar_mult(e3, e3, a, b);

c04 = scalar_mult(t^4, e0, a, b) / e0e0;
c14 = scalar_mult(t^4, e1, a, b) / e1e1;
c24 = scalar_mult(t^4, e2, a, b) / e2e2;
c34 = scalar_mult(t^4, e3, a, b) / e3e3;
e4 = t * t * t * t - c04 * e0 - c14 * e1 - c24 * e2 - c34 * e3;
e4

function res = scalar_mult(x, y, a, b) % скалярное произведение в весовом пространстве Лебега L2(xi):(a,b)
    syms xi(t);
    xi(t) = (sqrt(1 - t)/(1+t)^(1/3)); % весовая функция
    res = vpa(int(x * y * xi, t, a, b), 5);
end
function dx = myfun(t, x)

beta0 = x(5);
beta1 = x(6); 
beta2 = x(7);
beta3 = x(8);
alpha1 = x(9);
alpha2 = x(10);
alpha3 = x(11);
delta1 = x(12);
delta2 = x(13);
delta3 = x(14);
b0 = x(15);
uu = x(16);
y = x(17);
e = x(1) - y;
dx = zeros(17, 1);
dx(1) = x(2) - beta0 * e;
dx(2) = x(3) - beta1 * fal(e, 0.5, delta1);
dx(3) = x(4) - beta2 * fal(e, 0.25, delta2) + b0 * uu - (1.015361202246130 + 2.561803509670808e+02) * x(3) - (1.015361202246130 * 2.561803509670808e+02) * x(2);
dx(4) = - beta3 * fal(e, 0.125, delta3);
dx(5) = 0;
dx(6) = 0;
dx(7) = 0;
dx(8) = 0;
dx(9) = 0;
dx(10) = 0;
dx(11) = 0;
dx(12) = 0;
dx(13) = 0;
dx(14) = 0;
dx(15) = 0;
dx(16) = 0;
dx(17) = 0;

end


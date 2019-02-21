function dx = myfun(t, x)

beta0 = x(5);
beta1 = x(6); 
beta2 = x(7);
beta3 = x(8);
b0 = x(9);
uu = x(10);
y = x(11);
e = x(1) - y;
dx = zeros(11, 1);
dx(1) = x(2) - beta0 * e;
dx(2) = x(3) - beta1 * e;
dx(3) = x(4) - beta2 * e + b0 * uu;
dx(4) = - beta3 * e;
dx(5) = 0;
dx(6) = 0;
dx(7) = 0;
dx(8) = 0;
dx(9) = 0;
dx(10) = 0;
dx(11) = 0;


end


clc, clear 
close all

wq = 80 * 2 * pi;

Q1 = tf(0.2756 * wq ^ 4, [1, 0.9528 * wq, 1.4539 * wq * wq, 0.7426 * wq ^ 3, 0.2756 * wq ^ 4]);
Q2 = tf(wq ^ 4, [1, 4 * wq, 6 * wq * wq, 4 * wq ^ 3, wq ^ 4]);
bode(Q1);
grid on
hold on
bode(Q2);

K = 1.56 * 180 / pi;
taue = 0.0039035;
taum = 0.984871194396488;
b1  = 1 / taue;
b2 = 1 / taum;
b0 = K / (taue * taum);

%% «–±»—©∑Ú
beta4 = 0.2756 * wq ^ 4;
beta1 = 0.9528 * wq - b1 - b2;
beta2 = 1.4539 * wq * wq - b2 * beta1 - b1 * beta1 - b1 * b2;
beta3 = 0.7426 * wq ^ 3 - b2 * beta2 - b1 * beta2 - b1 * b2 * beta1;


%% º´µ„≈‰÷√
% beta4 = wq ^ 4;
% beta1 = 4 * wq - b1 - b2;
% beta2 = 6 * wq * wq - b2 * beta1 - b1 * beta1 - b1 * b2;
% beta3 = 4 * wq ^ 3 - b2 * beta2 - b1 * beta2 - b1 * b2 * beta1;



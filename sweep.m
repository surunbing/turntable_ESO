% function [model] = sweep(filename, bTf, bFt, bClose)
fre_start = 1;
fre_end = 100;

fre_array = fre_start : 1 : fre_end;

turntable_bode.fre = fre_array * 2 * pi;
turntable_bode.mag = zeros(length(fre_array), 1);
turntable_bode.phi = zeros(length(fre_array), 1);
% turntable_bode.magc = zeros(length(fre_array), 1);
% turntable_bode.phic = zeros(length(fre_array), 1);

Type = 1; %% sine
bTf = 0;  %% 0��Ħ��  1��Ħ��
bFt = 1;  %% 0 �����ز���  1 �����ز���
bClose = 1; %% 0 ���ջ�    1 �ջ�
bRp = 1; %% 0 г��   1 ��г��
Rfre = 30 * 2 * pi;
Rp = 2;

J = 1.076;
L = 0.733240176511722;
r = 80.116666666666666667;
Kt = 24.812626200641272;
Kv = 0.12;
Kps = 1.077250780790937e+02;

i = 1;
%% Sweep
for fre = fre_array
    
    t_off = 10;
    mag = 5;
    fre = fre_array(i);
    Tsim = t_off;
    %% 'Turntable_close.slx'
    %% 'Turntable_sweep.slx'
    sim(filename,Tsim);

    turntable_bode.magc(i) = 20 * log10(mag);
    turntable_bode.phic(i) = 0;

    y = fft(in_out(2000:18000, 2));
    y1 = fft(in_out(2000:18000, 3));
    fs = 2000;       %%����Ƶ��
    n =0: 1: length(in_out) - 1;
    N = length(in_out) - 4000;
    f = n * fs / N;    %Ƶ������
    Mag=abs(y);
    Mag1 = abs(y1);
    n_f = find(Mag == max(Mag));
    n_f = n_f(1);
    turntable_bode.mag(i) = 20 * (log10(Mag1(n_f)) - log10(Mag(n_f)));
    ang = angle(y1(n_f));
    if(ang < 0)
        ang = ang + 2 * pi;
    end
    ang1 = angle(y(n_f));
    if(ang1 < 0)
        ang1 = ang1 + 2 * pi;
    end
    turntable_bode.phi(i) = (ang - ang1) / pi * 180;
    i = i + 1;    
end
mag = 10 .^ (turntable_bode.mag / 20);
phi = turntable_bode.phi;
response = mag.*exp(1j*phi*pi/180);
fr_data = idfrd(response,turntable_bode.fre,0);
opt = procestOptions('Focus','simulation','Display','on','SearchMethod', 'fmincon');
sysP1D_noise = procest(fr_data,'P2I',opt);

G = tf(sysP1D_noise.Kp, [sysP1D_noise.Tp1 * sysP1D_noise.Tp2, sysP1D_noise.Tp1 + sysP1D_noise.Tp2, 1, 0]);
model.G = G;
model.Kp = sysP1D_noise.Kp;
if sysP1D_noise.Tp1 < sysP1D_noise.Tp2   
    model.taum = sysP1D_noise.Tp2;
    model.taue = sysP1D_noise.Tp1;
else
    model.taum = sysP1D_noise.Tp1;
    model.taue = sysP1D_noise.Tp2;
end
K = 1.56 * 180 / pi;
taue = 0.0039035;
taum = 0.984871194396488;
model.G_ideal = tf(K, [taue * taum, taue + taum, 1, 0]);
model.turntable = turntable_bode;




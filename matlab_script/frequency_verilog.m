M_cropped = dlmread("fout_14to32");
%M_cropped = M_cropped * G(1) * G(2);
Fs = 250;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 50000;            % Length of signal
t = (0:L-1)*T;        % Time vector
Y = fft(M_cropped);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs *(0:(L/2))/L;
P1 = mag2db(P1)
figure(1)
semilogx(f,P1);
title('Single-Sided Amplitude Spectrum of filtered Verilog output')
xlabel('f (Hz)')
ylabel('Amplitude (dB)')
xlim([10^(-2) 10^2])
ylim([-20 20])
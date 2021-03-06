test_data = load('testdataint.mat'); % your pre-filtered MATLAB data
test_data = test_data.seizuredata;
y_filt_sos = filter(b,a,test_data); % pass the data through the MATLAB filter

Fs = 250;             % Edit here to change sampling frequency                    
T = 1/Fs;             % Sampling period      
L = 50000;            % Length of signal
t = (0:L-1)*T;        % Time vector
Y = fft(y_filt_sos);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs *(0:(L/2))/L;
P1 = mag2db(P1)
figure(2);
semilogx(f,P1)
title('Single-Sided Amplitude Spectrum of filtered MATLAB output')
xlabel('f (Hz)')
ylabel('Amplitude (dB)')
xlim([10^(-2) 10^2])
ylim([-20 20])

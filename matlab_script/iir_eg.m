% Part1: Define the filter specifications. Please refer to
% "https://www.mathworks.com/help/signal/ref/butter.html" for a more detailed
% explanation
fs = 250; % Edit here to change sampling frequency (Hz)
wp = 8; % Edit here to change passband frequency
ws = 14; % Edit here to change stopband frequency
n = 1; % Edit here to change filter order. Order = 2*n
w1 = (2 * wp)/fs;
w2 = (2 * ws)/fs;
wn = [w1, w2];
[b, a] = butter(n, wn, 'bandpass'); % Edit the third argument to change filter type 
Q = 2^27; % Edit here to change Q-factor: the a and b coefficients will be scaled by in Verilog to maintain precision

% Part 2: Plot magnitude response of the filter
w = 0:0.01:pi;
[h, om] = freqz(b, a, w);
m = 20*log10(abs(h));
figure, semilogx(om/pi * (fs/2), m);
ylabel('Gain (dB)');
xlabel('Frequency (Hz)');
ylim([-20 5])

% Part 3: A sine wave is created to check response
ts = 1/fs;
t = 0:ts:3;

f = 6; % Edit here to change frequency of sine wave
x = sin(2*pi*f*t);
figure, plot(t, x);
hold on
y = filter(b, a, x);
plot(t, y);

% Part 3: Write sine wave in a file. To be used in Verilog testbench.
fid2 = fopen('fin', 'wt');
for i = 1:size(x, 2)
    fprintf(fid2, '%.0f\n', x(i) * Q);
end
fclose(fid2);

% Part 4: Generate a and b coefficients in a file. To be used in Verilog.
coe1 = fopen('coe_a.txt', 'wt');
for i = 2:size(a, 2)
    fprintf(coe1, 'assign a%d = %.0f;\n', i, a(i)* Q );
end
fclose(coe1);

coe2 = fopen('coe_b.txt', 'wt');
for i = 1:size(b, 2)
    fprintf(coe2, 'assign b%d = %.0f;\n', i, b(i) * Q);
end
fclose(coe2);

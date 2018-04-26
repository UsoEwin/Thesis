% filter specifications
fs = 250; % sampling frequency (Hz)
wp = 8; % passband frequency
ws = 14; % stopband frequency
n = 1; % filter order = 2*n = 2
w1 = (2 * wp)/fs;
w2 = (2 * ws)/fs;
wn = [w1, w2];
[b, a] = butter(n, wn, 'bandpass');
Q = 2^27;

% plot magnitude response
w = 0:0.01:pi;
[h, om] = freqz(b, a, w);
m = 20*log10(abs(h));
figure, semilogx(om/pi * (fs/2), m);
ylabel('Gain (dB)');
xlabel('Frequency (Hz)');
ylim([-20 5])

% create signal and check response
ts = 1/fs;
t = 0:ts:3;





f = 6;
x = sin(2*pi*f*t);
figure, plot(t, x);
hold on
y = filter(b, a, x);
plot(t, y);

fid2 = fopen('fin', 'wt');
for i = 1:size(x, 2)
    fprintf(fid2, '%.0f\n', x(i) * Q);
end
fclose(fid2);

coe1 = fopen('coe_a.txt', 'wt');
for i = 1:size(a, 2)
    fprintf(coe1, 'assign a%d = %.0f;\n', i, a(i)* Q );
end
fclose(coe1);

coe2 = fopen('coe_b.txt', 'wt');
for i = 1:size(b, 2)
    fprintf(coe2, 'assign b%d = %.0f;\n', i, b(i) * Q);
end
fclose(coe2);

% write data to file
% fileID = fopen('110hz.txt','w');
% fprintf(fileID, '%f\n', x);
% fclose(fileID);

h  = fdesign.bandpass('N,F3dB1,F3dB2', 6, 1, 70, 250);
Hd = design(h, 'butter');
fs = 250;
t = 0:1/250:0.5-1/250;
f = 50;
y = sin(2*pi*f*t);
yout = filter(Hd, y);
plot(t, yout);
fid1 = fopen('fout', 'wt');
for i = 1:size(yout, 2)
    fprintf(fid1, '%.0f', yout(i) * 10^8);
    fprintf(fid1, '\n');
end
fclose(fid1);
fid2 = fopen('fin', 'wt');
for i = 1:size(y, 2)
    fprintf(fid2, '%.0f', y(i) * 10^8);
    fprintf(fid2, '\n');
end
fclose(fid2);
clear;
clc;
h = fdesign.bandpass('N,F3dB1,F3dB2',6,1,70,250);
Hd = design(h,'butter');
fs = 1000;
t = 0:1/250:1;
f = 100;
y = sin(2*pi*f*t);
yout = filter(Hd,y);
plot(t,yout);
save('sin_fs250.mat','y')
save('sin_yout.mat','yout')
save('sin_fs250.txt','y','-ascii');
save('sin_yout.txt','yout','-ascii');

%fc = 70;
%fs = 250;

%[b,a] = butter(6,fc/(fs/2));
%freqz(b,a)
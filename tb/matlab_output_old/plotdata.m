load testdataint.mat;

t = 1:50001;
seizurefirst = find(seizuretag,1,'first');
seizurelast = find(seizuretag,1,'last');
vectorsize = seizurelast-seizurefirst+1;

t1 = linspace(seizurefirst,seizurelast,vectorsize);
seizuring = seizuredata(seizurefirst:seizurelast);
% deal with the data
%seizuring  = seizuretag.*seizuredata;

figure(1);

plot(t,seizuredata,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(50001 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
grid on;
axis([0 50001 min(seizuredata) max(seizuredata)]);

llth = zeros(1,50001) + 3000;
psth = zeros(1,50001) + 1e7;
neth = zeros(1,50001) + 250000;
dll = dlmread('llout.txt');
dps = dlmread('psout.txt');
dne = dlmread('neout.txt');


figure(2);
subplot(2,1,1); 
plot(t,seizuredata,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(50001 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 50001 min(seizuredata) max(seizuredata)]);
grid on;

subplot(2,1,2);
plot(t,dll,'-b');
hold on;
%plot(t,llth,'-p');
title('Line length data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 50001 min(dll) max(dll)]);

figure(3);
subplot(2,1,1); 
plot(t,seizuredata,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(50001 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 50001 min(seizuredata) max(seizuredata)]);
grid on;

subplot(2,1,2);
plot(t,dps,'-b');
hold on;
%plot(t,psth,'-p');
title('Power spectrum data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 50001 min(dps) max(dps)]);

figure(4);
subplot(2,1,1); 
plot(t,seizuredata,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(50001 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 50001 min(seizuredata) max(seizuredata)]);
grid on;

subplot(2,1,2);
plot(t,dne,'-b');
hold on;
%plot(t,neth,'-p');
title('Nonlinear energy data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 50001 min(dne) max(dne)]);
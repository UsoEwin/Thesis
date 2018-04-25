load final_data.mat;

%plot the original seizure
t = 1:323751;
t2 = 1:320000;
seizurefirst = seizureStart_index;

seizurelast = seizureEnd_index;
vectorsize = seizurelast-seizurefirst+1;

t1 = linspace(seizurefirst,seizurelast,vectorsize);
seizuring = data(seizurefirst:seizurelast);

figure(1);

plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
grid on;
axis([0 323751 min(data) max(data)]);

%original figures

%llth = zeros(1,50001) + 3000;
%psth = zeros(1,50001) + 1e7;
%neth = zeros(1,50001) + 250000;
dll = dlmread('datapath_out_ll');
dps = dlmread('datapath_out_ps');
dne = dlmread('datapath_out_ne');
dpsalpha = dlmread('datapath_out_alpha');
dpsbeta = dlmread('datapath_out_beta');
dpstheta = dlmread('datapath_out_theta');

figure(2);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dll,'-b');
hold on;
%plot(t,llth,'-p');
title('Line length data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dll) max(dll)]);

figure(3);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dps,'-b');
hold on;
%plot(t,psth,'-p');
title('Power spectrum data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dps) max(dps)]);

figure(4);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dne,'-b');
hold on;
%plot(t,neth,'-p');
title('Nonlinear energy data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dne) max(dne)]);

figure(5);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpsalpha,'-b');
hold on;
%plot(t,neth,'-p');
title('Power spectrum alpha band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dpsalpha) max(dpsalpha)]);

figure(6);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpsbeta,'-b');
hold on;
%plot(t,neth,'-p');
title('Power spectrum beta band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dpsbeta) max(dpsbeta)]);

figure(7);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([0 320000 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpstheta,'-b');
hold on;
%plot(t,neth,'-p');
title('Power spectrum theta band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([0 320000 min(dpstheta) max(dpstheta)]);
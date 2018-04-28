load final_data.mat;

%plot(datapath_out_ll(150000:173759, :))

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
xlabel('data indices','FontSize',22) 
ylabel('sensor values','FontSize',22) 
grid on;
axis([0 323751 min(data) max(data)]);



dll = dlmread('datapath_out_ll');
dps = dlmread('datapath_out_ps');
dne = dlmread('datapath_out_ne');
dpsalpha = dlmread('datapath_out_alpha');
dpsbeta = dlmread('datapath_out_beta');
dpstheta = dlmread('datapath_out_theta');
baselinell = dlmread('datapath_out_ll_bs');
baselineps = dlmread('datapath_out_ps_bs');
baselinealpha = dlmread('datapath_out_alpha_bs');
baselinebeta = dlmread('datapath_out_beta_bs');
baselinetheta = dlmread('datapath_out_theta_bs');
baselinene = dlmread('datapath_out_ne_bs');
thll = 5*baselinell;
thne = 14*baselinene;
thps = 6*baselineps;
ththeta = 5*baselinetheta;
thalpha = 12*baselinealpha;
thbeta = 14*baselinebeta;
figure(2);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dll,'-b');
hold on;
plot(t2,baselinell,'Color',[0.85 0.33 0.10]);
%plot(t,llth,'-p');
hold on;
plot(t2,thll*1.8,'-g');
legend({'linelength output','baseline','threshold'},'FontSize',22);
title('Line length data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dll) max(dll)]);

figure(3);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dps,'-b');
hold on;
plot(t2,baselineps,'Color',[0.85 0.33 0.10]);
hold on;
plot(t2,thps*1.8,'-g');
legend({'power spectrum output','baseline','threshold'},'FontSize',22);
title('Power spectrum data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dps) max(dps)]);

figure(4);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dne,'-b');
hold on;
plot(t2,baselinene,'Color',[0.85 0.33 0.10]);
hold on;
plot(t2,thne*1.8,'-g');
legend({'nonlinear energy output','baseline','threshold'},'FontSize',22);
title('Nonlinear energy data output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dne) max(dne)]);

figure(5);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpsalpha,'-b');
hold on;
plot(t2,baselinealpha,'Color',[0.85 0.33 0.10]);
hold on;
plot(t2,thalpha*1.8,'-g');
legend({'alpha band output','baseline','threshold'},'FontSize',22);
title('Power spectrum alpha band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dpsalpha) max(dpsalpha)]);

figure(6);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpsbeta,'-b');
hold on;
plot(t2,baselinebeta,'Color',[0.85 0.33 0.10]);
hold on;
plot(t2,thbeta*1.8,'-g');
legend({'beta band output','baseline','threshold'},'FontSize',22);
title('Power spectrum beta band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dpsbeta) max(dpsbeta)]);

figure(7);
subplot(2,1,1); 
plot(t,data,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(323751 data points)','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('sensor values','FontSize',22) % y-axis label
axis([150000 173759 min(data) max(data)]);
grid on;

subplot(2,1,2);
plot(t2,dpstheta,'-b');
hold on;
plot(t2,baselinetheta,'Color',[0.85 0.33 0.10]);
hold on;
plot(t2,ththeta*1.8,'-g');
legend({'theta band output','baseline','threshold'},'FontSize',22);
title('Power spectrum theta band output from simulation','FontSize',22);
xlabel('data indices','FontSize',22) % x-axis label
ylabel('feature module outputs','FontSize',22) % y-axis label
grid on;
axis([150000 173759 min(dpstheta) max(dpstheta)]);
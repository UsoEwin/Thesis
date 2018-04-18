load testdataint.mat;

t = 1:50001;
seizurefirst = find(seizuretag,1,'first');
seizurelast = find(seizuretag,1,'last');
vectorsize = seizurelast-seizurefirst+1;

t1 = linspace(seizurefirst,seizurelast,vectorsize);
seizuring = seizuredata(seizurefirst:seizurelast);
% deal with the data
%seizuring  = seizuretag.*seizuredata;
plot(t,seizuredata,'-b');
hold on;
plot(t1,seizuring,'-r');
title('Original seizure data(50001 data points)');
xlabel('data indices') % x-axis label
ylabel('sensor values') % y-axis label
axis([0 50001 min(seizuredata) max(seizuredata)]);
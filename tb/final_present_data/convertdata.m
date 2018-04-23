clc;
clear;
load final_data;
dataint = int16(data);

dlmwrite('final_data.txt', dataint,'\n');


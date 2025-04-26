clc; clear;

import = load('Data\Layup1\L1_S11_F\PZT-data\L1S11_0_0.mat');

n

figure;
hold on;
plot(import.coupon.path_data(1).signal_actuator);
plot(import.coupon.path_data(1).signal_sensor);
hold off;
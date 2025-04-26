% all of these are clamped

% having distinct names for each

% cycles_0 = load("L1S11_0_2_1.mat", "coupon");
% cycles_1k = load("PZT-data/L1S11_1000_2_1.mat", "coupon");
% cycles_10k = load("PZT-data/L1S11_10000_2_1.mat", "coupon");
% cycles_20k = load("PZT-data/L1S11_20000_2_1.mat", "coupon");
% cycles_30k = load("PZT-data/L1S11_30000_2_3.mat", "coupon");
% cycles_40k = load("PZT-data/L1S11_40000_2_1.mat", "coupon");
% cycles_50k = load("PZT-data/L1S11_50000_2_1.mat", "coupon");
% cycles_60k = load("PZT-data/L1S11_60000_2_1.mat", "coupon");
% cycles_70k = load("PZT-data/L1S11_70000_2_1.mat", "coupon");
% cycles_80k = load("PZT-data/L1S11_80000_2_1.mat", "coupon");
% cycles_90k = load("PZT-data/L1S11_80000_1_2.mat", "coupon");

% forgoing disctinct names
cycles(1) = load("PZT-data/L1S11_0_2_1.mat", "coupon");
cycles(2) = load("PZT-data/L1S11_0_2_2.mat", "coupon");
cycles(3) = load("PZT-data/L1S11_0_2_4.mat", "coupon");
cycles(4) = load("PZT-data/L1S11_10_2_1.mat", "coupon");
cycles(5) = load("PZT-data/L1S11_100_2_1.mat", "coupon");
cycles(6) = load("PZT-data/L1S11_1000_2_1.mat", "coupon");

figure(1)
% graph actuator data for each number of cycles up to 90k, actuator no. 6
subplot(1,2,1)
hold on
n = 30;
for i = 1:6
    plot(cycles(i).coupon.path_data(n).signal_actuator)
end

% graph sensor data for each number of cycles up to 90k, sensor no. 7
subplot(1,2,2)
hold on
% for i = [1 2 3 4 5 6]
%     plot(cycles(i).coupon.path_data(n).signal_sensor)
% end
% legend("1", "2", "3", "4", "5", "6")

% take data points after 500 and get RMS
for i = [1 2 3 4 5 6]
    data_temp = cycles(i).coupon.path_data(n).signal_sensor - cycles(1).coupon.path_data(n).signal_sensor;
    RMS = sqrt(sum(data_temp(500:length(data_temp)).^2));
    disp(RMS)
end
legend("1", "2", "3", "4", "5", "6")

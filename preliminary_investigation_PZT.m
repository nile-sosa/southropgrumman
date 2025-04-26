%% compare 
hold on
clf;
n = 31;
subplot(1,3,1)
plot(coupon.path_data(n).signal_actuator, coupon.path_data(n).signal_sensor)
subplot(1,3,2)
plot(coupon.path_data(n).signal_sensor, "color", "blue")
hold on
plot(coupon.path_data(n).signal_actuator, "color", "red")
ylabel(strcat("actuator no. ",num2str(coupon.path_data(n).actuator)))
subplot(1,3,3)
plot(coupon.path_data(n).signal_sensor)
ylabel(strcat("sensor no. ",num2str(coupon.path_data(n).sensor)))

%% observe the actuator signal data
clf;
hold on
for n = 1
    plot(coupon.path_data(n).signal_actuator)
end
% weird amplitudes (from 37 to 72): 52,57, 62, 47
    % its bc amplitude ~= 65

%% compare inout and output
clf;
n = 31;
plot(coupon.path_data(n).signal_sensor, "color", "blue")
hold on
plot(coupon.path_data(n).signal_actuator, "color", "red")
ylabel(strcat("actuator no. ",num2str(coupon.path_data(n).actuator)))
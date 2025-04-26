hold on
clf;
n = 7;
subplot(1,3,1)
plot(coupon.path_data(n).signal_actuator, coupon.path_data(n).signal_sensor)
subplot(1,3,2)
% plot(coupon.path_data(n).signal_sensor, "color", "blue")
% hold on
plot(coupon.path_data(n).signal_actuator, "color", "red")
subplot(1,3,3)
plot(coupon.path_data(n).signal_sensor)
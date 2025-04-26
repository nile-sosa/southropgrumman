%% Test import

a1 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F00_DAT.mat');
a2 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_A_DAT.mat');
a3 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_M_DAT.mat');
a4 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_S_DAT.mat');

% Plot all 4 datasets
figure;
subplot(2,2,1);
plot(a1.strain1);
title('L1_S11_F00');

subplot(2,2,2);
plot(a2.strain1);
title('L1_S11_F01_A');

subplot(2,2,3);
plot(a3.strain1);
title('L1_S11_F01_M');

subplot(2,2,4);
plot(a4.strain1);
title('L1_S11_F01_S');
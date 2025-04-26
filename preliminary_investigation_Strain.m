clc; clear;

import1 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F00_DAT.mat');
import2 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_A_DAT.mat');
import3 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_M_DAT.mat');
import4 = load('Data\Layup1\L1_S11_F\StrainData\L1_S11_F01_STRAIN_S_DAT.mat');

n=1;


subplot(2,2,1);
hold on;
plot(import1.strain1);
hold off;

subplot(2,2,2);
hold on;
plot(import2.strain1);
hold off;

subplot(2,2,3);
hold on;
plot(import3.strain1);
hold off;

subplot(2,2,4);
hold on;
plot(import2.strain1);
hold off;
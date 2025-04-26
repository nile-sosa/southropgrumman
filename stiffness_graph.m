clc; clear;
folderPath = ('C:\Users\framework\OneDrive - University of Southern California\MATLAB\Makeathon\southropgrumman\Data\Layup1\L1_S11_F\PZT-data');
filePattern = fullfile(folderPath, '*.mat');
matFiles = dir(filePattern);
n = length(matFiles);

stiffnessPlot = 0;
import = cell(n,1);
for i = 1:n
    tempzt = load(fullfile(folderPath, matFiles(i).name));
    stiffnessPlot = [stiffnessPlot, tempzt.coupon.straingage_data.stiffness_degradation];
end

figure;
plot(stiffnessPlot);
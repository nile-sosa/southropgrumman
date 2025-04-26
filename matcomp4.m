clc; clear; close all; 

imported_strain = load('/Users/melaniamirijanian/Documents/MATLAB/matlabcomp/Data/Layup1/L1_S12_F/StrainData/L1_S12_F00_DAT.mat');
plot(imported_strain.strain1);

%% Setup
strainFolder = '/Users/melaniamirijanian/Documents/MATLAB/matlabcomp/Data/Layup1/L1_S12_F/StrainData/';
xrayFolder = '/Users/melaniamirijanian/Documents/MATLAB/matlabcomp/XRAY/';

% Load strain files
strainFiles = dir(fullfile(strainFolder, 'L1_S12_F*_DAT.mat'));
nFiles = length(strainFiles);

% Initialize storage
averageStrain = zeros(nFiles, 1);
damageAreas = zeros(nFiles, 1);
cycleNumbers = zeros(nFiles, 1);

%% Step 1: Analyze Strain Data
for k = 1:nFiles
    strainData = load(fullfile(strainFolder, strainFiles(k).name));
    if isfield(strainData, 'strain1')
        averageStrain(k) = mean(strainData.strain1);
    else
        averageStrain(k) = NaN;
    end
    cycleNumbers(k) = (k-1)*50000; % assuming every 50k cycles
end

%% Step 2: Analyze X-Ray Data
xrayFiles = dir(fullfile(xrayFolder, '*.jpg')); 
for k = 1:min(length(xrayFiles), nFiles)
    img = imread(fullfile(xrayFolder, xrayFiles(k).name));
    if size(img,3) == 3
        grayImg = rgb2gray(img);
    else
        grayImg = img;
    end

    enhancedImg = imadjust(grayImg);
    filteredImg = medfilt2(enhancedImg);
    bw = imbinarize(filteredImg, 'adaptive', 'Sensitivity', 0.5);
    bwClean = bwareaopen(bw, 50);

    damageAreas(k) = sum(bwClean(:));
end

% Match lengths
minLength = min(length(averageStrain), length(damageAreas));
averageStrain = averageStrain(1:minLength);
damageAreas = damageAreas(1:minLength);
cycleNumbers = cycleNumbers(1:minLength);

%% Step 3: Advanced Damage Detection

% Use moving average of damage areas
windowSize = 3;
damageSmooth = movmean(damageAreas, windowSize);

% Dynamic threshold: mean of first few points + 2 standard deviations
baseline = mean(damageAreas(1:3));
stdBaseline = std(damageAreas(1:3));
dynamicThreshold = baseline + 2*stdBaseline;

% Detect when damage first exceeds threshold
damageDetectedIdx = find(damageSmooth > dynamicThreshold, 1, 'first');

% Severity classification
damageSeverity = strings(length(damageAreas),1);
for i = 1:length(damageAreas)
    if damageAreas(i) < dynamicThreshold
        damageSeverity(i) = "Safe";
    elseif damageAreas(i) < 2 * dynamicThreshold
        damageSeverity(i) = "Moderate";
    else
        damageSeverity(i) = "Severe";
    end
end

%% Step 4: Plot
figure;
yyaxis left
plot(cycleNumbers, averageStrain, 'b-o', 'LineWidth', 2);
ylabel('Average Strain (microstrain)');
yyaxis right
plot(cycleNumbers, damageAreas, 'r-s', 'LineWidth', 2);
hold on;
yline(dynamicThreshold, '--k', 'Threshold', 'LineWidth', 2);
ylabel('Crack Area (pixels)');
xlabel('Cycle Number');
title('Advanced Damage Detection: Strain and Crack Area');
grid on;
legend('Avg Strain', 'Crack Area', 'Threshold', 'Location', 'northwest');
hold off;

% Highlight detected damage point
if ~isempty(damageDetectedIdx)
    hold on;
    xline(cycleNumbers(damageDetectedIdx), '--g', 'First Damage Detected', 'LineWidth', 2);
    hold off;
end

% Save the figure
saveas(gcf, 'DamageDetectionPlot.png');

%% Step 5: Advanced Report
if ~isempty(damageDetectedIdx)
    fprintf('⚡ Damage first detected at cycle: %d\n', cycleNumbers(damageDetectedIdx));
    fprintf('⚡ Strain at detection: %.2f microstrain\n', averageStrain(damageDetectedIdx));
    fprintf('⚡ Crack area at detection: %d pixels\n', damageAreas(damageDetectedIdx));

    % Smart inspection recommendation
    if damageAreas(damageDetectedIdx) < 2*dynamicThreshold
        fprintf('✅ Recommendation: Start inspections every 20,000 cycles after %d cycles.\n', cycleNumbers(damageDetectedIdx));
    else
        fprintf('⚠️  URGENT: Start inspections every 10,000 cycles after %d cycles!\n', cycleNumbers(damageDetectedIdx));
    end
else
    fprintf('✅ No significant damage detected within analyzed cycles.\n');
end

% Print severity at each cycle
fprintf('\nCycle-wise Damage Severity:\n');
for i = 1:length(cycleNumbers)
    fprintf('Cycle %6d: %s\n', cycleNumbers(i), damageSeverity(i));
end
fprintf('===============================================\n');

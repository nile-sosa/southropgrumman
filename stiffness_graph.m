clc; clear;

force = 17793; %newtons
folderPath = 'Data\Layup1\L1_S11_F\StrainData';

% Initialize strain structure
strain = struct('name', {}, 'data', {});
strain(1).name = 'a';
strain(2).name = 'm';
strain(3).name = 's';
strain(1).data = {};
strain(2).data = {};
strain(3).data = {};

cycles = [1, 10,100,1000,10000,20000,30000,40000,50000,60000,70000,80000,90000,100000,125000,150000,175000,227000];

for n = 1:1:3
    fileType = ['A','M','S'];
    fileTag = strcat('*', fileType(n), '_DAT.mat');
    filePattern = fullfile(folderPath, fileTag);
    matFiles = dir(filePattern);
    
    for i = 1:length(matFiles)
        fullFileName = fullfile(matFiles(i).folder, matFiles(i).name);
        imported_strain = load(fullFileName);
        strain(n).data{i} = imported_strain.strain1;
    end
end

maxAStrain = [];
for n = 1:1:18
    maxAStrain = [maxAStrain max(strain(1).data{n})];
end

maxMStrain = [];
for n = 1:1:18
    maxMStrain = [maxMStrain max(strain(2).data{n})];
end

maxSStrain = [];
for n = 1:1:18
    maxSStrain = [maxSStrain max(strain(3).data{n})];
end

figure;
subplot(1,3,1);
plot(cycles, maxAStrain);
title("A Strain")

subplot(1,3,2);
plot(cycles, maxMStrain);
title("M Strain")

subplot(1,3,3);
plot(cycles, maxSStrain);
title("F Strain")

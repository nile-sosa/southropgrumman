%% Strain
%  tthis currently imports all sets of graphs.

clc; clear; close all;
%% Header section
function sortedList = natsortfiles(fileList)
    [~,idx] = sort_nat({fileList.name});
    sortedList = fileList(idx);
end

function [cs,index] = sort_nat(c,mode)
% Natural order sort of cell array of strings
    if nargin < 2
        mode = 'ascend';
    end
    [~,ndx] = sort(lower(regexprep(c,'\d+','${char(0)}$0')));
    cs = c(ndx);
    if strcmpi(mode,'descend')
        cs = cs(end:-1:1);
        ndx = ndx(end:-1:1);
    end
    index = ndx;
end
%% Start of Loops
% Set the folder path
folderPath = 'Data\Layup1\L1_S11_F\StrainData\';

% Get a list of all .mat files
fileList = dir(fullfile(folderPath, '*.mat'));

% Sort file names naturally
fileList = natsortfiles(fileList);

% Preallocate a cell array to store loaded data
data = cell(length(fileList),1);

% Load all files
for k = 1:length(fileList)
    filePath = fullfile(folderPath, fileList(k).name);
    data{k} = load(filePath); % load strain1 directly
end

% Set group size (4 files per group)
groupSize = 4;
numGroups = floor(length(data) / groupSize);

% Plot each group
for g = 1:numGroups
    figure;
    for i = 1:groupSize
        idx = (g-1)*groupSize + i;

        subplot(2,2,i);
        plot(data{idx}.strain1); % <== DIRECTLY strain1
        title(fileList(idx).name, 'Interpreter', 'none');
    end
end
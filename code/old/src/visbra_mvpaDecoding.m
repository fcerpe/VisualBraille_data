%% VISual BRAille DECODING ANALYSIS
%

clear;
clc;

%% GET PATHS, CPP_SPM, OPTIONS

% spm
% spm
warning('off');
% cosmo
cosmo = '~/Applications/CoSMoMVPA-master';
addpath(genpath(cosmo));
cosmo_warning('once');

% libsvm
libsvm = 'Users/Applications/libsvm';
addpath(genpath(libsvm));
% verify it worked.
cosmo_check_external('libsvm'); % should not give an error

% add cpp repo
cpp_spm('init')

% load options
opt = mvpa_getOption();

%%
opt.taskName = opt.taskName{1};

%% SET UP MASKS AND VOXELS

% a bit redundant, these steps are repeated in the accuracy functions.
% It's useful at the beginning to understand the steps and adapt scripts to

% get how many voxels are active / significant in each ROI
maskVoxel = calculateMaskSize(opt);

% keep the minimun value of voxels in a ROI as ratio to keep (must be
% constant)
opt.mvpa.ratioToKeep = min(maskVoxel); % 363;%157 for sub-001 and 392 for sub-002 % 100 150 250 350 420

%% GO GET THAT ACCURACY!

% Within modality (maybe I need a more fitting name):
% training set and test set both contain french and braille stimuli, learn
% to distinguish between them
mvpaWithin = calculateMvpaWithinModality(opt);

%%
% "Cross-modal" decoding: training on one script (french or braille), test
% on the other
mvpaCross = calculateMvpaCrossModal(opt);

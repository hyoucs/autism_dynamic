%% -- DISM with brain data
clear all;close all; clc;
load ../../../autism_private/data/correlation/cc200-fg-wcorr-WL10TR-pc/dips_data.mat 

data = dataAll{3};

% opt.lambda1s = [logspace(2.5, 0, 9) 0]/1000;
% opt.lambda2s = [0 0.1 0.5 1 2];

opt.lambda1s = [0.15];
opt.lambda2s = [0.1];

opt.bLinear = 0; 
opt.alpha = .2; 
opt.k = 50;
opt.nFeaUpd = .8; 
opt.verbose = 1;

tStart = tic; 
m = dipsFold(data, opt, 1); 
toc(tStart)
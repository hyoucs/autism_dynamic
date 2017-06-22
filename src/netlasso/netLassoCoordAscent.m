function model = netLassoCoordAscent(data)

% function model = regCoordAscent(data,options,lambda1) % separate lambda1 for parfor
%------------------------------------------------------------------------%
% Max.obj.: ||y-Xa||^2 + lambda2*a'Ca + lambda1*|a|, using coordinate ascent
%
% Input:
%     + data: struct data type
%           .X[nFea nSmp]: dataset X (no need?)
%           .y[1 nSmp]: mapped point in 1-dim subspace
%           .W[nFea nFea]: network adjacency matrix
%     + options: structure
%           .lambda1:   L1 parameter for sparsness 
%           .lambda2:   L2 parameter for smoothness
%           .a [nFea 1]: initial regression coeff
%           .verbose: boolean, used to print out results
%           .nFeaUpd: number of features to be randomly updated (nFeaUpd<1,
%           then, it is percentage)
%------------------------------------------------------------------------%






% - - - - - - - - - - - - - IMPORT - - - - - - - - - - - - - - - - - 

% import data
data = c2s(data);
X = data.X;	% loading features
y = data.y;	% labels to column vector format
[nFea,nSmp] = size(X);
W = full(data.W);	% W maybe sparse		
W = max(W, W); 	% symmetrize adjacent matrix
clear data;

% import parameter for l1 penalty
lambda1 = 0.1;
if isfield(options,'lambda1'),
    lambda1 = options.lambda1;
end

% import number of features to be updated randomly at each iteration
nFeaUpd = nFea;
if isfield(options,'nFeaUpd'),
    if options.nFeaUpd <=1
        % percentage of no. of features
        nFeaUpd = floor(options.nFeaUpd*nFea);
    else
        % exact number of features
        nFeaUpd = options.nFeaUpd;
    end
end

% import parameter for quadratic penalty
lambda2 = 0.1;
if isfield(options,'lambda2'),
    lambda2 = options.lambda2;
end

% import initial point in optimization
if isfield(options,'u'),
    u = options.u; 
else
    u = (X*X' + 0.01*eye(nFea))\(X*y); % ridge
    % u = rand(nFea,1); % initialize by random
end

% import flag for printing
verbose = 0;
if isfield(options,'verbose'),
    verbose = options.verbose; 
end
if verbose       %Start the log
    fprintf('%10s %15s %15s\n','iter','sum(|u|)','sum(|u_{k} - u_{k-1}|)');
end





% - - - - - - - - - - - - - DO WORK - - - - - - - - - - - - - - - - - 

% compute graph Laplacian from adjacency matrix
D = diag(sum(W,2));
C = D-W; 
clear W D;

% % alternative: symmetric normalized Laplacian
% D = diag(sum(W,2));
% C = eye(nFea)-D^(1/2)*W*D^(1/2);
% clear W D;

% % alternative: random-walk normalized Laplacian
% D = diag(sum(W,2));
% C = eye(nFea)-D^(-1)*W;
% clear W D;

% coordinate descent
maxIter = 500;
optTol = 1e-5;

% keep track of coefficient vector u in each iteration
u_log = zeros(nFea,maxIter);
u_log(:,1) = u;

% prepare meta variables
XGram 	= X*X';
XCov	= diag(XGram);
XFit	= X*y;

iter 	= 0;
while iter < maxIter
	u_prev = u;
	% randomly update nFeaUpd features in each iteration 
	for k = 1:nFeaUpd





















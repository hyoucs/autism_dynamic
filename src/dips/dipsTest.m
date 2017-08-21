% function dipsTest(in_file)

	%% -- DISM with brain data
	% in_file = '../../../autism_private/data/correlation/cc200-fng-wcorr-whole-session-pc/dips_data.mat';
	in_file = '../../../autism_private/data/correlation/cc200-fg-wcorr-WL10TR-pc/dips_data.mat';
	load(in_file);

	% generate cross validation test set
	if ~isfield(data,'testSet')
		nFold = 10;
        CVO = cvpartition(data.gnd,'Kfold',nFold);
		data.testSet = zeros(size(data.gnd));
        for i = 1:nFold
            data.testSet(CVO.test(i)~=0)=i;
        end
		save(in_file,'data');
	    disp('... New TestSet Generated ...');
	end

	% generate pairwise distance matrix
	opt = [];
	opt.type = 'Cosine';
	opt.distOrderAscend = false;
	[pathstr,name,ext] = fileparts(in_file);
	pw_file = [pathstr,'/dips_pwdist_',opt.type,ext];
	if exist(pw_file,'file')
		disp('... loading pairwise distance matrix ...');
		load(pw_file);
		data.A = pw.A;
	else
		disp('... generate pairwise distance matrix ...');
		pw.A = pwDist(data.X',data.X',opt);
		save(pw_file,'pw');
		data.A = pw.A;
	end
	clear pw;



	disp('... run dips for cv folds ...');
	% opt.lambda1s = [1, 0.75, 0.5, logspace(2.5, 0, 9) 0]/1000;
	% opt.lambda2s = [0];

	opt.lambda1s = [.01];
	% opt.lambda1s = [.01,.02,.05,.1,.2,.3,.5];
	% opt.lambda1s = [.01];
	opt.lambda2s = [0];

	opt.svm = false;
	opt.bLinear = 0; 
	opt.beta = 0.5;
	opt.k = 20;
	opt.nFeaUpd = .8; 
	opt.verbose = 1;
	opt.d = 1;

	tStart = tic; 
	[m, m2] = dipsFold(data, opt, 2); 
	toc(tStart)

	save('../../../autism_private/data/output.mat','m','m2','opt');


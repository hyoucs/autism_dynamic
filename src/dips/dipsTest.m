function dipsTest(in_file)

	%% -- DISM with brain data
	in_file = '../../../autism_private/data/correlation/cc200-fg-wcorr-whole-session-pc/dips_data.mat';
	% in_file = '../../../autism_private/data/correlation/cc200-fg-wcorr-WL10TR-pc/dips_data.mat';
	load(in_file);

	% generate cross validation test set
	if ~isfield(data,'testSet')
		nFold = 10;
		data.testSet = crossvalind('Kfold', size(data.X,1), nFold);
		save(in_file,'data');
	    disp('New TestSet Generated');
	end

	% generate pairwise distance matrix
	opt = [];
	opt.type = 'Eucl';
	[pathstr,name,ext] = fileparts(in_file);
	pw_file = [pathstr,'/dips_pwdist_',opt.type,ext];
	if exist(pw_file,'file')
		load(pw_file);
		data.A = pw.A;
	else
		pw.A = pwDist(data.X',data.X',opt);
		save(pw_file,'pw');
		data.A = pw.A;
	end
	clear pw;




	% opt.lambda1s = [1, 0.75, 0.5, logspace(2.5, 0, 9) 0]/1000;
	opt.lambda2s = [0];

	% lambda1 = 0.075 still too large
	opt.lambda1s = [.1:.01:.2];
	% opt.lambda2s = [0.1];

	opt.bLinear = 0; 
	opt.alpha = .2; 
	opt.k = 20;
	opt.nFeaUpd = .8; 
	opt.verbose = 1;
	opt.d = 1;

	tStart = tic; 
	m = dipsFold(data, opt, 1); 
	toc(tStart)

end
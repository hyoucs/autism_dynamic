
	
	% compute correlation matix for each window
	opt = [];
    opt.WL = 10;
    opt.dir_ts = '../../../autism_private/data/download/cc200-fg';
    opt.dir_output = '../../../autism_private/data/correlation';
    opt.dir_prefix = 'cc200-fg-wcorr-WL10TR-pc';
    abideCreateCorr(opt);

    % transform to DIPS input format
    opt.corr_dir = '../../../autism_private/data/correlation/cc200-fg-wcorr-WL10TR-pc/mat';
    data = dipsFormat(corr_dir);




	% compute correlation matix for each window
	opt = [];
    opt.WL = 20;
    opt.dir_ts = '../../../autism_private/data/download/cc200-fg';
    opt.dir_output = '../../../autism_private/data/correlation';
    opt.dir_prefix = 'cc200-fg-wcorr-WL20TR-pc';
    abideCreateCorr(opt);

    % transform to DIPS input format
    opt.corr_dir = '../../../autism_private/data/correlation/cc200-fg-wcorr-WL20TR-pc/mat';
    data = dipsFormat(opt);
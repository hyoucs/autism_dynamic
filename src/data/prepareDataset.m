
	
	% compute correlation matix for each window
	opt = [];
    opt.WL = 10;
    opt.dir_ts = '../../../autism_private/data/download';
    opt.dir_output = '../../../autism_private/data/correlation';;
    opt.dir_prefix = 'cc200-fg-wcorr-WL10TR-pc';
    abideCreateCorr(opt);

    % ctransform to DIPS input format
    opt.corr_dir = '../../../autism_private/data/correlation/cc200-fg-wcorr-WL10TR-pc/mat';
    data = dipsFormat(corr_dir);
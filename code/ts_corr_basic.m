function betas = ts_corr_basic(ts,ons,pmods,varargin)
%
% compute BOLD-regressor correlations (the "Behrens" plot)
%
% ARGS:
% ts    - a time series extracted with spm_regions [vector]
% ons   - event onsets (in secs) [vector]
% pmods - parametric values (can be a matrix nTrial*nPmods)
%
% options
%   'dur'   - how long is the window to be deplayed (in secs) [scalar]
%   'orth'  - orthognalize the PMODs (when nPM >= 2)
%
% Earlier version of this script was developed by Gerhard Jocham [gerhard.jocham@uni-duesseldorf.de]
%


%%
% 'defaults' if not given
param.dur = 10;
param.orth = 0;

% record input arges
i = 1;
while i < nargin - 3
    arg = varargin{i};
    val = varargin{i+1};
    param = fillpar(param, arg, val);
    
    i = i+2;
end

if length(ons) ~= length(pmods)
    error('onset vector and parametric value vactor have to be of same length and orientation')
end

if param.orth == 1 && size(pmods,2) < 2
    error('only set orth to be true when there are at least 2 PMs!')
end

if param.orth == 1
    pmods = spm_orth(pmods);
end

%%
upsrate = 10;  % up sampling rate
TR = 2.51;

% prepare time series
ts = ts - (mean(ts)); % de-mean
% ts = ts(mean(ts)); % de-mean

% upsample time series
t = 0:length(ts)-1;
t_ups = 0:1/upsrate:length(ts)-1;
ts_ups = spline(t,ts,t_ups);

% create scanindex for data to extract from time series
onset    = round(ons * upsrate / TR);
duration = round(param.dur * upsrate / TR);

%scanidx = repmat(onset,1,length(duration)) + repmat(0:duration-1,length(onset),1);
scanidx = repmat(onset,1, duration) + repmat(0:duration-1,length(onset),1);

% extract data from time sereis (sorted by trials (=row) * duration (=column)
ps  = ts_ups(scanidx);

% normalize data and pmods
pmodn = normalise(pmods);
psn   = normalise(ps);

betas = [pinv(pmodn) * psn]';


    function param = fillpar(param, arg, val)
        
        switch lower(arg)
            
            case 'dur'
                param.dur = val;
                
            case 'orth'
                param.orth = val;
        end
    end



end
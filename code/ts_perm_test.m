function p = ts_perm_test(betas, window, TR, nperm)
% run permutation test using the beta values returned by the ts_corr function
%
% inputs:
%     betas: betas, a ns-by-nt matrix, ns = # of subject, nt = # of time points (up sampled)
%     window: the time window that want to be tested window = [start end], in seconds
%     nperm:  # of permutation

if nargin < 4
    nperm = 5000;
end

% TR = 2.51; % change it accordingly to your TR
upsrate = 10;

t   = [0:size(betas,2)-1] * TR/upsrate; 
idx = find(t >= window(1) & t <= window(2));

tmp = betas(:, idx);
x   = mean(tmp,2);

%%
n    = length(x);
dbar = mean(x);
absx = abs(x);
z    = nan(1,nperm);

% Run the simulation

for i = 1:nperm
    % Do nperm times:    
    mn = datasample([-1 1], n); % 1. take n random draws from {-1, 1}, where n is the length of the data to be tested
    xbardash = mean(mn' .* absx); % 2. assign the signs to the data and put them in a temporary variable
    z(i) = xbardash;            % 3. save the new data in an array    
end


%% Return the p value
% p = the fraction of fake data that is:
% larger than |sample mean of x|, or
% smaller than -|sample mean of x|
target = abs(dbar) * .975;

p = ( sum(z >= target) + sum(z <= -target) ) / nperm;






%% Figure 2C
% plotting the effect size of NAcc signals with Outcome and Value

%%  =============================================================================================================================
% prepare data
upsrate = 10;  % up sampling rate
TR      = 2.51;
subID   = [1:9 11:20 22:41];
ts_dir  = fullfile('data', 'time_series');

GLM_f = 'GLM1201';

pm  = [1 2];
orth= 0;
roi = 'lVS';  
dur = 30;

subdir = {};
for j = subID
    curr_sub = sprintf('%s/sub%02d/%s', ts_dir, j, GLM_f);    
    subdir(end + 1) = {curr_sub};
end

load(fullfile('data', 'time_series', 'derivatives', 'onset.mat'));
load(fullfile('data', 'time_series', 'derivatives', 'model_var.mat'));

onsName = 'cuedec1_act';
pmNames = {'outcome_act', 'myValue_chn_act'};
pmLabs  = {'Reward', 'Value'};

pmodName = pmNames(pm);
pmodLabs = pmLabs(pm);
voiName  = 'VOI_lVS_1.mat';

%%
betas = [];
for j = 1:length(subID)
    
    clear Y xY ons pmod
    
    s = subID(j);    
    fprintf('j = %d, s = %d \n', j, s )
    
    % load time series (extracted with spm_regions (i.e. VOI Button)
    load(fullfile(subdir{j},voiName));
    ts = Y;
    
    ons = onset.sub(j).(onsName);
    for p = 1:length(pmodName)
        pmod(:,p) = model_var.sub(j).(pmodName{p});
    end
    
    ons = ons(1:end-1);
    pmod = pmod(1:end-1,:);    
    
    %%% MAIN ts correlation function
    betas(j,:,:) = ts_corr_basic(ts,ons,pmod, 'dur', dur, 'orth', orth);    
end

if size(betas,1) ~= length(subID)
    error('Wrong dimension! Check the index! ')
end

%% plot

fill_col = cbrewer('qual', 'Set1', 10);
        
lin_col = 0.8*fill_col;
lin_col_ref = [.5 .5 .5]; 

ref_lw = 2; % reference Line width
ac_lw = 4;  % signal line width

afs = 28; % axis font size
lfs = 32; % label font size

ll_bttm = -0.08;
ll_top = 0.3;

x = [0:size(betas,2)-1] * TR/upsrate; % scale back in second space

figure;clf;axes;hold on;
set(gcf, 'color',[1 1 1], 'position', [10 3 900 650])

line([0 round(x(end))],[0 0], 'linestyle', '-', 'color', lin_col_ref, 'linewidth',ref_lw) % horizontal ref line
line([21.71 21.71], [ll_bttm ll_top], 'linestyle', '-', 'color', lin_col_ref, 'linewidth',ref_lw) % outcome
text(21.71,ll_top + 0.02,'Outcome', 'HorizontalAlignment', 'Center', 'FontSize', afs)

% plot means forst so we can use legend
clear M S pl
if length(pmodName) ~= length(pm)
  error(' # of PMODs must be the same as # of Col! ')
end

cut_pt = 21.5; % time of the outcome cue

for p =1:length(pmodName)    
    M(p,:) = mean(squeeze(betas(:,:,p)));
    S(p,:) = nansem(squeeze(betas(:,:,p)));
    
    if p == 1        
        idx = find(x>=cut_pt);
    else
        idx = 1:length(x);        
    end   
    
    pl(p) = plot(x(idx),M(p,idx),'color',lin_col(pm(p),:),'linewidth',ac_lw);
end

% now the error regions
for p = 1:length(pmodName)       
    if p == 1        
        idx = find(x>=cut_pt);
    else
        idx = 1:length(x);        
    end   
    
    L = M(p,idx) - S(p,idx);
    U = M(p,idx) + S(p,idx);
    
    x_tmp = x(idx);
    
    Xcoords = [x_tmp x_tmp(end:-1:1)];
    Ycoords = [L U(end:-1:1)];
    
    pa(p) = patch(Xcoords,Ycoords,fill_col(pm(p),:));
    set(pa(p),'linestyle','none','linewidth',4,'facealpha',0.5); % alpha =.35
end

offsetAxes();
lg = legend(pl, pmodLabs , 'location', 'north', 'orientation','horizontal',  'position', [0.3483 0.9 0.25 0.0692]);
set(lg, 'box', 'off', 'FontSize', lfs)
xlabel('Time (s)', 'FontSize', lfs)
ylabel({'Effect size (a. u.)'}, 'FontSize', lfs)
set(gca, 'FontSize', afs, 'TickDir', 'out', ...
         'XTick', 20:5:30, 'YTick', -0.1:0.1:0.4,...         
         'xlim', [20 ceil(x(end))], 'ylim', [-.12 .4], ...
         'TickLength', [0.01 0.01], ...
         'linewidth', 3)     

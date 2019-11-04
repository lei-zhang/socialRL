%% Figure 3
% plotting posterior predictive check (PPC)

%%
load('E:\projects\00_ongoing\RLSCAN\data\PPC\PPC_RL.mat')

ns = 10;
nt = 100;

%% Fig.3a 
% trial-wise choice accuray 

figure;
set(gcf,'color',[1 1 1],'position', [20 20 700 500])
ax = axes; 
colors = cbrewer('seq', 'BuPu', 10);

hold on 

p1 = plot(mean(data), 'color', [.2 .2 .2], 'linewidth', 3);
s1 = shadedErrorBar(1:nt, model_pred_trial(:,1), ...
                    [model_pred_trial(:,3)' - model_pred_trial(:,1)'; model_pred_trial(:,1)' - model_pred_trial(:,2)' ], ...
                    {'color', colors(9,:) , 'linewidth',2.5, 'lineStyle','-'},1);
s1.edge(1).LineStyle = 'none';
s1.edge(2).LineStyle = 'none';

hold off

l= legend([p1,s1.mainLine], 'Data','Model');
offsetAxes();

afs = 20;  % axis font size
lfs = 24;  % labels font size
set(l, 'FontSize',afs, 'box', 'off', 'location', 'southeast')
set(gca,'FontSize', afs)
xlabel('Trial', 'FontSize', lfs)
ylabel('Correct choices (%)','FontSize', lfs)
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',0:25:nt,'YTick',[0 0.5 1], 'Xlim',[-.8 nt], 'Ylim',[-0.15 1.05], ...
        'YTickLabel', {'0','50','100'}, ...
        'linewidth', 3)

%% Fig.3b
% subject-wise choice accuray 

figure;
set(gcf,'color',[1 1 1],'position', [20 20 500 500])
ax = axes; 
colors = cbrewer('seq', 'BuPu', 10);
offx = [0 -0.003 0 0.003 0 -0.003 -0.003 0.003 0 0.003]';

hold on

l  = line([0 1], [0 1], 'color', [.3 .3 .3], 'linewidth', 1.5);
sc = scatter(mean(data,2)+offx, model_pred_subj(:,1), ...
     'MarkerFaceColor', colors(9,:),'MarkerEdgeColor','none', 'MarkerFaceAlpha', 0.9, 'sizedata', 80);
e  = errorbar(mean(data,2)+offx, model_pred_subj(:,1), model_pred_subj(:,1)- model_pred_subj(:,2), model_pred_subj(:,3) - model_pred_subj(:,1),...
    'LineStyle', 'none', 'LineWidth', 2, 'color', colors(9,:));

hold off

%offsetAxes();

afs = 20;  % axis font size
lfs = 24;  % labels font size
% set(l, 'FontSize',afs, 'box', 'off', 'location', 'southeast')
set(gca,'FontSize', afs)
xlabel('Data: Correct choices (%)', 'FontSize', lfs)
ylabel('Model: Correct choices (%)','FontSize', lfs)
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',.5:.1:.8,'YTick',.5:.1:.8, 'Xlim',[.47 .83], 'Ylim',[.47 .83], ...
        'XTickLabel', {'50', '60','70','80'},'YTickLabel', {'50','60','70','80'}, ...
        'linewidth', 3)

%% Fig.3c
% overall choice accuray 

figure;
set(gcf,'color',[1 1 1],'position', [20 20 600 500])
ax = axes; 
colors = cbrewer('seq', 'BuPu', 10);

hold on 

ll = line([mean(mean(data)) mean(mean(data))],  [0 600], 'color', [.2 .2 .2], 'linewidth', 3);
hh = histogram(model_pred_overall, 'BinWidth',0.005,...
              'EdgeAlpha', 0, 'FaceColor', colors(9,:) );
hold off

%offsetAxes();

l= legend([ll hh], 'Data','Model');

afs = 20;  % axis font size
lfs = 24;  % labels font size
set(l, 'FontSize',afs, 'box', 'off', 'location', 'northeast')
set(gca,'FontSize', afs)
xlabel('Correct choices (%)', 'FontSize', lfs)
ylabel('Posterior density','FontSize', lfs)
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',.60:.05:.75,'YTick',[0:100:500], 'Xlim',[.60 .75], 'Ylim',[0 550], ...
        'XTickLabel', {'60','65','70','75'}, ...
        'linewidth', 3)


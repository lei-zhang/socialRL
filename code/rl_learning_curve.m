%% Figure 1A
% plotting the value curve (20 trials) for 4 learning rates


%%
rng(21435548)
nt=80;
n_rew = 8;
n_pun = 2; 
winning_unit = [ones(n_rew,1); 2 * ones(n_pun,1)];
winner = [ [ones(5,1); 2 * ones(2,1); ones(3,1)];...
           randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10);...
           randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10)]; 

%%
data1 = simuRL_one_person([0.9, 1.2], winner, ones(nt,1));
data2 = simuRL_one_person([0.7, 1.2], winner, ones(nt,1));
data3 = simuRL_one_person([0.5, 1.2], winner, ones(nt,1));
data4 = simuRL_one_person([0.3, 1.2], winner, ones(nt,1));

%% plot
figure;
%set(gcf,'color',[1 1 1],'position', [20 20 1000 400])
set(gcf,'color',[1 1 1],'position', [20 20 700 505])
ax = axes; 

colors = cbrewer('seq', 'BuPu', 10);

tt = 1:20; % plot only the first 20 trials

winner_recode = winner;
winner_recode(winner_recode == 2) = -1;

p0 = plot(winner_recode(tt), 'color', [.5 .5 .5], 'linewidth', 3);

hold on 

% plot the V of the 1st option (reward_p = 0.8)
p1=plot(data1(tt,5),'color', colors(9,:), 'linewidth', 3);
p2=plot(data2(tt,5),'color', colors(7,:), 'linewidth', 3);
p3=plot(data3(tt,5),'color', colors(5,:), 'linewidth', 3);
p4=plot(data4(tt,5),'color', colors(3,:), 'linewidth', 3);

hold off

l= legend([p1,p2,p3,p4], ...
    '\alpha = .9','\alpha = .7','\alpha = .5','\alpha = .3');

offsetAxes();

afs = 20;  % axis font size
lfs = 24;  % labels font size
set(l, 'FontSize',afs, 'box', 'off', 'location', 'southwest')
set(gca,'FontSize', afs)
xlabel('Trial', 'FontSize', lfs)
ylabel('Value','FontSize', lfs)
text(20.4,1,'win','FontSize', afs, 'color', [.2 .2 .2])
text(20.4,-1,'loss','FontSize', afs, 'color', [.2 .2 .2])
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',0:5:tt(end),'YTick',[-1 0 1], 'Xlim',[0 20], 'Ylim',[-1.2 1.2], ...
        'linewidth', 3)

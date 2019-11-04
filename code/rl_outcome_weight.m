%% Figure 1B
% plotting the weight of recent feedback (8 trials back) for 4 learning rates

%% initial setup
alpha1 = 0.9;
alpha2 = 0.7;
alpha3 = 0.5;
alpha4 = 0.3;

nt = 8; % # of trials
w1 = zeros(nt,1);
w2 = zeros(nt,1);
w3 = zeros(nt,1);
w4 = zeros(nt,1);

for j = 1:nt    
    w1(j) = power(1-alpha1, nt-j) * alpha1;
    w2(j) = power(1-alpha2, nt-j) * alpha2;
    w3(j) = power(1-alpha3, nt-j) * alpha3;
    w4(j) = power(1-alpha4, nt-j) * alpha4;
end

%% plotting

figure;
set(gcf,'color',[1 1 1],'position', [20 20 700 505])
ax = axes; 

colors = cbrewer('seq', 'BuPu', 10);

hold on 

p1=plot(w1,'color', colors(9,:), 'linewidth', 3);
p2=plot(w2,'color', colors(7,:), 'linewidth', 3);
p3=plot(w3,'color', colors(5,:), 'linewidth', 3);
p4=plot(w4,'color', colors(3,:), 'linewidth', 3);

hold off

l= legend([p1,p2,p3,p4], ...
    '\alpha = .9','\alpha = .7','\alpha = .5','\alpha = .3');

offsetAxes();

afs = 20;  % axis font size
lfs = 24;  % labels font size
set(l, 'FontSize',afs, 'box', 'off', 'location', 'northwest')
set(gca,'FontSize', afs)
xlabel('Trial', 'FontSize', lfs)
ylabel('Outcome weight','FontSize', lfs)
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',1:1:nt,'YTick',[0 0.5 1], 'Xlim',[.8 8], 'Ylim',[-0.1 1.1], ...
        'XTickLabel', {'t-8','t-7','t-6','t-5','t-4','t-3','t-2','t-1'}, ...
        'linewidth', 3)













    




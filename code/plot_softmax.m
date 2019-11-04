%% Figure 1C
% plotting softmax curve for 4 inverse temperatures

%% prepare data
tau1 = 5; tau2 = 2; tau3 = 1; tau4 = 0.3;

x  = -2:0.05:2;
y1 = 1 ./ ( 1+ exp(tau1*-x) );
y2 = 1 ./ ( 1+ exp(tau2*-x) );
y3 = 1 ./ ( 1+ exp(tau3*-x) );
y4 = 1 ./ ( 1+ exp(tau4*-x) );


%% plot
figure;
set(gcf,'color',[1 1 1],'position', [20 20 700 505])
ax = axes; 
colors = cbrewer('seq', 'BuPu', 10);

hold on

p1 = plot(x, y1, 'color', colors(9,:), 'linewidth', 3);
p2 = plot(x, y2, 'color', colors(7,:), 'linewidth', 3);
p3 = plot(x, y3, 'color', colors(5,:), 'linewidth', 3);
p4 = plot(x, y4, 'color', colors(3,:), 'linewidth', 3);

hold off

l= legend([p1,p2,p3,p4], ...
    sprintf('\\tau = %2.0f', tau1), sprintf('\\tau = %2.0f', tau2), sprintf('\\tau = %2.0f', tau3), sprintf('\\tau = %2.1f', tau4));

offsetAxes();

afs = 20;  % axis font size
lfs = 24;  % labels font size
set(l, 'FontSize',afs, 'box', 'off', 'location', 'southeast')
set(gca,'FontSize', afs)
xlabel('Value difference: V_t(A) - V_t(B)', 'FontSize', lfs)
%xlabel('Value difference: $V_t(A) - V_t(B)$','Interpreter','Latex', 'FontSize', lfs)
ylabel('Probability of choosing A','FontSize', lfs)
set(gca,'box','off' ,'TickDir','out', ...
        'XTick',-2:1:2,'YTick',[0 .5 1], 'Xlim',[-2.1 2], 'Ylim',[-0.05 1.05], ...
        'linewidth', 3)
    
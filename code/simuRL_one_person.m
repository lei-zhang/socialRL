function data = simuRL_one_person(param, winner, choice)
%simuRL simulates data for a simple 2-option force choice experiemnt.
% usage: data = simuRL(param)
%  - param: input parameters, learning rate and temperature
% example: data = simuRL([0.6,1.5]) 
% (c) Lei Zhang, lei.zhang@uke.de

%% parameters
% also give some individual variance
% sd(lr) = 0.25, sd(temp) = 0.6
lr0   = param(1); % learning rate
tau0  = param(2); % temperature

nt = 80;  % number of trials 

lr = lr0;
tau = tau0;

%fprintf(' ## lr: mean  = %f, sd = %f. \n', mean(lr), std(lr))
%fprintf(' ## tau: mean = %f, sd = %f. \n', mean(tau), std(tau))

%% initialisation 

v      = zeros(nt+1,2);  % value
vc     = zeros(nt,1);    % chosen value
prob   = zeros(nt,2);    % prob, based on soft-max
pe     = zeros(nt,1);    % prediction error

r      = zeros(nt,1);

if nargin < 3
    c = zeros(nt,1);   % choice
else
    c = choice;
end

data   = zeros(nt,6); % data

%% generate outcomes
% n_rew = 8;
% n_pun = 2; 
% winning_unit = [ones(n_rew,1); 2 * ones(n_pun,1)];
% winner = [ randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10);...
%            randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10); randsample(winning_unit, 10)]; 


%% generate choices

for t = 1:nt  % trial loop
    
    % action selection based of softmax transformation
    prob(t,1)= 1 / (1 + exp(tau *(v(t,2)-v(t,1))));
    prob(t,2)= 1 / (1 + exp(tau *(v(t,1)-v(t,2))));
    
    % generate choice
    if nargin < 3
        c(t) = find(rand < cumsum(prob(t,:)),1); % 1 or 2
    else
        c = choice;
    end
    
    vc(t) = v(t, c(t));
    
    % reward based on the predicted choice
    if c(t) == winner(t,1)
        r(t) = 1;
    else
        r(t) = -1;
    end
    
    % prediction error
    pe(t,1) = r(t) - v(t, c(t));
    
    % value update
    v(t+1,:)       = v(t,:);
    v(t+1,c(t))  = v(t,c(t)) + lr * pe(t,1);     
    
end % nt

v = v(1:nt,:);

%% write c and r into output variable 'data'
data(:,1) = c;
data(:,2) = r;
data(:,3) = winner;
data(:,4) = vc;
data(:,5:6) = v;











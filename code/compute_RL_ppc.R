####################################################################
# load data
load('data/PPC/rl_mp.RData')
sz <- dim(rl_mp)
nSubjects <- sz[1]
nTrials   <- sz[2]

dataList <- list(nSubjects=nSubjects,
                 nTrials=nTrials, 
                 choice=rl_mp[,,1], 
                 reward=rl_mp[,,2])

# load model object
f = readRDS('data/PPC/rl_fit.RData')

####################################################################
# overall mean
mean(dataList$choice[1:2,] == 1 )

# trial-by-trial sequence
#plot(1:100, colMeans(dataList$choice == 1),type='b')
y_mean = colMeans(dataList$choice == 1)

y_pred = extract(f, pars='y_pred')$y_pred
dim(y_pred)  # [4000,10,100]

y_pred_mean_mcmc = apply(y_pred==1, c(1,3), mean)
dim(y_pred_mean_mcmc)  # [4000, 100]
y_pred_mean = colMeans(y_pred_mean_mcmc)
y_pred_mean_HDI = apply(y_pred_mean_mcmc, 2, HDIofMCMC)

y_pred_mean_sub_mcmc = apply(y_pred==1, c(1,2), mean)
dim(y_pred_mean_sub_mcmc)  # [4000, 10]
y_pred_sub_mean = colMeans(y_pred_mean_sub_mcmc)
y_pred_sub_mean_HDI = apply(y_pred_mean_sub_mcmc, 2, HDIofMCMC)


## 
# prepare data for matlab
data = (dataList$choice == 1)

model_pred_trial = matrix(NA, nrow = 100, ncol = 3)
model_pred_trial[,1] = y_pred_mean
model_pred_trial[,2] = y_pred_mean_HDI[1,]
model_pred_trial[,3] = y_pred_mean_HDI[2,]

model_pred_subj = matrix(NA, nrow = 10, ncol = 3)
model_pred_subj[,1] = y_pred_sub_mean
model_pred_subj[,2] = y_pred_sub_mean_HDI[1,]
model_pred_subj[,3] = y_pred_sub_mean_HDI[2,]

model_pred_overall = rowMeans(y_pred_mean_mcmc)

R.matlab::writeMat('data/PPC/PPC_RL.mat', data=data, 
         model_pred_overall=model_pred_overall, 
         model_pred_trial=model_pred_trial,
         model_pred_subj=model_pred_subj)






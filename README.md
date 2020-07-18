[![GitHub repo size](https://img.shields.io/github/repo-size/lei-zhang/socialRL?color=brightgreen&logo=github)](https://github.com/lei-zhang/socialRL)
[![GitHub language count](https://img.shields.io/github/languages/count/lei-zhang/socialRL?color=brightgreen&logo=github)](https://github.com/lei-zhang/socialRL)
[![DOI](https://img.shields.io/badge/DOI-10.1093%2Fscan%2Fnsaa089-informational)](http://dx.doi.org/10.1093/scan/nsaa089)
[![GitHub last commit](https://img.shields.io/github/last-commit/lei-zhang/socialRL?color=orange&logo=github)](https://github.com/lei-zhang/socialRL)<br />
[![Twitter Follow](https://img.shields.io/twitter/follow/lei_zhang_lz?label=%40lei_zhang_lz)](https://twitter.com/lei_zhang_lz)
[![Lab Twitter Follow](https://img.shields.io/twitter/follow/ScanUnit?label=%40ScanUnit)](https://twitter.com/ScanUnit)


**Code and data for： <br />
Zhang^, Lengersdorff^, Mikus, Gläscher, & Lamm (2020). Frameworks, pitfalls, and suggestions of using reinforcement learning models in social neuroscience. (^Equal contributions)** *Social cognitive and affective neuroscience* <br />
[DOI: 10.1093/scan/nsaa089](https://doi.org/10.1093/scan/nsaa089).

To reproduce all analyses and figures in the manuscript. 

A 2-min flash talk of the paper is available on [YouTube](https://youtu.be/JQMfpf1-mGE). 
___

This repository contains:
```
root
  ├─ code       # Matlab & R code to run the analyses and produce figures
  ├─ data       # behavioral & fMRI data
```

**Note 1**: to properly run all scripts, you may need to set the root of this repository as your work directory. <br />
**Note 2**: to reproduce the Matlab figures, you may need the [color brewer](https://www.mathworks.com/matlabcentral/fileexchange/34087-cbrewer-colorbrewer-schemes-for-matlab) toolbox and the [offsetAxes](https://github.com/anne-urai/Tools/blob/master/plotting/offsetAxes.m) function. 

## RL parameter simulations
* Figure 1A: [rl_learning_curve.m](code/rl_learning_curve.m) --> calls [simuRL_one_person.m](code/simuRL_one_person.m)
* Figure 1B: [rl_outcome_weight.m](code/rl_outcome_weight.m)
* Figure 1C: [plot_softmax.m](code/plot_softmax.m)
* Figure 1D: [rl_simulations.Rmd](code/rl_simulations.Rmd) --> full simulation [rl-simulations-generate-data.Rmd](code/rl-simulations-generate-data.Rmd)

## fMRI time series of the prediction error
* Figure 2C: [pe_time_series_plot.m](code/pe_time_series_plot.m)
* core function: [ts_corr_basic.m](code/ts_corr_basic.m) --> relies on [normalise.m](code/normalise.m)
* permutation test: [ts_perm_test.m](code/ts_perm_test.m)

## posterior predictive check
* Figure 3A-C: [plot_ppc.m](code/plot_ppc.m)
* model fitting: [reinforcement_learning_HBA.R](code/reinforcement_learning_HBA.R) --> calls the stan model [rl_ppc.stan](code/rl_ppc.stan)


___

For bug reports, please contact Lei Zhang ([lei.zhang@univie.ac.at](mailto:lei.zhang@univie.ac.at)).

Thanks to [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) and [shields.io](https://shields.io/).

___

### LICENSE

This license (CC BY-NC 4.0) gives you the right to re-use and adapt, as long as you note any changes you made, and provide a link to the original source. Read [here](https://creativecommons.org/licenses/by-nc/4.0/) for more details. 

![](https://upload.wikimedia.org/wikipedia/commons/9/99/Cc-by-nc_icon.svg)

## Code and data for Zhang^, Lengersdorff^, Mikus, Gläscher, & Lamm (2019, biorxiv). Frameworks, pitfalls, and suggestions of using reinforcement learning models in social neuroscience. (^Equal contributions)

This repository contains
```
├─ code                 # Matlab & R code to run the analyses and produce figures
├─ data                 # behavioral & fMRI data
```

**Note 1**: to reproduced the Matlab figures, you may need the [color brewer](https://www.mathworks.com/matlabcentral/fileexchange/34087-cbrewer-colorbrewer-schemes-for-matlab) toolbox and the [offsetAxes](https://github.com/anne-urai/Tools/blob/master/plotting/offsetAxes.m) function.

**Note 2**: to properly run all scripts, you may want to set the root of this repository as your work directory. 

## RL parameter simulations
* Figure 1A: [rl_learning_curve.m](code/rl_learning_curve.m)
* Figure 1B: [rl_outcome_weight.m](code/rl_outcome_weight.m)
* Figure 1C: [plot_softmax.m](code/plot_softmax.m)
* Figure 1D: [RL_simulations.Rmd](code/RL_simulations.Rmd)

## fMRI time series of the prediction error
* Figure 2C: [pe_time_series_plot.m](code/pe_time_series_plot.m)
* core function: [ts_corr_basic.m](code/ts_corr_basic.m) --> relies on [normalise.m](code/normalise.m)
* permutation test: [ts_perm_test.m](code/ts_perm_test.m)

## posterior predictive check
* Figure 3A-C: [plot_ppc.m](code/plot_ppc.m)
* model fitting: [reinforcement_learning_HBA.R](code/reinforcement_learning_HBA.R) --> calls the stan model [RL_ppc.stan](code/RL_ppc.stan)


For bug reports, please contact Lei Zhang (lei.zhang@univie.ac.at).

Thanks to this [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

### LICENSE

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
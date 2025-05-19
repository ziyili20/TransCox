![GitHub Release Downloads](https://img.shields.io/github/downloads/ziyili20/TransCox/total/asset_name.zip)

# TransCox
How to improve the survival inference for one dataset if you have a larger cohort to borrow information from? Here, we provide transfer learning-based Cox Proportional Hazards model (**TransCox**). Our method considers two data sources, a target dataset and a source dataset. The idea is to borrow information adaptively from the source dataset to improve the inference for the target data. The tuning parameter to control the information borrowing between the two data sets is selected through a grid search with BIC.  

## Setting up your python environment
The package was built mainly in R with calling a solver from Python. Before installing the package, please make sure you have installed an appropriate Python environment. Here we recommend create a virtual environment in Conda:

```
conda create -n TransCoxEnvi
```
Now let's install the required Python packages:

```
conda install tensorflow-probability==0.8
conda install tensorflow==2.1.0
```
In R, please install required packages including reticulate and survival:

```
install.packages("reticulate")
install.packages("survival")
```
Now, please set your python environment in R and make sure R can identify the correct python packages that you just installed.

```
library(reticulate)
## modify this to your directory
use_python("/Users/zli16/opt/anaconda3/envs/tf/bin/python") 
use_condaenv("TransCoxEnvi")
```
Let's test if you can load your python packages from R:

```
tf <- import("tensorflow")
py_run_string("print(tf.__version__)")
py_run_string("xi = tf.Variable(np.repeat([0.], repeats = 100), dtype = 'float64')")
```

If your R cannot find the python environment, another way that works well for me is to create a .Renviron file in the home directory and put the location of your conda-environment python in this file:

```
RETICULATE_PYTHON="/Users/zli16/opt/anaconda3/envs/TransCoxEnvi/bin/python"
```
After you do this, re-start R to let R find the correct python to use. And then re-test if your R can find the python packages. Setting up the python environment can be frustrating. I totally understand...

## Install the TransCox package
Now let's install the TransCox package in R from Github:

```
# if you need to install devtools package
install.packages("devtools")
library(devtools)
install_github("ziyili20/TransCox")
```
I haven't figure out a way to automatically load the python function, let's do it manually by

```
library(reticulate)
source_python(system.file("python", "TransCoxFunction.py", package = "TransCox"))
```
This step shouldn't give any error if the python environment has been set up successfully. 

## Illustrate the usage using a simulation dataset

Our simulation dataset has 200 samples from the target data and 500 samples from the source data. There are two covariates: X1 and X2. 

```
library(TransCox)
onedata <- GenSimData(nprim = 200,
                      naux = 500,
                      setting = 1)
pData = onedata$primData
aData = onedata$auxData
Cout <- GetAuxSurv(aData, cov = c("X1", "X2"))
Pout <- GetPrimaryParam(pData, q = Cout$q, estR = Cout$estR)
```

We select the best learning rate and number of steps using BIC:

```
LRres <- SelLR_By_BIC(primData = onedata$primData,
             auxData = onedata$auxData,
             cov = c("X1", "X2"),
             statusvar = "status", lambda1 = 0.1, lambda2 = 0.1,
             learning_rate_vec = c(0.001, 0.002, 0.003, 0.004, 0.005),
             nsteps_vec = c(100, 200))
```
My LRres look like this

```
LRres
$best_lr
[1] 0.004

$best_nsteps
[1] 200

$BICmat
           100      200
0.001 2503.008 2491.930
0.002 2492.187 2485.108
0.003 2489.549 2483.712
0.004 2484.411 2483.446
0.005 2490.987 2483.649
```

Here we select the best tuning parameter using BIC. This step may take 2-3 minutes. If it takes too long, you can reduce the potential values in `lambda1_vec` and `lambda2_vec` to decrease the searching time. 

```
BICres <- SelParam_By_BIC(primData = onedata$primData,
                auxData = onedata$auxData,
                cov = c("X1", "X2"),
                statusvar = "status",
                lambda1_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
                lambda2_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
                learning_rate = 0.004, nsteps = 200)
```

Now we can run TransCox function in our data:

```
Tres <- runTransCox_one(Pout, l1 = BICres$best_la1, l2 = BICres$best_la2, 
                        learning_rate = 0.004, nsteps = 200, cov = c("X1", "X2"))
```

Take a look at the output from the function:

```
> lapply(Tres, head, 2)
$eta
[1]  0.07593853 -0.15498716

$xi
[1]  0.00162907 -0.01151908

$new_beta
[1] -0.6571349  0.3119838

$new_IntH
[1] 0.005916450 0.005984873

$time
[1] 0.06477683 0.10978123
```
`new_beta` is the estimated beta parameter from the Cox PH model with transfer learning from the source dataset. 

We can further estimate the estimation variation using bootstrap. In this illustration, I set the number of bootstraps (`nbootstrap`) as 10 to make it fast. Please change it to 200 or even 1000 to provide more reliable variance estimations. 

```
BTres <- runBtsp_transCox(aData,
                          pData,
                          Tres = Tres,
                          BestLam1 = 0.1,
                          BestLam2 = 0.1,
                          learning_rate = 0.002,
                          nsteps = 200,
                          nbootstrap = 10,
                          Hrange = seq(0.15, 2, length.out = 50),
                          trueBeta = c(-0.5, 0.5),
                          cov = c("X1", "X2"))
```
You can find the standard error estimation from the output with the name `BTres$beta_SE_btsp`. 

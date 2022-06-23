\name{runBtsp_transCox}
\alias{runBtsp_transCox}\title{
Trans-Cox inference with bootstrap
}
\description{
This function perform bootstrap inference for Trans-Cox estimates.
}
\usage{
runBtsp_transCox(aData, pData, Tres, learning_rate = 0.002, nsteps = 200, BestLam1 = 0.1, BestLam2 = 0.1, nbootstrap = 100, trueBeta = c(-0.5, 0.5), Hrange = seq(0.15, 2, length.out = 50), cov = c("X1", "X2"))
}
\arguments{
  \item{aData}{
  External data.
}
  \item{pData}{
Target data.
}
  \item{Tres}{
Results from applying runTransCox_One function.
}
  \item{BestLam1}{
Lambda_1 parameter to control the L-1 panelty of the coefficient changing term part.
}
  \item{BestLam2}{
Lambda_2 parameter to control the L-1 panelty of the hazard changing term part.
}
  \item{learning_rate}{
Learning rate to specify for the optimization algorithm.
}
  \item{nsteps}{
Number of steps to specify for the optimization algorithm.
}

  \item{nbootstrap}{
Number of bootstraps. Default: 100. }
  \item{trueBeta}{
}
  \item{Hrange}{
Specify a range to perform inference for hazard estimations.
}
  \item{cov}{
Covariates for the analysis. For example, cov = ("X1", "X2"). }
}
\value{
\item{rec_beta}{Covariate parameter estimations from the bootstrap iterations. }
\item{beta_SE_btsp}{Standard error estimation from the bootstrap iterations for covariate parameters.}
\item{rec_cumH}{Cumulative hazard estimations from the bootstrap iterations. }
\item{cumH_SE_btsp}{Standard error estimation from the bootstrap iterations for cumulative hazards.}
}
\author{
Ziyi Li (zli16@mdanderon.org)
}
\examples{
onedata <- GenSimData(nprim = 200,
                   naux = 500,
                   setting = 1)
pData = onedata$primData
aData = onedata$auxData
Cout <- GetAuxSurv(aData, cov = c("X1", "X2"))
Pout <- GetPrimaryParam(pData, q = Cout$q, estR = Cout$estR)
#Tres <- runTransCox_one(Pout, l1 = 0.1, l2 = 0.1, learning_rate = 0.003, nsteps = 200, cov = c("X1", "X2"))
#BTres <- runBtsp_transCox(aData,
#                             pData,
#                             Tres = Tres,
#                             BestLam1 = 0.1,
#                             BestLam2 = 0.1,
#                             learning_rate = 0.002,
#                             nsteps = 200,
#                             nbootstrap = 10,
#                             Hrange = seq(0.15, 2, length.out = 50),
#                             trueBeta = c(-0.5, 0.5),
#                             cov = c("X1", "X2"))
}

\name{runTransCox_one}
\alias{runTransCox_one}
\title{
Run Trans-Cox function.
}
\description{
Call the python Transcox function from R.
}
\usage{
runTransCox_one(Pout, l1 = 1, l2 = 1, learning_rate = 0.004, nsteps = 200, cov = c("X1", "X2"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Pout}{
Output from GetPrimaryParam() function.
}
  \item{l1}{
Lambda_1 parameter to control the L-1 panelty of the coefficient changing term part.
}
  \item{l2}{
Lambda_2 parameter to control the L-1 panelty of the hazard changing term part.
}
  \item{learning_rate}{
Learning rate to specify for the optimization algorithm.
}
  \item{nsteps}{
Number of steps to specify for the optimization algorithm.
}
  \item{cov}{
Covariates for the analysis. For example, cov = ("X1", "X2"). }
}
\value{
\item{eta }{Estimation of eta, the changing term for the covariate coefficients.}
\item{xi }{Estimation of xi, the changing term for the baseline hazards. }
\item{new_beta}{Covariate coefficient estimation after Trans-Cox.}
\item{new_IntH}{Baseline hazards estimation after Trans-Cox.}
\item{time}{Event times. }
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
# Tres <- runTransCox_one(Pout, l1 = 0.1, l2 = 0.1, learning_rate = 0.003, nsteps = 200, cov = c("X1", "X2"))
}

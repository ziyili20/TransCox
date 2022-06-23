\name{GetPrimaryParam}
\alias{GetPrimaryParam}
\title{
Estimate parameters for the target cohort.
}
\description{
Use this function after GetAuxSurv() and before runTransCox_one() to get the required estimates from the target cohort. }
\usage{
GetPrimaryParam(primData, q, estR)
}
\arguments{
  \item{primData}{
Data for the target cohort.
}
  \item{q}{
Estimated hazards from the external dataset.
}
  \item{estR}{
Estimated covariate coefficient for the external dataset.
}
}
\value{
\item{primData }{Target dataset.}
\item{Xinn }{An intermediate parameter estimation for TransCox function. }
\item{dQ }{Pseudo-hazard estimation matched to the event times in the target data.}
\item{estR }{Parameter estimation from the external data. }
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

}

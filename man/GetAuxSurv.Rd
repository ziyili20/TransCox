\name{GetAuxSurv}
\alias{GetAuxSurv}
\title{
Get survival estimates for the external data
}
\description{
This function calculates the parameter and hazard estimations for the external data, which will be used for the Trans-Cox method later. }
\usage{
GetAuxSurv(auxData, weights = NULL, cov = c("X1", "X2"))
}
\arguments{
  \item{auxData}{
A data frame for the external dataset with covariate time (e.g. event/censor time), status (1 = censor, 2 = event), covariates. }
  \item{weights}{
In case we need to perform weighted cox proportional hazard analysis}
  \item{cov}{
Specify the covariates for analysis here. For example, cov = ("X1", "X2"). }
}
\value{
\item{estR }{Estimated parameters from the Cox PH model. }
\item{q }{Estimated cumulative hazard and the corresponding time}
}
\author{
Ziyi Li (zli16@mdanderon.org)
}
\examples{
auxData <- data.frame(time = runif(100, 1, 200),
            status = sample(c(1,2), 100, replace = TRUE),
            X1 = runif(100, 0, 1),
            X2 = rbinom(100, 20, 0.5))
tmpres <- GetAuxSurv(auxData = auxData,
                    cov = c("X1", "X2"))
}

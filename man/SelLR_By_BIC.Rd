\name{SelLR_By_BIC}
\alias{SelLR_By_BIC}
\title{
Use BIC to select the best learning rate through grid search. }
\description{
This function fixes the L-1 panelty parameters and use BIC to select the best learning rate and step information for the optimization algorithm. }
\usage{
SelLR_By_BIC(primData, auxData, cov = c("X1", "X2"), statusvar = "status", lambda1 = 0.1, lambda2 = 0.1, learning_rate_vec = c(1e-04, 5e-04, 0.001, 0.002, 0.003, 0.004, 0.005), nsteps_vec = c(100, 200, 300, 400))
}
\arguments{
  \item{primData}{
Data from the target cohort.
}
  \item{auxData}{
Data from the external cohort.
}
  \item{cov}{
Covariates of interest, e.g., cov = ("X1", "X2").
}
  \item{statusvar}{
Specify which variable is the status variable. Default = "status".
}
  \item{lambda1}{
Lambda_1 parameter to control the L-1 panelty of the coefficient changing term part. Default fixed at 0.1.
}
  \item{lambda2}{
Lambda_2 parameter to control the L-1 panelty of the hazard changing term part. Default fixed at 0.1.
}
  \item{learning_rate_vec}{
A vector of learning rate to consider. E.g., learning_rate_vec = c(1e-04, 5e-04, 0.001, 0.002, 0.003, 0.004, 0.005).}
  \item{nsteps_vec}{
A vector of step numbers to consider. E.g., nsteps_vec = c(100, 200, 300, 400). }
}
\value{
\item{best_lr }{Best learning rate.}
\item{best_nsteps }{Best number of steps. }
\item{BICmat }{Matrix to record the BIC values. }
}
\author{
Ziyi Li (zli16@mdanderon.org)
}
\examples{
onedata <- GenSimData(nprim = 200,
                   naux = 500,
                   setting = 1)
#SelLR_By_BIC(primData = onedata$primData,
#             auxData = onedata$auxData,
#             cov = c("X1", "X2"),
#             statusvar = "status", lambda1 = 0.1, lambda2 = 0.1,
#             learning_rate_vec = c(0.001, 0.002, 0.003, 0.004, 0.005),
#             nsteps_vec = c(100, 200))
}

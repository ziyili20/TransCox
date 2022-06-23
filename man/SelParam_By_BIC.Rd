\name{SelParam_By_BIC}
\alias{SelParam_By_BIC}
\title{
Select the two tuning parameters by BIC.
}
\description{
After the learning rate and number of steps are picked, this function will select the best lambda tuning parmaeters by BIC.
}
\usage{
SelParam_By_BIC(primData, auxData, cov = c("X1", "X2"), statusvar = "status", lambda1_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)), lambda2_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)), learning_rate = 0.004, nsteps = 100)
}
%- maybe also 'usage' for other objects documented here.
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
  \item{lambda1_vec}{
A vector of considered lambda_1 values, e.g., lambda1_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)).
}
  \item{lambda2_vec}{
A vector of considered lambda_2 values, e.g., lambda2_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)).
}
  \item{learning_rate}{
Learning rate selected.}
  \item{nsteps}{
Number of steps selected. }
}
\value{
\item{best_l1 }{Best learning rate.}
\item{best_l2 }{Best number of steps. }
\item{BICmat }{Matrix to record the BIC values. }
}
\author{
Ziyi Li (zli16@mdanderon.org)
}
\examples{
onedata <- GenSimData(nprim = 200,
                   naux = 500,
                   setting = 1)
## I commented out the function as python environment may not be properly loaded
## during the testing environment
# SelParam_By_BIC(primData = onedata$primData,
#                 auxData = onedata$auxData,
#                 cov = c("X1", "X2"),
#                 statusvar = "status",
#                 lambda1_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
#                 lambda2_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
#                 learning_rate = 0.002, nsteps = 200)
}

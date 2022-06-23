\name{GenSimData}
\alias{GenSimData}
\title{
Generate simulation data
}
\description{
A function to generate simulation dataset.
}
\usage{
GenSimData(nprim = 200, naux = 500, setting = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nprim}{
Sample size for the target cohort.}
  \item{naux}{
Sample size for the external cohort.
}
  \item{setting}{
Simulation setting to generate selected from 1, 2, 3, 4. For Setting 1, the target and external cohort share the same survival variables. For Setting 2, the coefficient for covariate 2 is different in external cohort. For Setting 3, the baseline cumulative hazards are generated differently in external cohort. For Setting 4, both covariate 2 coefficient and the baseline cumulative hazard are different.
}
}
\value{
\item{primData}{Data frame for the primary cohort.}
\item{auxData}{Data frame for the auxiliary cohort.}
}

\author{
Ziyi Li (zli16@mdanderon.org)
}
\examples{
simdata = GenSimData(nprim = 200, naux = 500, setting = 1)
}

GetLogLike <- function(status, CovData, hazards,
                       newBeta,
                       newHaz) {
    XB = as.matrix(CovData) %*% newBeta
    newCumH <- dQtocumQ(newHaz, status)
    LogL <- sum(XB[status == 2] + log(newHaz)) - sum(newCumH * exp(XB))
    return(LogL)
}

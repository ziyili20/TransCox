GetBIC <- function(status, CovData, hazards,
                   newBeta,
                   newHaz,
                   eta,
                   xi,cutoff = 1e-5) {
    Logl <- GetLogLike(status = status,
                       CovData = CovData,
                       hazards = hazards,
                       newBeta = newBeta,
                       newHaz = newHaz)
    K = sum(c(abs(eta), abs(xi))>cutoff)
    n = length(status)
    BIC <- K*log(n) - 2*Logl
    return(BIC)
}

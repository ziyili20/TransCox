GetCoverage <- function(estimate, trueBeta,
                        SE) {
    LL <- estimate - 1.96*SE
    UU <- estimate + 1.96*SE
    return(as.numeric(trueBeta<UU & trueBeta>LL))
}

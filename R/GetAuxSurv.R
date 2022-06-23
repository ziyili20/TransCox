GetAuxSurv <- function(auxData, weights = NULL, cov = c("X1", "X2")) {
    res.cox <- c()
    functext = paste0("res.cox <- survival::coxph(survival::Surv(time, status == 2) ~ ", paste(cov, collapse = "+"), ", data = auxData, weights = weights)")
    ### Give auxiliary data, estimate r and q
    eval(parse(text = functext))
    bhest <- survival::basehaz(res.cox, centered=FALSE) ## get baseline cumulative hazards
    estR <- res.cox$coefficients
    q <- data.frame(cumHazards = bhest$hazard,
                    breakPoints = bhest$time)
    return(list(estR = estR,
                q = q))
}

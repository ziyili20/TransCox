GenSimData <- function(nprim = 200,
                    naux = 500,
                    setting = 1) {

    ### two covarites first
    X1_p = stats::runif(nprim, 0, 1)
    X2_p  = stats::rbinom(nprim, size = 1, prob = 0.5)

    X1_a = stats::runif(naux, 0, 1)
    X2_a = stats::rbinom(naux, size = 1, prob = 0.5)

    b1_p = -0.5
    b2_p = 0.5
    XB_p = cbind(X1_p, X2_p) %*% c(b1_p, b2_p)
    scale_p = exp(-XB_p/2)
    shape_p = 2

    if(setting %in% c(1,3)) {
        b1_a = -0.5
        b2_a = 0.5
    } else if(setting %in% c(2,4)) {
        b1_a = -0.5
        b2_a = 0.2
    }

    if(setting %in% c(1,2)) {
        XB_a = cbind(X1_a, X2_a) %*% c(b1_a, b2_a)
        scale_a = exp(-XB_a/2)
        shape_a = 2
    } else if(setting %in% c(3,4)) {
        XB_a = cbind(X1_a, X2_a) %*% c(b1_a, b2_a)
        scale_a = exp(-XB_a/2)*3/2
        shape_a = 2
    }

    T_p = stats::rweibull(nprim, shape = shape_p, scale = scale_p)
    C_p = stats::runif(nprim, 0, 4.55)
    survTime_p = ifelse(T_p < C_p, T_p, C_p)
    event_p = ifelse(T_p < C_p, 2, 1)

    T_a = stats::rweibull(naux, shape = shape_a, scale = scale_a)
    C_a = stats::runif(naux, 0, 4.55)
    survTime_a = ifelse(T_a < C_a, T_a, C_a)
    event_a = ifelse(T_a < C_a, 2, 1)

    primData = data.frame(X1 = X1_p,
                          X2 = X2_p,
                          time = survTime_p,
                          status = event_p)
    auxData = data.frame(X1 = X1_a,
                         X2 = X2_a,
                         time = survTime_a,
                         status = event_a)

    return(list(primData = primData,
                auxData = auxData))
}

getCumEval <- function(bhest) {
    breakPoint <- seq(0.15, 2.5, length.out = 50)
    Heval <- rep(NA, length(breakPoint))
    for(i in 1:length(breakPoint)) {
        diff <- breakPoint[i] - bhest$time
        Heval[i] <- bhest$hazard[which.min(abs(diff))]
    }
    return(Heval)
}



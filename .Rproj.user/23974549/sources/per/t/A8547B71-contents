SelParam_By_BIC <- function(primData, auxData, cov = c("X1", "X2"),
                            statusvar = "status",
                            lambda1_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
                            lambda2_vec = c(0.1, 0.5, seq(1, 10, by = 0.5)),
                            learning_rate = 0.004,
                            nsteps = 100) {

    # require("reticulate")
    # source_python('/Users/zli16/Dropbox/TransCox/TransCox_package/TransCox/inst/python/TransCoxFunction.py')

    TransCox <- NULL
    .onLoad <- function(libname, pkgname) {
        tf <<- reticulate::import("tensorflow", delay_load = TRUE)
        tfp <<- reticulate::import("tensorflow_probability", delay_load = TRUE)
        np <<- reticulate::import("numpy", delay_load = TRUE)
        source_python(system.file("python", "TransCoxFunction.py", package = "TransCox"))
    }

    Cout <- GetAuxSurv(auxData, cov = cov)
    Pout <- GetPrimaryParam(primData, q = Cout$q, estR = Cout$estR)

    CovData = Pout$primData[, cov]
    status = Pout$primData[, statusvar]
    cumH = Pout$primData$fullCumQ
    hazards = Pout$dQ$dQ

    BICmat <- matrix(NA, length(lambda1_vec), length(lambda2_vec))
    pb = txtProgressBar(min = 0, max = (length(lambda1_vec))^2, style = 2, initial = 0)
    for(i in 1:length(lambda1_vec)) {
        for(j in 1:length(lambda2_vec)) {

            thisi = (i-1) * length(lambda1_vec) + j
            setTxtProgressBar(pb, thisi)

            lambda1 = lambda1_vec[i]
            lambda2 = lambda2_vec[j]

            test <- TransCox(CovData = as.matrix(CovData),
                             cumH = cumH,
                             hazards = hazards,
                             status = status,
                             estR = Pout$estR,
                             Xinn = Pout$Xinn,
                             lambda1 = lambda1, lambda2 = lambda2,
                             learning_rate = learning_rate,
                             nsteps = nsteps)
            names(test) <- c("eta", "xi")
            newBeta = Pout$estR + test$eta
            newHaz = Pout$dQ$dQ + test$xi

            BICvalue <- GetBIC(status = status,
                               CovData = CovData,
                               hazards = hazards,
                               newBeta = newBeta,
                               newHaz = newHaz,
                               eta = test$eta,
                               xi = test$xi,
                               cutoff = 1e-5)

            BICmat[i,j] <- BICvalue
        }
    }
    close(pb)
    rownames(BICmat) = lambda1_vec
    colnames(BICmat) <- lambda2_vec

    idx0 <- which(BICmat == min(BICmat, na.rm = TRUE), arr.ind = TRUE)

    b_lambda1 <- lambda1_vec[idx0[1]]
    b_lambda2 <- lambda2_vec[idx0[2]]

    return(list(best_la1 = b_lambda1,
                best_la2 = b_lambda2,
                BICmat = BICmat))
}

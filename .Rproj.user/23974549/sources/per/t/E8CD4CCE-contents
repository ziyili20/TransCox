SelLR_By_BIC <- function(primData, auxData, cov = c("X1", "X2"),
                         statusvar = "status",
                         lambda1 = 0.1,
                         lambda2 = 0.1,
                         learning_rate_vec = c(0.0001, 0.0005, 0.001, 0.002,0.003, 0.004, 0.005),
                         nsteps_vec = c(100,200,300,400)) {

    # require("reticulate")
    # source_python('/Users/zli16/Dropbox/TransCox/TransCox_package/TransCox/python/TransCoxFunction.py')

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

    BICmat <- matrix(NA, length(learning_rate_vec), length(nsteps_vec))
    pb = txtProgressBar(min = 0, max = (length(learning_rate_vec))^2, style = 2, initial = 0)
    for(i in 1:length(learning_rate_vec)) {
        for(j in 1:length(nsteps_vec)) {

            thisi = (i-1) * length(learning_rate_vec) + j
            setTxtProgressBar(pb, thisi)

            learning_rate = learning_rate_vec[i]
            nsteps = nsteps_vec[j]

            test <- TransCox(CovData = as.matrix(CovData),
                             cumH = cumH,
                             hazards = hazards,
                             status = status,
                             estR = Pout$estR,
                             Xinn = Pout$Xinn,
                             lambda1 = lambda1,
                             lambda2 = lambda2,
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
    rownames(BICmat) = learning_rate_vec
    colnames(BICmat) <- nsteps_vec

    idx0 <- which(BICmat == min(BICmat, na.rm = TRUE), arr.ind = TRUE)

    b_learning_rate <- learning_rate_vec[idx0[1]]
    b_nsteps <- nsteps_vec[idx0[2]]

    return(list(best_lr = b_learning_rate,
                best_nsteps = b_nsteps,
                BICmat = BICmat))
}


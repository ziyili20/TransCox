GetPrimaryParam <- function(primData, q, estR) {
    ### get primary data-specific breakpoints and hazards
    primData <- primData[order(primData$time), ]
    dQ <- deltaQ(primData, q)
    primData <- primData[order(primData$time), ]
    fullcum <- rep(0, nrow(primData))
    idx0 <- match(dQ$t, primData$time)

    ### get cumQ
    fullcum[idx0] <- dQ$cumQ_upd
    for(i in 1:length(fullcum)) {
        if(fullcum[i] == 0 & i>1) {
            fullcum[i] = fullcum[i-1]
        }
    }
    primData$fullCumQ = fullcum

    #### get Ximat
    Ximat <- matrix(0, nrow(primData), nrow(primData))
    for(i in 1:nrow(primData)) {
        tmpidx = rep(0, nrow(primData))
        for(j in 1:i) {
            if(primData$status[j] == 2)
                tmpidx[j] = 1
        }
        Ximat[i,] <- tmpidx
    }
    Xinn <- Ximat[,which(primData$status == 2)]
    return(list(primData = primData,
                Xinn = Xinn,
                dQ = dQ,
                estR = estR))
}

deltaQ <- function(primData, q) {
    #### get cumulative hazards for primary data
    #### from the combined data
    obsData <- primData[primData$status == 2, ]
    obsData <- obsData[order(obsData$time), ]
    newQ <- data.frame(dQ  = rep(NA, nrow(obsData)),
                       cumQ = rep(NA, nrow(obsData)),
                       t = rep(NA, nrow(obsData)))
    for(i in 1:nrow(obsData)) {
        if (i == 1) {
            newQ$t[i] <- obsData$time[i]
            tmp1 <- q$breakPoints<=obsData$time[i]
            if(all(!tmp1)) {
                idx0 <- 1
            } else {
                idx0 <- max(which(tmp1))
            }
            newQ$dQ[i] = newQ$cumQ[i] <- q$cumHazards[idx0]
        } else {
            newQ$t[i] <- obsData$time[i]
            tmp1 <- q$breakPoints<=obsData$time[i]
            if(all(!tmp1)) {
                idx0 <- 1
            } else {
                idx0 <- max(which(tmp1))
            }
            newQ$cumQ[i] <- q$cumHazards[idx0]
            newQ$dQ[i] <- q$cumHazards[idx0] - newQ$cumQ[(i-1)]
        }
    }
    newQ$dQ[newQ$dQ == 0] <- 0.0001
    newQ$cumQ_upd <- newQ$cumQ
    for(i in 1:nrow(newQ)) {
        newQ$cumQ_upd[i] <- sum(newQ$dQ[1:i])
    }
    return(newQ)
}

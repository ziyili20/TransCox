dQtocumQ <- function(dQ, status = NULL) {
    if(length(status)>0) {
        cumQ = rep(NA, length(status))
        ncount = 1
        for(i in 1:length(status)) {
            if(status[i] == 2) {
                cumQ[i] = sum(dQ[1:ncount])
                ncount = ncount + 1
                if(ncount > length(dQ)) {
                    ncount = length(dQ)
                }
            } else {
                cumQ[i] = sum(dQ[1:ncount])
            }
        }
    } else {
        cumQ = rep(NA, length(dQ))
        for(i in 1:length(dQ)) {
            cumQ[i] = sum(dQ[1:i])
        }
    }
    return(cumQ)
}

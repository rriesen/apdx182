#!/usr/local/bin/Rscript
########################################################################
# Edgar A. Leon
# Lawrence Livermore National Laboratory
########################################################################

files = c('Lnx_100', 'Lnx_orig', 'mOS_100', 'mOS_orig')

i = 0
for (x in files) {
    if (i == 0) {
        df = read.table(paste(x, "dat", sep="."), colClasses = c('numeric'), 
                        col.names = x)
        len = length(df[,x])
    } else {
        tmp = read.table(paste(x, "dat", sep="."), 
                         colClasses = c('numeric'))
        vec = unlist(tmp, use.names=FALSE)
        pad = rep(NA, len - length(vec))
        if (length(vec) < len)
            vec = c(vec, pad)
        df[,x] = vec
    }
    i = i+1
}

df

colMeans(df, na.rm=TRUE)


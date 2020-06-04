#!/usr/local/bin/Rscript
########################################################################
# Edgar A. Leon
# Lawrence Livermore National Laboratory
#
#
########################################################################


data = read.table("layouts-2.dat",
                  colClasses = c('character', rep.int('numeric',3)), 
                  header=TRUE)

data 
colnames(data)

pdf("scrip-nemo-2.pdf", width=11, height=6, pointsize=12+8)

par(mar = par()$mar + c(-3, 0, -3, -1.5))

barplot(as.matrix(data), legend=rownames(data),
        names.arg=c("40 NEMO workers\n40 SCRIP workers",
                    "80 NEMO workers\n80 SCRIP workers",
                    "40 NEMO workers\n80 SCRIP workers"),
        ##col=c('green', 'red'),
        col=c("#00B000FF", "#FFD600FF"),
        args.legend = c(x="topright", bty='n'), 
        space=0.6,
        xlab="m - n: m NEMO workers and n SCRIP workers",
        ylab="Execution time (s)")

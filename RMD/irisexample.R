library("FRESA.CAD")

data('iris')

colors <- c("red","green","blue")
names(colors) <- names(table(iris$Species))
classcolor <- colors[iris$Species]

system.time(irisDecor <- GDSTMDecorrelation(iris,thr=0.25))
GDSTM <- attr(irisDecor,"GDSTM")
print(GDSTM)

gplots::heatmap.2(GDSTM,
                  trace = "none",
                  scale = "none",
                  dendrogram = "none",
                  mar = c(7,7),
                  col=rev(heat.colors(21)),
                  main = paste("Unsupervised GDSTM"),
                  cexRow = 0.75,
                  cexCol = 0.75,
                  key.title=NA,
                  key.xlab="Beta",
                  srtCol=35,
                  srtRow=-35,
                  xlab="Output Feature", ylab="Input Feature")

system.time(irisDecorOutcome <- GDSTMDecorrelation(iris,Outcome="Species",thr=0.25))
GDSTM <- attr(irisDecorOutcome,"GDSTM")
print(GDSTM)

gplots::heatmap.2(GDSTM,
                  trace = "none",
                  scale = "none",
                  dendrogram = "none",
                  mar = c(7,7),
                  col=rev(heat.colors(21)),
                  main = paste("Supervised GDSTM"),
                  cexRow = 0.75,
                  cexCol = 0.75,
                  key.title=NA,
                  key.xlab="Beta",
                  srtCol=35,
                  srtRow=-35,
                  xlab="Output Feature", ylab="Input Feature")

features <- colnames(iris[,sapply(iris,is,"numeric")])
irisPCA <- prcomp(iris[,features]);
print(irisPCA$rotation)

gplots::heatmap.2(irisPCA$rotation,
                  trace = "none",
                  scale = "none",
                  dendrogram = "none",
                  mar = c(7,7),
                  col=rev(heat.colors(21)),
                  main = paste("PCA Rotation"),
                  cexRow = 0.75,
                  cexCol = 0.75,
                  key.title=NA,
                  key.xlab="Beta",
                  srtCol=35,
                  srtRow=-35,
                  xlab="Output Feature", ylab="Input Feature")


plot(iris[,features],col=classcolor,main="Raw IRIS")

plot(as.data.frame(irisPCA$x),col=classcolor,main="PCA IRIS")

featuresDecor <- colnames(irisDecor[,sapply(irisDecor,is,"numeric")])
plot(irisDecor[,featuresDecor],col=classcolor,main="Unsupervised FCA IRIS")


featuresDecor <- colnames(irisDecorOutcome[,sapply(irisDecorOutcome,is,"numeric")])
plot(irisDecorOutcome[,featuresDecor],col=classcolor,main="Supervised FCA IRIS")
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

## Plotting the histograms of the features
par(mfrow=c(1,3))
h <- hist(iris$Sepal.Length,main="Raw: Sepal Lenght")
h <- hist(irisDecor$De_Sepal.Length,main="Unsup_FCA: Sepal Lenght")
h <- hist(irisDecorOutcome$De_Sepal.Length,main="Sup_FCA: Sepal Lenght")

h <- hist(iris$Sepal.Width,main="Raw: Sepal Width")
h <- hist(irisDecor$De_Sepal.Width,main="Unsup_FCA: Sepal Width")
h <- hist(irisDecorOutcome$De_Sepal.Width,main="Sup_FCA: Sepal Width")

h <- hist(iris$Petal.Length,main="Raw: Petal Length")
h <- hist(irisDecor$Ba_Petal.Length,main="Unsup_FCA: Petal Length")
h <- hist(irisDecorOutcome$De_Petal.Length,main="Sup_FCA: Petal Length")

h <- hist(iris$Petal.Width,main="Raw: Petal Width")
h <- hist(irisDecor$De_Petal.Width,main="Unsup_FCA: Petal Width")
h <- hist(irisDecorOutcome$Ba_Petal.Width,main="Sup_FCA: Petal Width")

par(mfrow=c(1,1))
boxplot(cbind(Raw=iris$Sepal.Length,
              Unsup_FCA=irisDecor$De_Sepal.Length,
              Sup_FCA=irisDecorOutcome$De_Sepal.Length),
       main="Sepal Length")

boxplot(cbind(Raw=iris$Sepal.Width,
              Unsup_FCA=irisDecor$De_Sepal.Width,
              Sup_FCA=irisDecorOutcome$De_Sepal.Width),
        main="Sepal Width")


boxplot(cbind(Raw=iris$Petal.Length,
              Unsup_FCA=irisDecor$Ba_Petal.Length,
              Sup_FCA=irisDecorOutcome$De_Petal.Length),
        main="Petal Length")

boxplot(cbind(Raw=iris$Petal.Width,
              Unsup_FCA=irisDecor$De_Petal.Width,
              Sup_FCA=irisDecorOutcome$Ba_Petal.Width),
        main="Petal Width")

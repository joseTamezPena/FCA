
library("FRESA.CAD")

pdf(file = "GDSTMDecorrelation.IRIS.Example.pdf",width = 8, height = 6)

data('iris')

colors <- c("red","green","blue")
names(colors) <- names(table(iris$Species))
classcolor <- colors[iris$Species]

##FCA Decorrelation at 0.25 threshold, pearson and fast estimation 
system.time(irisDecor <- GDSTMDecorrelation(iris,thr=0.25))

### Print the latent variables
print(getLatentCoefficients(irisDecor));

GDSTM <- attr(irisDecor,"GDSTM")

print(GDSTM)

## The heat map of the generated decorrelation matrix
gplots::heatmap.2(GDSTM,
                  trace = "none",
                  scale = "none",
                  dendrogram = "none",
                  mar = c(7,7),
                  col=rev(heat.colors(21)),
                  main = paste("GDSTM Matrix"),
                  cexRow = 0.75,
                  cexCol = 0.75,
                  key.title=NA,
                  key.xlab="Beta",
                  srtCol=35,
                  srtRow=-35,
                  xlab="Output Feature", ylab="Input Feature")

## Estimating a new decorrelation matrix using supervised basis. ie. Keep unaltered features associated with outcome

system.time(irisDecorOutcome <- GDSTMDecorrelation(iris,Outcome="Species",thr=0.25))

### Print the latent variables
print(getLatentCoefficients(irisDecorOutcome));

GDSTM <- attr(irisDecorOutcome,"GDSTM")
print(GDSTM)


## Heat map of The Decorrelation matrix
gplots::heatmap.2(GDSTM,
                  trace = "none",
                  scale = "none",
                  dendrogram = "none",
                  mar = c(7,7),
                  col=rev(heat.colors(21)),
                  main = paste("Outcome-Driven GDSTM"),
                  cexRow = 0.75,
                  cexCol = 0.75,
                  key.title=NA,
                  key.xlab="Beta",
                  srtCol=35,
                  srtRow=-35,
                  xlab="Output Feature", ylab="Input Feature")


## We will compare to PCA decorrelation
features <- colnames(iris[,sapply(iris,is,"numeric")])
irisPCA <- prcomp(iris[,features]);
print(irisPCA$rotation)


## Heatmap of The PCA Transformation matrix
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


## Plots of the original, and the transformed data sets

plot(iris[,features],col=classcolor,main="Raw IRIS")

plot(as.data.frame(irisPCA$x),col=classcolor,main="PCA IRIS")

featuresDecor <- colnames(irisDecor[,sapply(irisDecor,is,"numeric")])
plot(irisDecor[,featuresDecor],col=classcolor,main="GDSTM IRIS")


featuresDecor <- colnames(irisDecorOutcome[,sapply(irisDecorOutcome,is,"numeric")])
plot(irisDecorOutcome[,featuresDecor],col=classcolor,main="Outcome-Driven GDSTM IRIS")

## Plotting the histograms of the features
par(mfrow=c(2,3))
h <- hist(iris$Sepal.Length,main="Raw: Sepal Lenght")
h <- hist(irisDecor$La_Sepal.Length,main="Unsup_FCA: Sepal Lenght")
h <- hist(irisDecorOutcome$La_Sepal.Length,main="Sup_FCA: Sepal Lenght")

h <- hist(iris$Sepal.Width,main="Raw: Sepal Width")
h <- hist(irisDecor$La_Sepal.Width,main="Unsup_FCA: Sepal Width")
h <- hist(irisDecorOutcome$La_Sepal.Width,main="Sup_FCA: Sepal Width")

h <- hist(iris$Petal.Length,main="Raw: Petal Length")
h <- hist(irisDecor$Petal.Length,main="Unsup_FCA: Petal Length")
h <- hist(irisDecorOutcome$La_Petal.Length,main="Sup_FCA: Petal Length")

h <- hist(iris$Petal.Width,main="Raw: Petal Width")
h <- hist(irisDecor$La_Petal.Width,main="Unsup_FCA: Petal Width")
h <- hist(irisDecorOutcome$Petal.Width,main="Sup_FCA: Petal Width")

## Box plots to compare the feature distributions among decorrelation schemes
par(mfrow=c(2,2))
boxplot(cbind(Raw=iris$Sepal.Length,
              Unsup_FCA=irisDecor$La_Sepal.Length,
              Sup_FCA=irisDecorOutcome$La_Sepal.Length),
       main="Sepal Length")

boxplot(cbind(Raw=iris$Sepal.Width,
              Unsup_FCA=irisDecor$La_Sepal.Width,
              Sup_FCA=irisDecorOutcome$La_Sepal.Width),
        main="Sepal Width")


boxplot(cbind(Raw=iris$Petal.Length,
              Unsup_FCA=irisDecor$Petal.Length,
              Sup_FCA=irisDecorOutcome$La_Petal.Length),
        main="Petal Length")

boxplot(cbind(Raw=iris$Petal.Width,
              Unsup_FCA=irisDecor$La_Petal.Width,
              Sup_FCA=irisDecorOutcome$Petal.Width),
        main="Petal Width")

## Box plots by type of iris

par(mfrow=c(2,3))
boxplot(iris$Sepal.Length~iris$Species,
        notch=TRUE,
        ylab="Sepal Length",
        main="Raw: Sepal Length")

boxplot(irisDecor$La_Sepal.Length~iris$Species,
        notch=TRUE,
        ylab="De Sepal Length",
        main="Un_Decor: Sepal Length")

boxplot(irisDecorOutcome$La_Sepal.Length~iris$Species,
        notch=TRUE,
        ylab="De Sepal Length",
        main="Sup_Decor: Sepal Length")


boxplot(iris$Petal.Length~iris$Species,
        notch=TRUE,
        ylab="Petal Length",
        main="Raw: Petal Length")

boxplot(irisDecor$Petal.Length~iris$Species,
        notch=TRUE,
        ylab="Petal Length",
        main="GDSTM: Petal Length")

boxplot(irisDecorOutcome$La_Petal.Length~iris$Species,
        notch=TRUE,
        ylab="De Petal Length",
        main="Outcome-Decor: Petal Length")

boxplot(iris$Sepal.Width~iris$Species,
        notch=TRUE,
        ylab="Sepal Width",
        main="Raw: Sepal Width")

boxplot(irisDecor$La_Sepal.Width~iris$Species,
        notch=TRUE,
        ylab="De Sepal Width",
        main="GDSTM: Sepal Width")

boxplot(irisDecorOutcome$La_Sepal.Width~iris$Species,
        notch=TRUE,
        ylab="De Sepal Width",
        main="Outcme-Driven: Sepal Width")

boxplot(iris$Petal.Width~iris$Species,
        notch=TRUE,
        ylab="Petal Width",
        main="Raw: Petal Width")

boxplot(irisDecor$La_Petal.Width~iris$Species,
        notch=TRUE,
        ylab="De Petal Width",
        main="GDSTM: Petal Width")

boxplot(irisDecorOutcome$Petal.Width~iris$Species,
        notch=TRUE,
        ylab="Petal Width",
        main="Outcome-Driven: Petal Width")

dev.off()



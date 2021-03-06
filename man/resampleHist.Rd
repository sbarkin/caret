\name{resampleHist}
\alias{resampleHist}
\title{Plot the resampling distribution of the model statistics}
\description{
Create a lattice histogram or densityplot from the resampled outcomes from a \code{train} object.
}
\usage{
resampleHist(object, type = "density", ...)
}
\arguments{
  \item{object}{an object resulting form a call to \code{\link{train}}}
  \item{type}{a character string. Either "hist" or "density"}
  \item{\dots}{options to pass to histogram or densityplot}
}
\details{
All the metrics from the object are plotted, but only for the final model. For more comprehensive plots functions, see  \code{\link{histogram.train}}, \code{\link{densityplot.train}}, \code{\link{xyplot.train}}, \code{\link{stripplot.train}}.

For the plot to be made, the \code{returnResamp} argument in \code{\link{trainControl}} should be either "final" or "all".
}
\value{
a object of class \code{trellis}
}
\author{Max Kuhn}

\seealso{\code{\link{train}}, \code{\link[lattice]{histogram}}, \code{\link[lattice:histogram]{densityplot}},  \code{\link{histogram.train}}, \code{\link{densityplot.train}}, \code{\link{xyplot.train}}, \code{\link{stripplot.train}}}
\examples{

\dontrun{
data(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]

knnFit <- train(TrainData, TrainClasses, "knn")

resampleHist(knnFit)
}
}
\keyword{hplot}

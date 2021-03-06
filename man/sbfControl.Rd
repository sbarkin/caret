\name{sbfControl}
\alias{sbfControl}
\title{
Control Object for Selection By Filtering (SBF)
}
\description{
Controls the execution of models with simple filters for feature selection
}
\usage{
sbfControl(functions = NULL, 
           method = "boot", 
           saveDetails = FALSE, 
           number = ifelse(method \%in\% c("cv", "repeatedcv"), 10, 25),
           repeats = ifelse(method \%in\% c("cv", "repeatedcv"), 1, number),
           verbose = FALSE, 
           returnResamp = "final", 
           p = 0.75, 
           index = NULL, 
           timingSamps = 0,
           seeds = NA,
           allowParallel = TRUE)
}
\arguments{
  \item{functions}{a list of functions for model fitting, prediction and variable filtering (see Details below)}
  \item{method}{The external resampling method: \code{boot}, \code{cv},
    \code{LOOCV} or  \code{LGOCV} (for repeated training/test splits}
  \item{number}{Either the number of folds or number of resampling iterations}
  \item{repeats}{For repeated k-fold cross-validation only: the number of complete sets of folds to compute}
  \item{saveDetails}{a logical to save the predictions and variable importances from the selection process}
  \item{verbose}{a logical to print a log for each external resampling iteration}
  \item{returnResamp}{A character string indicating how much of the resampled summary metrics should be saved. Values can be ``final'' or ``none''}
  \item{p}{For leave-group out cross-validation: the training percentage}
  \item{index}{a list with elements for each external resampling iteration. Each list element is the sample rows used for training at that iteration.}
  \item{timingSamps}{the number of training set samples that will be used to measure the time for predicting samples (zero indicates that the prediction time should not be estimated).}
    \item{seeds}{an optional set of integers that will be used to set the seed at each resampling iteration. This is useful when the models are run in parallel. A value of \code{NA} will stop the seed from being set within the worker processes while a value of \code{NULL} will set the seeds using a random set of integers. Alternatively, a vector of integers can be used. The vector should have \code{B+1} elements where \code{B} is the number of resamples. See the Examples section below. }  
  \item{allowParallel}{if a parallel backend is loaded and available, should the function use it?}
}

\details{
More details on this function can be found at \url{http://caret.r-forge.r-project.org/featureselection.html}.

Simple filter-based feature selection requires function to be specified for some operations. 

The \code{fit} function builds the model based on the current data set. The arguments for the function must be:
\itemize{
      \item{\code{x}}{ the current training set of predictor data with
            the appropriate subset of variables (i.e. after filtering)}
      \item{\code{y}}{ the current outcome data (either a numeric or 
            factor vector)}
      \item{\code{...}}{ optional arguments to pass to the fit 
            function in the call to \code{sbf}}
}
The function should return a model object that can be used to generate predictions.

The \code{pred} function returns a vector of predictions (numeric or factors) from the current model. The arguments are:
\itemize{
      \item{\code{object}}{ the model generated by the \code{fit} 
            function}
      \item{\code{x}}{ the current set of predictor set for the 
            held-back samples}
}

The \code{score} function is used to return a vector of scores with names for each predictor (such as a p-value). Inputs are:
\itemize{
      \item{\code{x}}{ the  predictors for the training samples}
      \item{\code{y}}{ the current training outcomes}
}
The function should return a vector, as previously stated. Examples are give by \code{\link{anovaScores}} for classification and  \code{\link{gamScores}} for regression.

The \code{filter} function is used to return a logical vector with names for each predictor (\code{TRUE} indicates that the prediction should be retained). Inputs are:
\itemize{
      \item{\code{score}}{ the output of the \code{score} function}
      \item{\code{x}}{ the  predictors for the training samples}
      \item{\code{y}}{ the current training outcomes}
}
The function should return a named logical vector.


Examples of these functions are included in the package: \code{\link{caretSBF}}, \code{\link{lmSBF}}, \code{\link{rfSBF}}, \code{\link{treebagSBF}}, \code{\link{ldaSBF}} and \code{\link{nbSBF}}.

The web page  \url{http://caret.r-forge.r-project.org/} has more details and examples related to this function.

}
\value{
a list that echos the specified arguments
}

\author{
Max Kuhn
}

\seealso{
\code{\link{sbf}}, \code{\link{caretSBF}}, \code{\link{lmSBF}}, \code{\link{rfSBF}}, \code{\link{treebagSBF}}, \code{\link{ldaSBF}} and \code{\link{nbSBF}}
}

\examples{
\dontrun{
data(BloodBrain)

## Use a GAM is the filter, then fit a random forest model
RFwithGAM <- sbf(bbbDescr, logBBB,
                 sbfControl = sbfControl(functions = rfSBF,
                                         verbose = FALSE, 
                                         seeds = sample.int(100000, 11),
                                         method = "cv"))
RFwithGAM
}}

\keyword{ utilities }

# plumber.R

library("randomForest")

#' @apiTitle Prediction service for 'virginica' iris species
#' @apiDescription This is a small application to exemplify use of Plumber to create APIs for R service
#' @apiVersion 0.0.1.1

#' Check the status of the system
#' @get /status
function(){
  list(paste0("The status is OK"))
}


#' Return the number of samples in iris data; param specify the species
#' @param spec The species for which we return the number of samples
#' @get /samples
function(spec=""){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    myData <- subset(iris, Species == spec)
  }
  list( paste0("Samples: '",nrow(myData), "'"))
}


#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @png
function(spec){
  irisData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    irisData <- subset(iris, Species == spec)
  }
  
  plot(irisData$Sepal.Length, irisData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length", col=irisData$Species)
  
  legend("topleft", legend=c("setosa", "versicolor", "virginica"), 
                   col=c("black", "red", "green" ), lty=1, cex=0.8)
}


#' Classifier model - providing 2 parameters (Sepal.Length & Petal.Length) we predict the species
#' @param sepal_length Sepal.Length
#' @param petal_length Petal.Length
#' @post /prediction_class
function(req, sepal_length, petal_length){
  
  # sample only Sepal.Length & Petal.Length
  x <- iris[sample(1:nrow(iris)),c(1,3,5)]
  
  # train the model
  #model <- randomForest(Species ~ .,
  #             data=x,
  #             ntree=100)
  
  model <- readRDS("model.RDS")
  
  # prepare the set to predict
  y = iris[sample(1:1),c(1,3,5)]

  y$Species <- NULL
  y$Sepal.Length = as.numeric(sepal_length)
  y$Petal.Length = as.numeric(petal_length)
  
  prediction <- predict(model, y, type="response")
  
  #return the species
  list(prediction)
}


library("randomForest")


# test prediction
test_model <- function(sepal_length, petal_length) {
  y = iris[sample(1:1),c(1,3,5)]
  y$virginica <- NULL
  y$Species <- NULL
  y$Sepal.Length = as.numeric(sepal_length)
  y$Petal.Length = as.numeric(petal_length)
  
  prediction <- predict(model, y, type="response")
  
  #return the species
  print(sprintf("sepal length: %2.1f, petal length: %2.1f, Predicted: %s", sepal_length, petal_length, prediction))
  
}


# sample only Sepal.Length & Petal.Length
x <- iris[sample(1:nrow(iris)),c(1,3,5)]

# train the model
model <- randomForest(Species ~ .,
                      data=x,
                      ntree=100)

# save the model
saveRDS(model, file = "model.RDS")

# save the model
model <- readRDS("model.RDS")

# test the model
sepal_length = 4.0
petal_length = 2.1
test_model(sepal_length, petal_length)

sepal_length = 5.1
petal_length = 4.6
test_model(sepal_length, petal_length)

sepal_length = 7.2
petal_length = 7.5
test_model(sepal_length, petal_length)

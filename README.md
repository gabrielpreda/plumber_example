# Introduction

This is an example of using plumber to create an API for an R program. 

The service is exposing several endpoints as following:

* GET /status - return the status of the service
* GET /samples - 1 parameter: spec - if provided, return this species cardinality, otherwise return all samples cardinality
* GET /plot - 1 parameter: spec - if provided, plot only this species samples, otherwise plot all samples
* POST /prediction_virginica - 2 parameters: sepal_length & petal_length, predict if the class is `virginica` (model is glm)
* POST /prediction_class - 2 parameters: sepal_length & petal_length, predict the class (model is randomForest)

# Source files

The following files are included in the project:
* plumber.R - API using plumber
* run_it.R - script to start the API using plumber

# Usage

To start the service, run run_it.R
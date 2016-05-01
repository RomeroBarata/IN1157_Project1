# IN1157 - First Project
This project compares the performance of three classifiers trained on the [Concrete Compressive Strength](http://archive.ics.uci.edu/ml/datasets/Concrete+Compressive+Strength) data set.

We selected a Hybrid neural Fuzzy Inference System (HyFIS), a Generalised Linear Model (GLM), and a Support Vector Machine (SVM) as our classifiers. No tuning of the classifiers' parameters were realised. The mean `RMSE` and `R^2` metrics were computed from a ten-fold cross-validated resampling procedure repeated five times.

The `main.R` script performs all the experimentation. If having problems to run it, run the `config.R` script first.
Scripts can be run from the `R` command line using the `source` function, e.g. `source("main.R")`.

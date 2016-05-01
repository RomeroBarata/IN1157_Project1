# Constants
TRAIN_SEED <- 15476  # Make sure the comparison between models is fair

# Read data into the workspace
concrete <- read.csv(file.path("data", "Concrete_Data.csv"), header = TRUE)
names(concrete)[ncol(concrete)] <- "out"  # Make it easier to train the model

# Setup the caret control objects
library(caret)
fit_control <- trainControl(method = "repeatedcv", 
                            number = 10, repeats = 5)

# Enable for parallel computation
if (Sys.info()[[1]] == "Linux") doMC::registerDoMC(cores = 2)

# Train the GLM model
set.seed(TRAIN_SEED)
glm_model <- train(out ~ ., data = concrete, 
                   method = "glm", 
                   trControl = fit_control, 
                   preProc = c("center", "scale"))

# Train the SVM model
set.seed(TRAIN_SEED)
svm_model <- train(out ~ ., data = concrete, 
                   method = "svmRadial", 
                   trControl = fit_control, 
                   tuneGrid = expand.grid(C = 1, sigma = 0.1240874), 
                   preProc = c("center", "scale"))

# Define HyFIS parameters
hyfis_params <- expand.grid(num.labels = 7, max.iter = 10)
# Train the HyFIS model
# No need to center and scale the features, since the HyFIS model code does it
# automatically.
set.seed(TRAIN_SEED)
hyfis_model <- train(out ~ ., data = concrete, 
                     method = "HYFIS", 
                     trControl = fit_control, 
                     tuneGrid = hyfis_params)

# Resampled performance
resamps <- resamples(list(GLM = glm_model, 
                          SVM = svm_model, 
                          HyFIS = hyfis_model))
diffValues <- diff(resamps)

# Print and plot performances
summary(resamps)
summary(diffValues)
trellis.par.set(caretTheme())
dotplot(resamps, metric = "RMSE")
dotplot(resamps, metric = "Rsquared")
dotplot(diffValues)
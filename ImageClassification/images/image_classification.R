# ============================================================
# WEEK 6 - IMAGE RECOGNITION & CLASSIFICATION USING KERAS
# Plane vs Car Classification
# ============================================================


# ============================================================
# 1. LOAD LIBRARIES
# ============================================================

library(EBImage)
library(keras3)
library(reticulate)
library(magrittr)


# ============================================================
# 2. CONFIGURE PYTHON
# ============================================================

reticulate::use_python(
  "C:/Users/siddh/AppData/Local/Programs/Python/Python311/python.exe",
  required = TRUE
)

cat("Checking TensorFlow...\n")

if (!reticulate::py_module_available("tensorflow")) {
  stop("TensorFlow is not available. Please install TensorFlow in Python 3.11.")
}

cat("TensorFlow is available!\n")


# ============================================================
# 3. SET WORKING DIRECTORY
# ============================================================

setwd("C:/R Weeks/ImageClassification/images")

cat("Working directory:\n")
print(getwd())


# ============================================================
# 4. IMAGE FILE NAMES
# ============================================================

pics <- c(
  "p1.jpg",
  "p2.jpg",
  "p3.jpg",
  "p4.jpg",
  "p5.jpg",
  "p6.jpg",
  "c1.jpg",
  "c2.jpg",
  "c3.jpg",
  "c4.jpg",
  "c5.jpg",
  "c6.jpg"
)


# ============================================================
# 5. CHECK WHETHER ALL IMAGES EXIST
# ============================================================

cat("\nChecking images...\n")

if (!all(file.exists(pics))) {

  missing_files <- pics[!file.exists(pics)]

  cat("Missing files:\n")
  print(missing_files)

  stop("Some image files are missing.")
}

cat("All 12 images found!\n")


# ============================================================
# 6. READ IMAGES
# ============================================================

cat("\nReading images...\n")

mypic <- list()

for (i in 1:length(pics)) {

  mypic[[i]] <- readImage(pics[i])

  cat(
    "Loaded:",
    pics[i],
    "\n"
  )
}

cat("\nAll images loaded successfully!\n")


# ============================================================
# 7. EXPLORE IMAGES
# ============================================================

cat("\nStructure of first image:\n")

print(mypic[[1]])

cat("\nSummary of first image:\n")

print(summary(mypic[[1]]))


# ============================================================
# 8. DISPLAY AN IMAGE
# ============================================================

cat("\nDisplaying image 8...\n")

display(mypic[[8]])


# ============================================================
# 9. IMAGE HISTOGRAM
# ============================================================

cat("\nDisplaying histogram of image 2...\n")

hist(mypic[[2]])


# ============================================================
# 10. RESIZE ALL IMAGES
# ============================================================

cat("\nResizing images to 28 x 28...\n")

for (i in 1:length(mypic)) {

  mypic[[i]] <- resize(
    mypic[[i]],
    w = 28,
    h = 28
  )
}

cat("All images resized!\n")


# ============================================================
# 11. CHECK IMAGE DIMENSION
# ============================================================

cat("\nDimension of first resized image:\n")

print(dim(mypic[[1]]))


# ============================================================
# 12. NUMBER OF FEATURES
# ============================================================

features <- 28 * 28 * 3

cat(
  "\nNumber of features:",
  features,
  "\n"
)


# ============================================================
# 13. CONVERT IMAGES INTO NUMERIC VECTORS
# ============================================================

cat("\nConverting images into feature vectors...\n")

image_vectors <- list()

for (i in 1:length(mypic)) {

  image_vectors[[i]] <- as.vector(mypic[[i]])

}


# ============================================================
# 14. CREATE TRAINING DATA
# ============================================================

# p1-p5 = training planes
# c1-c5 = training cars

trainx <- matrix(
  unlist(
    c(
      image_vectors[1:5],
      image_vectors[7:11]
    )
  ),
  nrow = 10,
  byrow = TRUE
)


# ============================================================
# 15. CREATE TEST DATA
# ============================================================

# p6 = test plane
# c6 = test car

testx <- matrix(
  unlist(
    c(
      image_vectors[6],
      image_vectors[12]
    )
  ),
  nrow = 2,
  byrow = TRUE
)


# ============================================================
# 16. CHECK TRAINING AND TEST DATA
# ============================================================

cat("\nTraining data dimension:\n")
print(dim(trainx))

cat("\nTesting data dimension:\n")
print(dim(testx))


# ============================================================
# 17. CREATE CLASS LABELS
# ============================================================

# 0 = Plane
# 1 = Car

trainy <- c(
  0, 0, 0, 0, 0,
  1, 1, 1, 1, 1
)

testy <- c(
  0,
  1
)


cat("\nTraining labels:\n")
print(trainy)

cat("\nTesting labels:\n")
print(testy)


# ============================================================
# 18. ONE-HOT ENCODING
# ============================================================

trainLabels <- keras3::to_categorical(
  trainy,
  num_classes = 2
)

testLabels <- keras3::to_categorical(
  testy,
  num_classes = 2
)


cat("\nTraining one-hot labels:\n")
print(trainLabels)

cat("\nTesting one-hot labels:\n")
print(testLabels)


# ============================================================
# 19. BUILD KERAS MODEL
# ============================================================

cat("\nBuilding neural network...\n")

model <- keras_model_sequential()


model %>%

  layer_dense(
    units = 256,
    activation = "relu",
    input_shape = c(features)
  ) %>%

  layer_dense(
    units = 128,
    activation = "relu"
  ) %>%

  layer_dense(
    units = 2,
    activation = "softmax"
  )


# ============================================================
# 20. DISPLAY MODEL
# ============================================================

cat("\nModel summary:\n")

summary(model)


# ============================================================
# 21. COMPILE MODEL
# ============================================================

cat("\nCompiling model...\n")

compile(
  model,

  optimizer = optimizer_rmsprop(),

  loss = "categorical_crossentropy",

  metrics = "accuracy"
)


cat("Model compiled successfully!\n")


# ============================================================
# 22. TRAIN MODEL
# ============================================================

cat("\nTraining model...\n")

history <- fit(

  model,

  x = trainx,

  y = trainLabels,

  epochs = 30,

  batch_size = 2,

  validation_split = 0.2,

  verbose = 1
)


# ============================================================
# 23. PLOT TRAINING HISTORY
# ============================================================

cat("\nPlotting training history...\n")

plot(history)


# ============================================================
# 24. EVALUATE TRAINING DATA
# ============================================================

cat("\nEvaluating training data...\n")

train_result <- evaluate(

  model,

  trainx,

  trainLabels,

  verbose = 0
)

print(train_result)


# ============================================================
# 25. PREDICT TRAINING DATA
# ============================================================

cat("\nPredicting training data...\n")

pred_prob <- predict(

  model,

  trainx,

  verbose = 0
)


# ============================================================
# 26. GET PREDICTED CLASS
# ============================================================

pred <- max.col(pred_prob) - 1


cat("\nPredicted training classes:\n")

print(pred)


# ============================================================
# 27. TRAINING CONFUSION MATRIX
# ============================================================

cat("\nTraining Confusion Matrix:\n")

print(
  table(
    Predicted = pred,
    Actual = trainy
  )
)


# ============================================================
# 28. TRAINING PREDICTION PROBABILITIES
# ============================================================

cat("\nTraining prediction probabilities:\n")

print(
  cbind(
    Probability_Plane = pred_prob[, 1],
    Probability_Car = pred_prob[, 2],
    Predicted = pred,
    Actual = trainy
  )
)


# ============================================================
# 29. EVALUATE TEST DATA
# ============================================================

cat("\nEvaluating test data...\n")

test_result <- evaluate(

  model,

  testx,

  testLabels,

  verbose = 0
)


print(test_result)


# ============================================================
# 30. PREDICT TEST DATA
# ============================================================

cat("\nPredicting test data...\n")

test_prob <- predict(

  model,

  testx,

  verbose = 0
)


# ============================================================
# 31. GET TEST PREDICTIONS
# ============================================================

test_pred <- max.col(test_prob) - 1


cat("\nTest predictions:\n")

print(test_pred)


# ============================================================
# 32. TEST CONFUSION MATRIX
# ============================================================

cat("\nTest Confusion Matrix:\n")

print(
  table(
    Predicted = test_pred,
    Actual = testy
  )
)


# ============================================================
# 33. TEST PREDICTION PROBABILITIES
# ============================================================

cat("\nTest prediction probabilities:\n")

print(
  cbind(
    Probability_Plane = test_prob[, 1],
    Probability_Car = test_prob[, 2],
    Predicted = test_pred,
    Actual = testy
  )
)


# ============================================================
# 34. FINAL CLASSIFICATION
# ============================================================

cat("\n====================================\n")
cat("FINAL CLASSIFICATION\n")
cat("====================================\n")


for (i in 1:length(test_pred)) {

  if (test_pred[i] == 0) {

    cat(
      "Test image",
      i,
      "-> PLANE\n"
    )

  } else {

    cat(
      "Test image",
      i,
      "-> CAR\n"
    )

  }

}


# ============================================================
# 35. FINAL ACCURACY
# ============================================================

test_accuracy <- mean(
  test_pred == testy
)


cat(
  "\nTest Accuracy:",
  test_accuracy * 100,
  "%\n"
)


cat("\n====================================\n")
cat("WEEK 6 COMPLETED SUCCESSFULLY!\n")
cat("====================================\n")
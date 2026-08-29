# Image Recognition and Classification using R

## 📌 Objective

The objective of this experiment is to perform **image recognition and classification using R** with **EBImage, Keras3, and TensorFlow**.

In this experiment, images belonging to two classes are used:

* ✈️ Plane
* 🚗 Car

The images are processed, resized, converted into numerical features, and then given to a neural network model for classification.

---

## 🛠️ Technologies Used

* R 4.6.1
* EBImage
* Keras3
* TensorFlow 2.21
* Reticulate
* Python 3.11.9

---

## 📂 Project Structure

```text
ImageClassification/
│
├── images/
│   ├── p1.jpg
│   ├── p2.jpg
│   ├── p3.jpg
│   ├── p4.jpg
│   ├── p5.jpg
│   ├── p6.jpg
│   ├── c1.jpg
│   ├── c2.jpg
│   ├── c3.jpg
│   ├── c4.jpg
│   ├── c5.jpg
│   └── c6.jpg
│
├── week6.R
└── README.md
```

---

## 🖼️ Dataset

The dataset contains **12 images** belonging to two classes.

### ✈️ Plane Images

```text
p1.jpg
p2.jpg
p3.jpg
p4.jpg
p5.jpg
p6.jpg
```

### 🚗 Car Images

```text
c1.jpg
c2.jpg
c3.jpg
c4.jpg
c5.jpg
c6.jpg
```

### Training and Testing Data

The first five images from each class are used for training, while the sixth image from each class is used for testing.

| Images  | Purpose  |
| ------- | -------- |
| p1 - p5 | Training |
| c1 - c5 | Training |
| p6      | Testing  |
| c6      | Testing  |

---

## ⚙️ Image Processing

The images are loaded using the **EBImage** package.

Each image is resized to:

```text
28 × 28 × 3
```

where:

* `28` = Image height
* `28` = Image width
* `3` = RGB color channels

Therefore, each image contains:

```text
28 × 28 × 3 = 2352
```

features.

These features are used as the input to the neural network.

---

## 🧠 Neural Network Model

A simple **fully connected neural network** is used for image classification.

### Model Architecture

```text
                 Input Image
                     │
                     ▼
                 28 × 28 × 3
                     │
                     ▼
               2352 Features
                     │
                     ▼
              Dense Layer
              256 Neurons
                  ReLU
                     │
                     ▼
              Dense Layer
              128 Neurons
                  ReLU
                     │
                     ▼
              Output Layer
               2 Neurons
                 Softmax
                     │
                     ▼
                ┌─────────┐
                │         │
              Plane      Car
```

---

## 🏷️ Class Labels

The classes are represented using numerical labels:

```text
0 → Plane
1 → Car
```

The labels are converted into categorical/one-hot encoded values before training the neural network.

---

## 🚀 Model Training

The neural network is trained using the following configuration:

| Parameter        | Value                |
| ---------------- | -------------------- |
| Optimizer        | RMSprop              |
| Loss Function    | Binary Cross Entropy |
| Epochs           | 30                   |
| Batch Size       | 32                   |
| Validation Split | 20%                  |
| Output Classes   | 2                    |

---

## 📊 Model Evaluation

After training, the model is evaluated using:

* Training accuracy
* Test accuracy
* Prediction probabilities
* Confusion matrix

The model predicts whether an image belongs to the **Plane** or **Car** class.

---

## ▶️ How to Run

### 1. Install R

Install **R 4.6.1** or a compatible version.

---

### 2. Install Required R Packages

Open R or the R terminal and run:

```r
install.packages("keras3")
install.packages("reticulate")
install.packages("BiocManager")

BiocManager::install("EBImage")
```

Then load the packages:

```r
library(EBImage)
library(keras3)
library(reticulate)
```

---

### 3. Install Python

Python **3.11.9** is used for this project.

Verify the Python installation:

```powershell
py -3.11 --version
```

Expected output:

```text
Python 3.11.9
```

---

### 4. Install TensorFlow

Install TensorFlow using:

```powershell
py -3.11 -m pip install tensorflow
```

The project uses TensorFlow as the backend for Keras3.

---

### 5. Configure Python in R

Configure R to use the installed Python 3.11 interpreter:

```r
library(reticulate)

use_python(
  "C:/Users/siddh/AppData/Local/Programs/Python/Python311/python.exe",
  required = TRUE
)
```

Verify that TensorFlow is available:

```r
reticulate::py_module_available("tensorflow")
```

Expected output:

```text
[1] TRUE
```

---

### 6. Run the R Program

Open:

```text
week6.R
```

Make sure the `images` folder is present in the project directory.

Then run the complete R script.

---

## 🔍 Expected Workflow

The program performs the following steps:

1. Load required R libraries.
2. Set the working directory.
3. Read the plane and car images.
4. Explore the images.
5. Resize the images to `28 × 28`.
6. Reshape the images into numerical data.
7. Create the training dataset.
8. Create the testing dataset.
9. Create class labels.
10. Perform one-hot encoding.
11. Build the neural network.
12. Compile the model.
13. Train the model.
14. Plot the training history.
15. Evaluate the training data.
16. Generate training predictions.
17. Generate the training confusion matrix.
18. Evaluate the testing data.
19. Generate test predictions.
20. Generate the test confusion matrix.
21. Display the final classification results.

---

## 📈 Example Output

The final classification displays the predicted class for each test image.

Example:

```text
Test image 1 -> PLANE
Test image 2 -> CAR
```

> **Note:** The actual output may vary depending on the images and model training.

---

## 📚 Learning Outcomes

After completing this experiment, the following concepts are understood:

* Image processing using R
* Loading images using EBImage
* RGB image representation
* Image resizing
* Image reshaping
* Converting images into numerical features
* Creating training and testing datasets
* One-hot encoding
* Building a neural network using Keras3
* Using TensorFlow as a backend
* Training an image classification model
* Evaluating model performance
* Generating prediction probabilities
* Creating a confusion matrix
* Classifying images into different categories

---

## 🧪 Experiment Result

A neural network-based image classification system was successfully implemented using **R, EBImage, Keras3, and TensorFlow**.

The trained model can classify the given test images into two classes:

```text
✈️ Plane
🚗 Car
```

---

## 👨‍💻 Author

**Siddharth Metkari**

BTech Computer Engineering

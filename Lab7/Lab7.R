# ============================================================
# CUSTOMER SEGMENTATION LAB
# LOAD DATA + PREPROCESSING + RFM + ELBOW METHOD
# ============================================================

# ------------------------------------------------------------
# 1. LOAD REQUIRED PACKAGES
# ------------------------------------------------------------

packages <- c(
  "readxl",
  "dplyr",
  "ggplot2",
  "cluster",
  "factoextra"
)

installed <- rownames(installed.packages())

for (p in packages) {
  if (!(p %in% installed)) {
    install.packages(p)
  }
}

library(readxl)
library(dplyr)
library(ggplot2)
library(cluster)
library(factoextra)


# ------------------------------------------------------------
# 2. LOAD ONLINE RETAIL DATASET
# ------------------------------------------------------------

file_path <- "C:/R Weeks/Lab7/Online Retail.xlsx"

retail <- read_excel(file_path)

cat("\n============================================\n")
cat("ONLINE RETAIL DATASET LOADED SUCCESSFULLY\n")
cat("============================================\n")

cat("Rows:", nrow(retail), "\n")
cat("Columns:", ncol(retail), "\n")

cat("\nColumn names:\n")
print(colnames(retail))

cat("\nFirst 6 records:\n")
print(head(retail))


# ------------------------------------------------------------
# 3. CHECK MISSING VALUES
# ------------------------------------------------------------

cat("\n============================================\n")
cat("MISSING VALUES\n")
cat("============================================\n")

print(colSums(is.na(retail)))


# ------------------------------------------------------------
# 4. DATA PREPROCESSING
# ------------------------------------------------------------

retail_clean <- retail %>%

  # Remove missing Customer IDs
  filter(!is.na(CustomerID)) %>%

  # Remove cancelled invoices
  filter(!grepl("^C", InvoiceNo)) %>%

  # Remove invalid transactions
  filter(
    Quantity > 0,
    UnitPrice > 0
  ) %>%

  # Remove duplicate transactions
  distinct()


cat("\n============================================\n")
cat("DATA PREPROCESSING COMPLETED\n")
cat("============================================\n")

cat(
  "Records after preprocessing:",
  nrow(retail_clean),
  "\n"
)


# ------------------------------------------------------------
# 5. CREATE TOTAL TRANSACTION VALUE
# ------------------------------------------------------------

retail_clean <- retail_clean %>%
  mutate(
    TotalAmount = Quantity * UnitPrice
  )


# ------------------------------------------------------------
# 6. CONVERT INVOICE DATE
# ------------------------------------------------------------

retail_clean$InvoiceDate <-
  as.POSIXct(retail_clean$InvoiceDate)


# ------------------------------------------------------------
# 7. FIND LATEST TRANSACTION DATE
# ------------------------------------------------------------

max_date <-
  max(retail_clean$InvoiceDate)

cat(
  "\nLatest transaction date:",
  as.character(max_date),
  "\n"
)


# ------------------------------------------------------------
# 8. CREATE CUSTOMER-LEVEL RFM FEATURES
# ------------------------------------------------------------

customer_data <- retail_clean %>%

  group_by(CustomerID) %>%

  summarise(

    # Recency
    Recency =
      as.numeric(
        difftime(
          max_date,
          max(InvoiceDate),
          units = "days"
        )
      ),

    # Frequency
    Frequency =
      n_distinct(InvoiceNo),

    # Monetary Value
    Monetary =
      sum(TotalAmount),

    # Average Transaction Value
    AvgTransactionValue =
      mean(TotalAmount),

    # Total Quantity Purchased
    TotalQuantity =
      sum(Quantity),

    # Purchase Frequency
    PurchaseFrequency =
      n_distinct(InvoiceNo)

  ) %>%

  ungroup()


cat("\n============================================\n")
cat("CUSTOMER-LEVEL FEATURES CREATED\n")
cat("============================================\n")

cat(
  "Number of customers:",
  nrow(customer_data),
  "\n"
)

print(head(customer_data))


# ------------------------------------------------------------
# 9. CUSTOMER FEATURE SUMMARY
# ------------------------------------------------------------

cat("\n============================================\n")
cat("CUSTOMER FEATURE SUMMARY\n")
cat("============================================\n")

print(summary(customer_data))


# ------------------------------------------------------------
# 10. OUTLIER TREATMENT
# ------------------------------------------------------------
# Instead of deleting customers repeatedly,
# extreme values are capped using IQR.


cap_outliers <- function(x) {

  Q1 <- quantile(
    x,
    0.25,
    na.rm = TRUE
  )

  Q3 <- quantile(
    x,
    0.75,
    na.rm = TRUE
  )

  IQR_value <- Q3 - Q1

  lower <-
    Q1 - 1.5 * IQR_value

  upper <-
    Q3 + 1.5 * IQR_value

  x[x < lower] <- lower

  x[x > upper] <- upper

  return(x)
}


customer_clean <- customer_data


customer_clean$Recency <-
  cap_outliers(
    customer_clean$Recency
  )

customer_clean$Frequency <-
  cap_outliers(
    customer_clean$Frequency
  )

customer_clean$Monetary <-
  cap_outliers(
    customer_clean$Monetary
  )

customer_clean$AvgTransactionValue <-
  cap_outliers(
    customer_clean$AvgTransactionValue
  )

customer_clean$TotalQuantity <-
  cap_outliers(
    customer_clean$TotalQuantity
  )

customer_clean$PurchaseFrequency <-
  cap_outliers(
    customer_clean$PurchaseFrequency
  )


cat("\n============================================\n")
cat("OUTLIER TREATMENT COMPLETED\n")
cat("============================================\n")

cat(
  "Customers remaining:",
  nrow(customer_clean),
  "\n"
)


# ------------------------------------------------------------
# 11. SELECT FEATURES FOR CLUSTERING
# ------------------------------------------------------------

cluster_features <-
  customer_clean %>%

  select(
    Recency,
    Frequency,
    Monetary,
    AvgTransactionValue,
    TotalQuantity,
    PurchaseFrequency
  )


# ------------------------------------------------------------
# 12. LOG TRANSFORMATION
# ------------------------------------------------------------
# Helps reduce skew in RFM variables.

cluster_features_log <-

  as.data.frame(
    lapply(
      cluster_features,
      function(x) log1p(x)
    )
  )


# ------------------------------------------------------------
# 13. STANDARDIZE FEATURES
# ------------------------------------------------------------

scaled_features <-
  scale(
    cluster_features_log
  )

scaled_features <-
  as.data.frame(
    scaled_features
  )


# ------------------------------------------------------------
# 14. CHECK DATA BEFORE CLUSTERING
# ------------------------------------------------------------

cat("\n============================================\n")
cat("DATA CHECK BEFORE K-MEANS\n")
cat("============================================\n")

cat(
  "Number of customers:",
  nrow(scaled_features),
  "\n"
)

cat(
  "Number of features:",
  ncol(scaled_features),
  "\n"
)

cat(
  "Unique customer rows:",
  nrow(unique(scaled_features)),
  "\n"
)

cat("\nFeature standard deviations:\n")

print(
  sapply(
    scaled_features,
    sd
  )
)

cat("\nNA values:\n")

print(
  colSums(
    is.na(
      scaled_features
    )
  )
)


# ------------------------------------------------------------
# 15. ELBOW METHOD
# ------------------------------------------------------------

cat("\n============================================\n")
cat("ELBOW METHOD\n")
cat("============================================\n")

set.seed(123)

wss <- numeric(10)


for (k in 1:10) {

  km <- kmeans(
    scaled_features,
    centers = k,
    nstart = 25
  )

  wss[k] <-
    km$tot.withinss
}


cat("\nWSS VALUES:\n")

print(wss)


# ------------------------------------------------------------
# 16. ELBOW GRAPH
# ------------------------------------------------------------

plot(
  1:10,
  wss,
  type = "b",
  pch = 19,
  lwd = 2,
  xlab = "Number of Clusters (K)",
  ylab = "Within-Cluster Sum of Squares",
  main = "Elbow Method"
)


cat("\n============================================\n")
cat("ELBOW METHOD COMPLETED\n")
cat("============================================\n")

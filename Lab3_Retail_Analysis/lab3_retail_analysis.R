# ============================================================
# LAB 3: MULTI-SOURCE RETAIL SALES DATA INTEGRATION & ANALYSIS
# Domain: Retail Analytics
# ============================================================


# ============================================================
# 0. LOAD REQUIRED PACKAGES
# ============================================================

library(tidyverse)
library(jsonlite)
library(readxl)
library(writexl)
library(DBI)
library(RSQLite)


# ============================================================
# 1. SET WORKING DIRECTORY
# ============================================================

# If the current directory contains the Lab3_Retail_Analysis
# folder, enter that folder.

if (
  !file.exists("Online Retail.xlsx") &&
  dir.exists("Lab3_Retail_Analysis")
) {
  setwd("Lab3_Retail_Analysis")
}


# Check working directory
cat("\nCurrent working directory:\n")
print(getwd())


# Check files
cat("\nFiles in current directory:\n")
print(list.files())


# Stop immediately if Excel file cannot be found
if (!file.exists("Online Retail.xlsx")) {

  stop(
    paste(
      "\nERROR: Online Retail.xlsx was not found.\n",
      "Make sure Online Retail.xlsx is inside the Lab3_Retail_Analysis folder."
    )
  )

}


# ============================================================
# 2. LOAD ORIGINAL UCI ONLINE RETAIL DATASET
# ============================================================

cat("\n========================================\n")
cat("LOADING ORIGINAL DATASET\n")
cat("========================================\n")


retail <- read_excel(
  "Online Retail.xlsx"
)


cat("\nDataset loaded successfully.\n")


cat("\nDataset dimensions:\n")
print(dim(retail))


cat("\nFirst 6 rows:\n")
print(head(retail))


cat("\nDataset structure:\n")
str(retail)


# ============================================================
# 3. CREATE REQUIRED SOURCE DATASETS
# ============================================================

cat("\n========================================\n")
cat("CREATING THREE SOURCE DATASETS\n")
cat("========================================\n")


# ------------------------------------------------------------
# 3.1 TRANSACTIONS CSV
# ------------------------------------------------------------

transactions_source <- retail %>%

  select(
    InvoiceNo,
    StockCode,
    CustomerID,
    Quantity,
    InvoiceDate
  )


write_csv(
  transactions_source,
  "transactions.csv"
)


cat("\ntransactions.csv created.\n")


# ------------------------------------------------------------
# 3.2 PRODUCTS JSON
# ------------------------------------------------------------

products_source <- retail %>%

  select(
    StockCode,
    Description,
    UnitPrice
  ) %>%

  filter(
    !is.na(StockCode)
  ) %>%

  group_by(
    StockCode
  ) %>%

  summarise(

    Description =
      if (
        all(is.na(Description))
      ) {
        NA_character_
      } else {
        first(na.omit(Description))
      },

    UnitPrice =
      if (
        all(is.na(UnitPrice))
      ) {
        NA_real_
      } else {
        median(
          UnitPrice,
          na.rm = TRUE
        )
      },

    .groups = "drop"
  )


write_json(
  products_source,
  "products.json",
  pretty = TRUE,
  auto_unbox = TRUE
)


cat("products.json created.\n")


# ------------------------------------------------------------
# 3.3 CUSTOMERS EXCEL
# ------------------------------------------------------------

customers_source <- retail %>%

  select(
    CustomerID,
    Country
  ) %>%

  filter(
    !is.na(CustomerID)
  ) %>%

  group_by(
    CustomerID
  ) %>%

  summarise(

    Country =
      if (
        all(is.na(Country))
      ) {
        NA_character_
      } else {
        first(na.omit(Country))
      },

    .groups = "drop"
  )


write_xlsx(
  customers_source,
  "customers.xlsx"
)


cat("customers.xlsx created.\n")


# ============================================================
# 4. VERIFY SOURCE FILES
# ============================================================

cat("\n========================================\n")
cat("VERIFYING SOURCE FILES\n")
cat("========================================\n")


source_files <- c(
  "transactions.csv",
  "products.json",
  "customers.xlsx"
)


source_check <- data.frame(
  File = source_files,
  Exists = file.exists(source_files)
)


print(source_check)


if (!all(source_check$Exists)) {

  stop(
    "\nERROR: One or more source files were not created."
  )

}


cat("\nAll three source files created successfully.\n")


# ============================================================
# TASK 1
# IMPORT AND CLEAN DATA
# ============================================================

cat("\n========================================\n")
cat("TASK 1: IMPORT AND CLEAN DATA\n")
cat("========================================\n")


# ============================================================
# 5. IMPORT CSV
# ============================================================

transactions <- read_csv(
  "transactions.csv",
  show_col_types = FALSE
)


cat("\nTransactions imported from CSV.\n")

print(head(transactions))


# ============================================================
# 6. IMPORT JSON
# ============================================================

products <- fromJSON(
  "products.json"
)


cat("\nProducts imported from JSON.\n")

print(head(products))


# ============================================================
# 7. IMPORT EXCEL
# ============================================================

customers <- read_excel(
  "customers.xlsx"
)


cat("\nCustomers imported from Excel.\n")

print(head(customers))


# ============================================================
# 8. INITIAL DATASET DIMENSIONS
# ============================================================

cat("\n----------------------------------------\n")
cat("INITIAL DATASET DIMENSIONS\n")
cat("----------------------------------------\n")


cat("\nTransactions:\n")
print(dim(transactions))


cat("\nProducts:\n")
print(dim(products))


cat("\nCustomers:\n")
print(dim(customers))


# ============================================================
# 9. CHECK MISSING VALUES
# ============================================================

cat("\n----------------------------------------\n")
cat("MISSING VALUES\n")
cat("----------------------------------------\n")


cat("\nTransactions:\n")
print(colSums(is.na(transactions)))


cat("\nProducts:\n")
print(colSums(is.na(products)))


cat("\nCustomers:\n")
print(colSums(is.na(customers)))


# ============================================================
# 10. CHECK DUPLICATES
# ============================================================

cat("\n----------------------------------------\n")
cat("DUPLICATES\n")
cat("----------------------------------------\n")


cat(
  "\nTransaction duplicates:",
  sum(duplicated(transactions)),
  "\n"
)


cat(
  "Product duplicates:",
  sum(duplicated(products)),
  "\n"
)


cat(
  "Customer duplicates:",
  sum(duplicated(customers)),
  "\n"
)


# ============================================================
# 11. REMOVE DUPLICATES
# ============================================================

transactions <- transactions %>%
  distinct()


products <- products %>%
  distinct(
    StockCode,
    .keep_all = TRUE
  )


customers <- customers %>%
  distinct(
    CustomerID,
    .keep_all = TRUE
  )


# ============================================================
# 12. REMOVE MISSING CUSTOMER IDs
# ============================================================

missing_customer_count <- sum(
  is.na(transactions$CustomerID)
)


cat(
  "\nTransactions removed due to missing CustomerID:",
  missing_customer_count,
  "\n"
)


transactions <- transactions %>%

  filter(
    !is.na(CustomerID)
  )


# ============================================================
# 13. REMOVE INVALID QUANTITIES
# ============================================================

invalid_quantity_count <- sum(
  transactions$Quantity <= 0,
  na.rm = TRUE
)


cat(
  "Transactions with Quantity <= 0:",
  invalid_quantity_count,
  "\n"
)


transactions <- transactions %>%

  filter(
    Quantity > 0
  )


# ============================================================
# 14. REMOVE INVALID PRICES
# ============================================================

invalid_price_count <- sum(
  products$UnitPrice <= 0,
  na.rm = TRUE
)


cat(
  "Products with UnitPrice <= 0:",
  invalid_price_count,
  "\n"
)


products <- products %>%

  filter(
    !is.na(UnitPrice),
    UnitPrice > 0
  )


# ============================================================
# 15. FINAL CLEAN DATASET DIMENSIONS
# ============================================================

cat("\n----------------------------------------\n")
cat("FINAL CLEAN DATASET DIMENSIONS\n")
cat("----------------------------------------\n")


cat("\nTransactions:\n")
print(dim(transactions))


cat("\nProducts:\n")
print(dim(products))


cat("\nCustomers:\n")
print(dim(customers))


# ============================================================
# CLEANING DECISIONS
# ============================================================

cat("\n========================================\n")
cat("CLEANING DECISIONS\n")
cat("========================================\n")


cat("

1. Duplicate records were removed to prevent double counting.

2. Transactions with missing CustomerID were removed because
   customer-level analysis requires valid customer identifiers.

3. Transactions with Quantity <= 0 were removed because the
   analysis focuses on positive sales transactions.

4. Products with missing or non-positive UnitPrice were removed
   because they cannot represent valid sales prices.

5. Missing values were inspected before integration.

6. Product records were reduced to one record per StockCode to
   prevent duplicate transaction rows during integration.

")


# ============================================================
# TASK 2
# INTEGRATE MULTIPLE DATA SOURCES
# ============================================================

cat("\n========================================\n")
cat("TASK 2: INTEGRATE MULTIPLE DATA SOURCES\n")
cat("========================================\n")


# ============================================================
# 16. CHECK UNMATCHED PRODUCTS
# ============================================================

unmatched_products <- transactions %>%

  anti_join(
    products,
    by = "StockCode"
  )


cat(
  "\nUnmatched transaction records for products:",
  nrow(unmatched_products),
  "\n"
)


# ============================================================
# 17. CHECK UNMATCHED CUSTOMERS
# ============================================================

unmatched_customers <- transactions %>%

  anti_join(
    customers,
    by = "CustomerID"
  )


cat(
  "Unmatched transaction records for customers:",
  nrow(unmatched_customers),
  "\n"
)


# ============================================================
# 18. JOIN TRANSACTIONS + PRODUCTS
# ============================================================

sales_data <- transactions %>%

  left_join(
    products,
    by = "StockCode"
  )


# ============================================================
# 19. JOIN CUSTOMERS
# ============================================================

sales_data <- sales_data %>%

  left_join(
    customers,
    by = "CustomerID"
  )


# ============================================================
# 20. CREATE REVENUE
# ============================================================

sales_data <- sales_data %>%

  mutate(
    Revenue = Quantity * UnitPrice
  )


# ============================================================
# 21. VERIFY INTEGRATED DATASET
# ============================================================

cat("\n----------------------------------------\n")
cat("FINAL INTEGRATED DATASET\n")
cat("----------------------------------------\n")


cat("\nDimensions:\n")

print(
  dim(sales_data)
)


cat("\nFirst 10 rows:\n")

print(
  head(
    sales_data,
    10
  )
)


# ============================================================
# 22. CHECK MISSING VALUES AFTER JOIN
# ============================================================

cat("\nMissing values after integration:\n")

print(
  colSums(
    is.na(sales_data)
  )
)


# ============================================================
# JOIN JUSTIFICATION
# ============================================================

cat("\n========================================\n")
cat("JOIN JUSTIFICATION\n")
cat("========================================\n")


cat("

A left_join() was selected because all valid transaction
records should be retained while product and customer
information is matched wherever available.

This allows unmatched records to be identified without
unnecessarily removing valid transactions.

")


# ============================================================
# TASK 3
# SALES AND CUSTOMER ANALYSIS
# ============================================================

cat("\n========================================\n")
cat("TASK 3: SALES AND CUSTOMER ANALYSIS\n")
cat("========================================\n")


# ============================================================
# 23. TOTAL SALES REVENUE
# ============================================================

total_revenue <- sales_data %>%

  summarise(
    Total_Revenue =
      sum(
        Revenue,
        na.rm = TRUE
      )
  )


cat("\n========================================\n")
cat("TOTAL SALES REVENUE\n")
cat("========================================\n")


print(total_revenue)


# ============================================================
# 24. TOP 5 PRODUCTS
# ============================================================

top_5_products <- sales_data %>%

  group_by(
    StockCode,
    Description
  ) %>%

  summarise(
    Revenue =
      sum(
        Revenue,
        na.rm = TRUE
      ),

    .groups = "drop"
  ) %>%

  arrange(
    desc(Revenue)
  ) %>%

  slice_head(
    n = 5
  )


cat("\n========================================\n")
cat("TOP 5 PRODUCTS BY REVENUE\n")
cat("========================================\n")


print(top_5_products)


# ============================================================
# 25. TOP 5 COUNTRIES
# ============================================================

top_5_countries <- sales_data %>%

  group_by(
    Country
  ) %>%

  summarise(
    Revenue =
      sum(
        Revenue,
        na.rm = TRUE
      ),

    .groups = "drop"
  ) %>%

  arrange(
    desc(Revenue)
  ) %>%

  slice_head(
    n = 5
  )


cat("\n========================================\n")
cat("TOP 5 COUNTRIES BY REVENUE\n")
cat("========================================\n")


print(top_5_countries)


# ============================================================
# 26. TOP 5 CUSTOMERS
# ============================================================

top_5_customers <- sales_data %>%

  group_by(
    CustomerID
  ) %>%

  summarise(
    Total_Purchase_Value =
      sum(
        Revenue,
        na.rm = TRUE
      ),

    .groups = "drop"
  ) %>%

  arrange(
    desc(Total_Purchase_Value)
  ) %>%

  slice_head(
    n = 5
  )


cat("\n========================================\n")
cat("TOP 5 CUSTOMERS BY PURCHASE VALUE\n")
cat("========================================\n")


print(top_5_customers)


# ============================================================
# 27. CUSTOMER VALUE CLASSIFICATION
# ============================================================

customer_value <- sales_data %>%

  group_by(
    CustomerID
  ) %>%

  summarise(
    Total_Purchase_Value =
      sum(
        Revenue,
        na.rm = TRUE
      ),

    .groups = "drop"
  )


# ============================================================
# 28. CALCULATE QUARTILE THRESHOLDS
# ============================================================

q1 <- quantile(
  customer_value$Total_Purchase_Value,
  0.25,
  na.rm = TRUE
)


q2 <- quantile(
  customer_value$Total_Purchase_Value,
  0.50,
  na.rm = TRUE
)


q3 <- quantile(
  customer_value$Total_Purchase_Value,
  0.75,
  na.rm = TRUE
)


cat("\n========================================\n")
cat("CUSTOMER VALUE THRESHOLDS\n")
cat("========================================\n")


cat(
  "\nQ1:",
  round(q1, 2),
  "\n"
)


cat(
  "Q2:",
  round(q2, 2),
  "\n"
)


cat(
  "Q3:",
  round(q3, 2),
  "\n"
)


# ============================================================
# 29. CLASSIFY CUSTOMERS USING case_when()
# ============================================================

customer_value <- customer_value %>%

  mutate(

    Customer_Category = case_when(

      Total_Purchase_Value <= q1 ~
        "Low Value",

      Total_Purchase_Value <= q2 ~
        "Medium Value",

      Total_Purchase_Value <= q3 ~
        "High Value",

      TRUE ~
        "Premium"

    )

  )


cat("\n========================================\n")
cat("CUSTOMER CATEGORY COUNTS\n")
cat("========================================\n")


customer_category_counts <- customer_value %>%

  count(
    Customer_Category
  )


print(
  customer_category_counts
)


# ============================================================
# 30. MARKET PERFORMANCE
# ============================================================

market_performance <- sales_data %>%

  group_by(
    Country
  ) %>%

  summarise(
    Revenue =
      sum(
        Revenue,
        na.rm = TRUE
      ),

    .groups = "drop"
  ) %>%

  filter(
    !is.na(Country)
  ) %>%

  filter(
    Revenue > 0
  ) %>%

  arrange(
    desc(Revenue)
  )


# ============================================================
# 31. HIGH-PERFORMING MARKET
# ============================================================

high_performing_market <- market_performance %>%

  slice_head(
    n = 1
  )


# ============================================================
# 32. UNDERPERFORMING MARKET
# ============================================================

underperforming_market <- market_performance %>%

  slice_tail(
    n = 1
  )


cat("\n========================================\n")
cat("MARKET PERFORMANCE\n")
cat("========================================\n")


cat("\nHigh-performing market:\n")

print(
  high_performing_market
)


cat("\nUnderperforming market:\n")

print(
  underperforming_market
)


# ============================================================
# 33. MARKET INTERPRETATION
# ============================================================

cat("\n========================================\n")
cat("MARKET INTERPRETATION\n")
cat("========================================\n")


cat(
  "\nThe high-performing market is ",
  high_performing_market$Country,
  " because it generated the highest revenue of ",
  round(
    high_performing_market$Revenue,
    2
  ),
  ".\n",
  sep = ""
)


cat(
  "The underperforming market is ",
  underperforming_market$Country,
  " because it generated the lowest revenue of ",
  round(
    underperforming_market$Revenue,
    2
  ),
  ".\n",
  sep = ""
)


# ============================================================
# TASK 4
# SQLITE DATABASE AND SQL QUERIES
# ============================================================

cat("\n========================================\n")
cat("TASK 4: SQLITE DATABASE\n")
cat("========================================\n")


# ============================================================
# 34. CREATE SQLITE DATABASE
# ============================================================

con <- dbConnect(
  RSQLite::SQLite(),
  "retail_sales.db"
)


cat("\nSQLite database connection created.\n")


# ============================================================
# 35. STORE FINAL DATASET
# ============================================================

dbWriteTable(
  con,
  "retail_sales",
  sales_data,
  overwrite = TRUE
)


cat(
  "retail_sales table created successfully.\n"
)


# ============================================================
# 36. VERIFY DATABASE
# ============================================================

cat("\nDatabase tables:\n")

print(
  dbListTables(con)
)


cat("\nretail_sales table fields:\n")

print(
  dbListFields(
    con,
    "retail_sales"
  )
)


# ============================================================
# 37. SQL QUERY 1
# TOP 5 CUSTOMERS
# ============================================================

sql_query_1 <- "

SELECT
    CustomerID,
    SUM(Revenue) AS TotalRevenue

FROM retail_sales

GROUP BY CustomerID

ORDER BY TotalRevenue DESC

LIMIT 5;

"


top_5_customers_sql <- dbGetQuery(
  con,
  sql_query_1
)


cat("\n========================================\n")
cat("SQL QUERY 1: TOP 5 CUSTOMERS\n")
cat("========================================\n")


print(
  top_5_customers_sql
)


# ============================================================
# 38. SQL QUERY 2
# REVENUE BY COUNTRY
# ============================================================

sql_query_2 <- "

SELECT
    Country,
    SUM(Revenue) AS TotalRevenue

FROM retail_sales

GROUP BY Country

ORDER BY TotalRevenue DESC;

"


revenue_by_country_sql <- dbGetQuery(
  con,
  sql_query_2
)


cat("\n========================================\n")
cat("SQL QUERY 2: REVENUE BY COUNTRY\n")
cat("========================================\n")


print(
  head(
    revenue_by_country_sql,
    10
  )
)


# ============================================================
# 39. VERIFY DATABASE RECORD COUNT
# ============================================================

database_count <- dbGetQuery(
  con,
  "
  SELECT COUNT(*) AS TotalRecords
  FROM retail_sales;
  "
)


cat("\n========================================\n")
cat("DATABASE RECORD COUNT\n")
cat("========================================\n")


print(
  database_count
)


# ============================================================
# 40. CLOSE DATABASE
# ============================================================

dbDisconnect(
  con
)


cat("\nSQLite connection closed.\n")


# ============================================================
# THREE BUSINESS INSIGHTS
# ============================================================

cat("\n========================================\n")
cat("THREE BUSINESS INSIGHTS\n")
cat("========================================\n")


# ============================================================
# INSIGHT 1
# ============================================================

cat(
  "\n1. Revenue Insight:\n",
  "The total revenue generated by the cleaned and integrated ",
  "dataset is ",
  round(
    total_revenue$Total_Revenue,
    2
  ),
  ". This represents the overall sales value after cleaning ",
  "invalid records.\n",
  sep = ""
)


# ============================================================
# INSIGHT 2
# ============================================================

cat(
  "\n2. Product Insight:\n",
  "The highest-revenue product is '",
  top_5_products$Description[1],
  "' with revenue of ",
  round(
    top_5_products$Revenue[1],
    2
  ),
  ". This product is an important contributor to total sales.\n",
  sep = ""
)


# ============================================================
# INSIGHT 3
# ============================================================

cat(
  "\n3. Market Insight:\n",
  high_performing_market$Country,
  " is the highest-performing market with revenue of ",
  round(
    high_performing_market$Revenue,
    2
  ),
  ", while ",
  underperforming_market$Country,
  " has the lowest revenue among the analyzed markets. ",
  "This indicates differences in sales performance across ",
  "countries.\n",
  sep = ""
)


# ============================================================
# FINAL FILE CHECK
# ============================================================

cat("\n========================================\n")
cat("FINAL OUTPUT FILE CHECK\n")
cat("========================================\n")


output_files <- c(
  "transactions.csv",
  "products.json",
  "customers.xlsx",
  "retail_sales.db"
)


final_check <- data.frame(
  File = output_files,
  Exists = file.exists(output_files)
)


print(
  final_check
)


# ============================================================
# FINAL STATUS
# ============================================================

if (all(final_check$Exists)) {

  cat("\n========================================\n")
  cat("LAB 3 COMPLETED SUCCESSFULLY!\n")
  cat("========================================\n")

} else {

  cat("\n========================================\n")
  cat("LAB 3 DID NOT COMPLETE.\n")
  cat("Check the errors above.\n")
  cat("========================================\n")

}

library(rmarkdown)
library(knitr)
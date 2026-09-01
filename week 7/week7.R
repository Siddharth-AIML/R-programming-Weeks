# ============================================================
# WEEK 7 - R PROGRAMMING
# Sequences, Repeats, Sorting, Ordering and Lists
# ============================================================


# ============================================================
# 1. SEQUENCES
# ============================================================

cat("========================================\n")
cat("1. SEQUENCES\n")
cat("========================================\n\n")


# Simple sequence
cat("Sequence from 1 to 10:\n")
print(1:10)


# Reverse sequence
cat("\nReverse sequence from 10 to 1:\n")
print(10:1)


# Sequence with seq()
cat("\nSequence using seq():\n")
print(seq(from = 1, to = 10))


# Sequence with increment 2
cat("\nSequence with increment 2:\n")
print(seq(from = 2, to = 20, by = 2))


# Sequence with decrement
cat("\nSequence with decrement -2:\n")
print(seq(from = 10, to = -10, by = -2))


# Fractional increment
cat("\nSequence with fractional increment:\n")
print(seq(from = 1, to = 5, by = 0.5))


# ============================================================
# 2. PREDEFINED LENGTH SEQUENCES
# ============================================================

cat("\n========================================\n")
cat("2. PREDEFINED LENGTH SEQUENCES\n")
cat("========================================\n\n")


# length.out
cat("10 values between 1 and 5:\n")
print(
  seq(
    from = 1,
    to = 5,
    length.out = 10
  )
)


# predefined length with decrement
cat("\n10 values starting from 10 with decrement 2:\n")
print(
  seq(
    from = 10,
    length.out = 10,
    by = -2
  )
)


# fractional decrement
cat("\n5 values with fractional decrement:\n")
print(
  seq(
    from = 10,
    length.out = 5,
    by = -0.2
  )
)


# ============================================================
# 3. SEQUENCE USING A VARIABLE
# ============================================================

cat("\n========================================\n")
cat("3. SEQUENCE USING VARIABLE\n")
cat("========================================\n\n")


x <- 50

cat("Sequence from 0 to x with increment x/10:\n")

print(
  seq(
    from = 0,
    to = x,
    by = x / 10
  )
)


# Store sequence in a variable

numbers <- seq(
  from = 1,
  to = 10,
  by = 1
)

cat("\nStored sequence:\n")
print(numbers)


# ============================================================
# 4. INDEX VECTOR
# ============================================================

cat("\n========================================\n")
cat("4. INDEX VECTOR\n")
cat("========================================\n\n")


x <- c(9, 8, 7, 6)

cat("Original vector:\n")
print(x)


ind <- seq(along = x)

cat("\nIndex vector:\n")
print(ind)


cat("\nSecond element using index vector:\n")
print(x[ind[2]])


# ============================================================
# 5. SEQUENCES OF ALPHABETS
# ============================================================

cat("\n========================================\n")
cat("5. SEQUENCES OF ALPHABETS\n")
cat("========================================\n\n")


cat("Lowercase alphabets:\n")
print(letters)


cat("\nFirst three lowercase alphabets:\n")
print(letters[1:3])


cat("\nLowercase alphabets from 3 to 1:\n")
print(letters[3:1])


cat("\nUppercase alphabets:\n")
print(LETTERS)


cat("\nFirst three uppercase alphabets:\n")
print(LETTERS[1:3])


cat("\nUppercase alphabets from 3 to 1:\n")
print(LETTERS[3:1])


# ============================================================
# 6. SEQUENCES OF DATES
# ============================================================

cat("\n========================================\n")
cat("6. SEQUENCES OF DATES\n")
cat("========================================\n\n")


# Daily sequence

cat("Daily date sequence:\n")

dates_days <- seq(
  as.Date("2026-01-01"),
  by = "days",
  length.out = 6
)

print(dates_days)


# Weekly sequence

cat("\nWeekly date sequence:\n")

dates_weeks <- seq(
  as.Date("2026-01-01"),
  by = "weeks",
  length.out = 6
)

print(dates_weeks)


# Monthly sequence

cat("\nMonthly date sequence:\n")

dates_months <- seq(
  as.Date("2026-01-01"),
  by = "months",
  length.out = 6
)

print(dates_months)


# Yearly sequence

cat("\nYearly date sequence:\n")

dates_years <- seq(
  as.Date("2026-01-01"),
  by = "years",
  length.out = 6
)

print(dates_years)


# Current date and time

cat("\nCurrent date:\n")
print(Sys.Date())


cat("\nCurrent date and time:\n")
print(Sys.time())


# ============================================================
# 7. REPEATS - rep()
# ============================================================

cat("\n========================================\n")
cat("7. REPEATS USING rep()\n")
cat("========================================\n\n")


x <- c(1, 2, 3)


# Repeat complete vector

cat("Repeat complete vector 3 times:\n")

print(
  rep(
    x,
    times = 3
  )
)


# Repeat each element

cat("\nRepeat each element 3 times:\n")

print(
  rep(
    x,
    each = 3
  )
)


# Repeat with length.out

cat("\nRepeat until output length becomes 10:\n")

print(
  rep(
    x,
    length.out = 10
  )
)


# Repeat characters

cat("\nRepeat characters:\n")

print(
  rep(
    c("Plane", "Car"),
    times = 3
  )
)


# ============================================================
# 8. SORTING
# ============================================================

cat("\n========================================\n")
cat("8. SORTING\n")
cat("========================================\n\n")


y <- c(8, 5, 7, 6, 9)

cat("Original vector:\n")
print(y)


# Ascending

cat("\nAscending order:\n")
print(
  sort(y)
)


# Descending

cat("\nDescending order:\n")
print(
  sort(
    y,
    decreasing = TRUE
  )
)


# Sorting characters

names <- c(
  "Siddharth",
  "Rahul",
  "Amit",
  "Priya"
)

cat("\nOriginal names:\n")
print(names)


cat("\nSorted names:\n")
print(
  sort(names)
)


# ============================================================
# 9. ORDERING
# ============================================================

cat("\n========================================\n")
cat("9. ORDERING\n")
cat("========================================\n\n")


y <- c(9, 8, 5, 7, 6)

cat("Original vector:\n")
print(y)


cat("\nPositions that give ascending order:\n")

print(
  order(y)
)


cat("\nValues in ascending order using order():\n")

print(
  y[order(y)]
)


cat("\nPositions that give descending order:\n")

print(
  order(
    y,
    decreasing = TRUE
  )
)


cat("\nValues in descending order:\n")

print(
  y[
    order(
      y,
      decreasing = TRUE
    )
  ]
)


# ============================================================
# 10. SORTING A DATA FRAME USING order()
# ============================================================

cat("\n========================================\n")
cat("10. SORTING DATA FRAME USING order()\n")
cat("========================================\n\n")


students <- data.frame(
  Name = c(
    "Amit",
    "Rahul",
    "Siddharth",
    "Priya",
    "Neha"
  ),
  
  Marks = c(
    75,
    92,
    85,
    68,
    90
  )
)


cat("Original student data:\n")
print(students)


cat("\nStudents ordered by marks:\n")

students_ordered <- students[
  order(students$Marks),
]

print(students_ordered)


cat("\nStudents ordered by marks in descending order:\n")

students_ordered_desc <- students[
  order(
    students$Marks,
    decreasing = TRUE
  ),
]

print(students_ordered_desc)


# ============================================================
# 11. LISTS
# ============================================================

cat("\n========================================\n")
cat("11. LISTS\n")
cat("========================================\n\n")


# Lists can contain different types of objects

student <- list(
  
  name = "Siddharth",
  
  age = 21,
  
  marks = c(
    85,
    90,
    88
  ),
  
  passed = TRUE
)


cat("Complete list:\n")
print(student)


# ============================================================
# 12. ACCESSING LIST ELEMENTS
# ============================================================

cat("\n========================================\n")
cat("12. ACCESSING LIST ELEMENTS\n")
cat("========================================\n\n")


cat("First list element using [[ ]]:\n")

print(
  student[[1]]
)


cat("\nName using [[ ]]:\n")

print(
  student[["name"]]
)


cat("\nName using $ operator:\n")

print(
  student$name
)


cat("\nMarks:\n")

print(
  student$marks
)


cat("\nSecond mark:\n")

print(
  student$marks[2]
)


# ============================================================
# 13. LIST CONTAINING MATRICES
# ============================================================

cat("\n========================================\n")
cat("13. LIST CONTAINING MATRICES\n")
cat("========================================\n\n")


x1 <- matrix(
  data = 1:4,
  nrow = 2,
  ncol = 2,
  byrow = TRUE
)


x2 <- matrix(
  data = 5:8,
  nrow = 2,
  ncol = 2,
  byrow = TRUE
)


matlist <- list(
  x1,
  x2
)


cat("Matrix 1:\n")
print(
  matlist[[1]]
)


cat("\nMatrix 2:\n")
print(
  matlist[[2]]
)


cat("\nAdding both matrices:\n")

print(
  matlist[[1]] +
    matlist[[2]]
)


# ============================================================
# 14. LIST WITH DIFFERENT DATA TYPES
# ============================================================


cat("\n========================================\n")
cat("14. LIST WITH DIFFERENT DATA TYPES\n")
cat("========================================\n\n")


z1 <- list(
  
  c(
    "water",
    "juice",
    "lemonade"
  ),
  
  rep(
    1:4,
    each = 2
  ),
  
  matrix(
    data = 5:8,
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)


cat("Complete list:\n")
print(z1)


cat("\nFirst element of list:\n")
print(
  z1[[1]]
)


cat("\nExtracting 'juice':\n")

print(
  z1[[1]][2]
)


# ============================================================
# 15. SUBLIST
# ============================================================

cat("\n========================================\n")
cat("15. SUBLIST\n")
cat("========================================\n\n")


cat("Second and third elements as a sublist:\n")

print(
  z1[c(2, 3)]
)


# ============================================================
# 16. SUMMARY
# ============================================================

cat("\n========================================\n")
cat("WEEK 7 SUMMARY\n")
cat("========================================\n\n")


cat("Topics successfully demonstrated:\n")

cat("1. Basic sequences\n")
cat("2. seq() function\n")
cat("3. Increment and decrement\n")
cat("4. length.out\n")
cat("5. Index vectors\n")
cat("6. Alphabet sequences\n")
cat("7. Date sequences\n")
cat("8. Sys.Date() and Sys.time()\n")
cat("9. rep() function\n")
cat("10. Sorting using sort()\n")
cat("11. Ordering using order()\n")
cat("12. Sorting data frames\n")
cat("13. Lists\n")
cat("14. Accessing list elements\n")
cat("15. Lists containing matrices\n")
cat("16. Sublists\n")


cat("\n========================================\n")
cat("WEEK 7 R PROGRAMMING COMPLETED!\n")
cat("========================================\n")
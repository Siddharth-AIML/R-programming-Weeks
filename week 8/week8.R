# ============================================================
# R PROGRAMMING - OPERATIONS ON LISTS
# NPTEL WEEK 7 & WEEK 8
# ============================================================


# ============================================================
# 1. CREATING BASIC LISTS
# ============================================================

list1 <- list(1, 2, 3)

list2 <- list(
  "water",
  "juice",
  "lemonade"
)

cat("\n================ BASIC LISTS ================\n")

print(list1)
print(list2)


# ============================================================
# 2. MERGING LISTS
# ============================================================
# From NPTEL Week 8:
# list12 = c(list1, list2)

cat("\n================ MERGING LISTS ================\n")

list12 <- c(list1, list2)

print(list12)


# ============================================================
# 3. APPENDING TO A LIST
# ============================================================
# append() is used to add an element at the end.

cat("\n================ APPENDING LIST ================\n")

list1 <- list(1, 2, 3)

list2 <- list(
  "water",
  "juice",
  "lemonade"
)

list1_append <- append(list1, 100)

list2_append <- append(list2, "coffee")

cat("\nlist1 after appending 100:\n")
print(list1_append)

cat("\nlist2 after appending coffee:\n")
print(list2_append)


# ============================================================
# 4. APPENDING AFTER A PARTICULAR POSITION
# ============================================================
# append(x, value, after = position)

cat("\n================ APPENDING AFTER POSITION ================\n")

list1 <- list(1, 2, 3)

list2 <- list(
  "water",
  "juice",
  "lemonade"
)

list1_after <- append(
  list1,
  100,
  after = 2
)

list2_after <- append(
  list2,
  "coffee",
  after = 2
)

cat("\nAdd 100 after position 2:\n")
print(list1_after)

cat("\nAdd coffee after position 2:\n")
print(list2_after)


# ============================================================
# 5. REMOVING AN ELEMENT FROM A LIST
# ============================================================
# Negative indexing removes an element.

cat("\n================ REMOVING FROM LIST ================\n")

list1 <- list(1, 2, 3)

list2 <- list(
  "water",
  "juice",
  "lemonade"
)

cat("\nOriginal list1:\n")
print(list1)

cat("\nRemoving element at position 2:\n")
print(list1[-2])


cat("\nOriginal list2:\n")
print(list2)

cat("\nRemoving element at position 1:\n")
print(list2[-1])


# ============================================================
# 6. EXTRACTING ELEMENTS FROM A LIST
# ============================================================
# Use [ ] to extract multiple list elements.

cat("\n================ EXTRACTING FROM LIST ================\n")

list1 <- list(1, 2, 3, 4, 5, 6)

list2 <- list(
  "water",
  "juice",
  "lemonade",
  "tea",
  "coffee",
  "milk"
)

cat("\nOriginal list1:\n")
print(list1)


# Extract positions 2 to 4
cat("\nlist1[2:4]:\n")
print(list1[2:4])


# Extract positions 1, 3 and 5
cat("\nlist1[c(1,3,5)]:\n")
print(list1[c(1, 3, 5)])


cat("\nOriginal list2:\n")
print(list2)


# Extract positions 2 to 4
cat("\nlist2[2:4]:\n")
print(list2[2:4])


# Extract positions 1, 3 and 5
cat("\nlist2[c(1,3,5)]:\n")
print(list2[c(1, 3, 5)])


# ============================================================
# 7. ACCESSING AN ELEMENT USING [[ ]]
# ============================================================
# [[]] extracts the actual object from a list.

cat("\n================ ACCESSING LIST ELEMENTS ================\n")

z1 <- list(
  c("water", "juice", "lemonade"),
  rep(1:4, each = 2),
  matrix(
    data = 5:8,
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

cat("\nComplete z1 list:\n")
print(z1)


# Access first object
cat("\nz1[[1]]:\n")
print(z1[[1]])


# Access "juice"
cat("\nz1[[1]][2]:\n")
print(z1[[1]][2])


# IMPORTANT DIFFERENCE
cat("\nz1[1][2]:\n")
print(z1[1][2])

cat("\nNotice that z1[[1]][2] gives 'juice',\n")
cat("while z1[1][2] does not access the second element\n")
cat("inside the first list element.\n")


# ============================================================
# 8. LIST CONTAINING DIFFERENT OBJECT TYPES
# ============================================================
# A list can contain different types of objects.

cat("\n================ DIFFERENT OBJECT TYPES ================\n")

z1 <- list(
  c("water", "juice", "lemonade"),
  rep(1:4, each = 2),
  matrix(
    data = 5:8,
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

print(z1)


# Access individual objects

cat("\nFirst object - character vector:\n")
print(z1[[1]])

cat("\nSecond object - numeric vector:\n")
print(z1[[2]])

cat("\nThird object - matrix:\n")
print(z1[[3]])


# ============================================================
# 9. MATRICES INSIDE LISTS
# ============================================================

cat("\n================ MATRICES INSIDE LISTS ================\n")

x1 <- matrix(
  nrow = 2,
  ncol = 2,
  data = 1:4,
  byrow = TRUE
)

x2 <- matrix(
  nrow = 2,
  ncol = 2,
  data = 5:8,
  byrow = TRUE
)

cat("\nMatrix x1:\n")
print(x1)

cat("\nMatrix x2:\n")
print(x2)


# Create a list containing matrices

matlist <- list(x1, x2)

cat("\nList containing two matrices:\n")
print(matlist)


# Access first matrix

cat("\nmatlist[1]:\n")
print(matlist[1])


# Access second matrix

cat("\nmatlist[2]:\n")
print(matlist[2])


# Access actual first matrix using [[ ]]

cat("\nmatlist[[1]]:\n")
print(matlist[[1]])


# Access actual second matrix using [[ ]]

cat("\nmatlist[[2]]:\n")
print(matlist[[2]])


# ============================================================
# 10. CONVERTING LIST TO VECTOR
# ============================================================
# unlist() converts a list into a vector.

cat("\n================ LIST TO VECTOR ================\n")

list1 <- list(1, 2, 3)

list2 <- list(
  "water",
  "juice",
  "lemonade"
)

cat("\nOriginal numeric list:\n")
print(list1)

cat("\nUnlisted numeric vector:\n")
print(unlist(list1))


cat("\nOriginal character list:\n")
print(list2)

cat("\nUnlisted character vector:\n")
print(unlist(list2))


# ============================================================
# 11. MODE OF LIST AND UNLISTED VECTOR
# ============================================================

cat("\n================ MODE ================\n")

cat("\nMode of list1:\n")
print(mode(list1))

numeric_vector <- unlist(list1)

cat("\nMode after unlist():\n")
print(mode(numeric_vector))


# ============================================================
# 12. NESTED LIST
# ============================================================
# A list can also contain another list.

cat("\n================ NESTED LIST ================\n")

nested_list <- list(
  numbers = list(10, 20, 30),
  drinks = list(
    "water",
    "juice",
    "coffee"
  )
)

print(nested_list)


# Access nested list

cat("\nFirst nested list:\n")
print(nested_list[[1]])


cat("\nSecond nested list:\n")
print(nested_list[[2]])


# Access coffee

cat("\nAccess coffee:\n")
print(nested_list[[2]][[3]])


# ============================================================
# 13. NAMED LIST
# ============================================================
# Lists can have names.

cat("\n================ NAMED LIST ================\n")

z <- list(
  a1 = 1,
  a2 = "c",
  a3 = 1:3
)

cat("\nNamed list:\n")
print(z)


# Display names

cat("\nNames of list:\n")
print(names(z))


# ============================================================
# 14. ACCESS NAMED LIST ELEMENTS
# ============================================================

cat("\n================ ACCESS NAMED ELEMENTS ================\n")

cat("\nz$a1:\n")
print(z$a1)

cat("\nz$a2:\n")
print(z$a2)

cat("\nz$a3:\n")
print(z$a3)


# Access using [[name]]

cat("\nz[['a1']]:\n")
print(z[["a1"]])

cat("\nz[['a2']]:\n")
print(z[["a2"]])

cat("\nz[['a3']]:\n")
print(z[["a3"]])


# ============================================================
# 15. CHANGING NAME OF A LIST ELEMENT
# ============================================================

cat("\n================ CHANGING LIST NAME ================\n")

z <- list(
  a1 = 1,
  a2 = "c",
  a3 = 1:3
)

cat("\nOriginal names:\n")
print(names(z))


# Change third name

names(z)[3] <- "c2"

cat("\nNames after changing third element:\n")
print(names(z))

cat("\nUpdated list:\n")
print(z)


# ============================================================
# 16. MODIFYING LIST ELEMENT
# ============================================================

cat("\n================ MODIFYING LIST ELEMENT ================\n")

mylist <- list(
  10,
  20,
  30
)

cat("\nOriginal list:\n")
print(mylist)


# Modify second element

mylist[[2]] <- 200

cat("\nAfter changing second element to 200:\n")
print(mylist)


# ============================================================
# 17. ADDING A NEW NAMED ELEMENT
# ============================================================

cat("\n================ ADDING NAMED ELEMENT ================\n")

student <- list(
  name = "Siddharth",
  age = 21
)

cat("\nOriginal student list:\n")
print(student)


student$branch <- "Computer Engineering"

cat("\nAfter adding branch:\n")
print(student)


# ============================================================
# 18. REMOVING NAMED ELEMENT
# ============================================================

cat("\n================ REMOVING NAMED ELEMENT ================\n")

student <- list(
  name = "Siddharth",
  age = 21,
  branch = "Computer Engineering"
)

cat("\nOriginal student list:\n")
print(student)


student$age <- NULL

cat("\nAfter removing age:\n")
print(student)


# ============================================================
# 19. LENGTH OF A LIST
# ============================================================

cat("\n================ LENGTH OF LIST ================\n")

mylist <- list(
  10,
  "R",
  TRUE,
  20:25
)

cat("\nList:\n")
print(mylist)

cat("\nLength of list:\n")
print(length(mylist))


# ============================================================
# 20. CHECK LIST STRUCTURE
# ============================================================

cat("\n================ STRUCTURE OF LIST ================\n")

mylist <- list(
  numbers = 1:5,
  name = "R Programming",
  matrix = matrix(1:4, nrow = 2)
)

str(mylist)


# ============================================================
# 21. CHECK MODE AND CLASS
# ============================================================

cat("\n================ MODE AND CLASS ================\n")

mylist <- list(
  10,
  "R",
  TRUE
)

cat("\nMode:\n")
print(mode(mylist))

cat("\nClass:\n")
print(class(mylist))


# ============================================================
# 22. COMPLETE DEMONSTRATION
# ============================================================

cat("\n============================================================\n")
cat("COMPLETE LIST OPERATIONS DEMONSTRATION FINISHED\n")
cat("============================================================\n")


# ============================================================
# R PROGRAMMING - WEEK 8
# FACTORS
# Based on NPTEL Week 8 Notes
# ============================================================


# ============================================================
# 1. BASIC FACTOR
# ============================================================

cat("\n============================================================\n")
cat("1. BASIC FACTOR\n")
cat("============================================================\n")

x <- c("Male", "Female", "Male", "Female", "Male")

cat("\nOriginal character vector:\n")
print(x)

y <- factor(x)

cat("\nFactor:\n")
print(y)

cat("\nLevels:\n")
print(levels(y))


# ============================================================
# 2. FACTOR WITH NUMERIC VALUES
# ============================================================

cat("\n============================================================\n")
cat("2. FACTOR WITH NUMERIC VALUES\n")
cat("============================================================\n")

x <- c(3, 4, 5, 6, 1, 2, 3, 3, 4, 4, 5, 6)

cat("\nOriginal vector:\n")
print(x)

y <- as.factor(x)

cat("\nFactor:\n")
print(y)

cat("\nLevels:\n")
print(levels(y))


# ============================================================
# 3. FACTOR WITH CHARACTER VALUES
# ============================================================

cat("\n============================================================\n")
cat("3. CHARACTER FACTOR\n")
cat("============================================================\n")

x <- factor(
  c(
    "lemonade",
    "lemonade",
    "juice",
    "lemonade",
    "water"
  )
)

cat("\nFactor:\n")
print(x)

cat("\nLevels:\n")
print(levels(x))

# By default, character levels are arranged alphabetically.


# ============================================================
# 4. FACTOR WITH CUSTOM LEVEL ORDER
# ============================================================

cat("\n============================================================\n")
cat("4. CUSTOM LEVEL ORDER\n")
cat("============================================================\n")

x <- factor(
  c(
    "lemonade",
    "lemonade",
    "juice",
    "lemonade",
    "water"
  ),
  levels = c("water", "juice", "lemonade")
)

cat("\nFactor with custom levels:\n")
print(x)

cat("\nCustom levels:\n")
print(levels(x))


# ============================================================
# 5. DIE ROLL EXAMPLE
# ============================================================

cat("\n============================================================\n")
cat("5. DIE ROLL FACTOR EXAMPLE\n")
cat("============================================================\n")

# Die rolled seven times

y <- c(1, 4, 3, 5, 4, 2, 4)

cat("\nObserved die outcomes:\n")
print(y)

# Possible values of die face

possible.dieface <- c(1, 2, 3, 4, 5, 6)

cat("\nPossible die faces:\n")
print(possible.dieface)

# Labels for die faces

labels.dieface <- c(
  "one",
  "two",
  "three",
  "four",
  "five",
  "six"
)

cat("\nLabels:\n")
print(labels.dieface)

# Create factor

facy <- factor(
  y,
  levels = possible.dieface,
  labels = labels.dieface
)

cat("\nFactor with labels:\n")
print(facy)

cat("\nLevels:\n")
print(levels(facy))


# ============================================================
# 6. DIFFERENCE BETWEEN VECTOR AND FACTOR
# ============================================================

cat("\n============================================================\n")
cat("6. VECTOR VS FACTOR\n")
cat("============================================================\n")

y <- c(1, 4, 3, 5, 4, 2, 4)

facy <- factor(
  y,
  levels = 1:6,
  labels = c(
    "one",
    "two",
    "three",
    "four",
    "five",
    "six"
  )
)

cat("\nOriginal numeric vector:\n")
print(y)

cat("\nFactor:\n")
print(facy)

cat("\nClass of numeric vector:\n")
print(class(y))

cat("\nClass of factor:\n")
print(class(facy))


# ============================================================
# 7. CLASS FUNCTION
# ============================================================

cat("\n============================================================\n")
cat("7. CLASS FUNCTION\n")
cat("============================================================\n")

cat("\nClass of number 9:\n")
print(class(9))

cat("\nClass of character '9':\n")
print(class("9"))

cat("\nClass of function print:\n")
print(class(print))

x <- matrix(
  nrow = 2,
  ncol = 2,
  data = 1:4
)

cat("\nMatrix:\n")
print(x)

cat("\nClass of matrix:\n")
print(class(x))


# ============================================================
# 8. UNCLASS FUNCTION
# ============================================================

cat("\n============================================================\n")
cat("8. UNCLASS FUNCTION\n")
cat("============================================================\n")

brands <- c(
  "A",
  "A",
  "B",
  "B",
  "B",
  "B",
  "C"
)

cat("\nOriginal brands:\n")
print(brands)

brands_fac <- factor(brands)

cat("\nFactor brands:\n")
print(brands_fac)

cat("\nLevels:\n")
print(levels(brands_fac))

cat("\nUnclass factor:\n")
print(unclass(brands_fac))


# ============================================================
# 9. USING UNCLASS CODES WITH ANOTHER VECTOR
# ============================================================

cat("\n============================================================\n")
cat("9. USING UNCLASS CODES\n")
cat("============================================================\n")

brands <- c(
  "A",
  "A",
  "B",
  "B",
  "B",
  "B",
  "C"
)

brands_fac <- factor(brands)

colours <- c(
  "blue",
  "green",
  "red"
)

cat("\nBrands factor:\n")
print(brands_fac)

cat("\nNumeric codes:\n")
print(unclass(brands_fac))

cat("\nColours selected using factor codes:\n")
print(colours[unclass(brands_fac)])


# ============================================================
# 10. UNCLASS WITH LEMONADE EXAMPLE
# ============================================================

cat("\n============================================================\n")
cat("10. UNCLASS WITH LEMONADE EXAMPLE\n")
cat("============================================================\n")

x <- factor(
  c(
    "lemonade",
    "lemonade",
    "juice",
    "lemonade",
    "water"
  )
)

cat("\nFactor:\n")
print(x)

cat("\nUnclass factor:\n")
print(unclass(x))

cat("\nLevels:\n")
print(levels(x))


# ============================================================
# 11. CUSTOM LEVELS AND UNCLASS
# ============================================================

cat("\n============================================================\n")
cat("11. CUSTOM LEVELS + UNCLASS\n")
cat("============================================================\n")

x <- factor(
  c(
    "lemonade",
    "lemonade",
    "juice",
    "lemonade",
    "water"
  ),
  levels = c(
    "water",
    "juice",
    "lemonade"
  )
)

cat("\nFactor:\n")
print(x)

cat("\nCustom levels:\n")
print(levels(x))

cat("\nInternal numeric codes:\n")
print(unclass(x))


# ============================================================
# 12. ORDERED FACTOR
# ============================================================

cat("\n============================================================\n")
cat("12. ORDERED FACTOR\n")
cat("============================================================\n")

income <- ordered(
  c(
    "high",
    "high",
    "low",
    "medium",
    "medium"
  ),
  levels = c(
    "low",
    "medium",
    "high"
  )
)

cat("\nOrdered factor:\n")
print(income)

cat("\nLevels:\n")
print(levels(income))

cat("\nInternal numeric codes:\n")
print(unclass(income))


# ============================================================
# 13. COMPARISON OF ORDERED FACTOR
# ============================================================

cat("\n============================================================\n")
cat("13. ORDERED FACTOR COMPARISON\n")
cat("============================================================\n")

income <- ordered(
  c(
    "high",
    "low",
    "medium",
    "high"
  ),
  levels = c(
    "low",
    "medium",
    "high"
  )
)

cat("\nIncome:\n")
print(income)

cat("\nIs high greater than low?\n")
print(income[1] > income[2])

cat("\nIs low less than medium?\n")
print(income[2] < income[3])


# ============================================================
# 14. LEVELS FUNCTION
# ============================================================

cat("\n============================================================\n")
cat("14. LEVELS FUNCTION\n")
cat("============================================================\n")

fruits <- factor(
  c(
    "Apple",
    "Banana",
    "Apple",
    "Orange",
    "Banana"
  )
)

cat("\nFruit factor:\n")
print(fruits)

cat("\nCurrent levels:\n")
print(levels(fruits))


# ============================================================
# 15. CHANGING LEVEL LABELS
# ============================================================

cat("\n============================================================\n")
cat("15. CHANGING LEVEL LABELS\n")
cat("============================================================\n")

x <- factor(
  c(
    "A",
    "B",
    "A",
    "C",
    "B"
  )
)

cat("\nOriginal factor:\n")
print(x)

cat("\nOriginal levels:\n")
print(levels(x))

levels(x) <- c(
  "Excellent",
  "Good",
  "Average"
)

cat("\nFactor after changing labels:\n")
print(x)

cat("\nNew levels:\n")
print(levels(x))


# ============================================================
# 16. FACTOR FOR GENDER
# ============================================================

cat("\n============================================================\n")
cat("16. GENDER CATEGORICAL VARIABLE\n")
cat("============================================================\n")

gender <- factor(
  c(
    "Male",
    "Female",
    "Male",
    "Female",
    "Male"
  )
)

cat("\nGender factor:\n")
print(gender)

cat("\nGender levels:\n")
print(levels(gender))

cat("\nGender class:\n")
print(class(gender))

cat("\nGender internal codes:\n")
print(unclass(gender))


# ============================================================
# 17. FACTOR FOR PERFORMANCE
# ============================================================

cat("\n============================================================\n")
cat("17. PERFORMANCE FACTOR\n")
cat("============================================================\n")

performance <- factor(
  c(
    "Excellent",
    "Good",
    "Average",
    "Good",
    "Excellent",
    "Bad"
  )
)

cat("\nPerformance factor:\n")
print(performance)

cat("\nPerformance levels:\n")
print(levels(performance))


# ============================================================
# 18. ORDERED PERFORMANCE FACTOR
# ============================================================

cat("\n============================================================\n")
cat("18. ORDERED PERFORMANCE FACTOR\n")
cat("============================================================\n")

performance <- ordered(
  c(
    "Excellent",
    "Good",
    "Average",
    "Good",
    "Excellent",
    "Bad"
  ),
  levels = c(
    "Bad",
    "Average",
    "Good",
    "Excellent"
  )
)

cat("\nOrdered performance:\n")
print(performance)

cat("\nPerformance levels:\n")
print(levels(performance))

cat("\nInternal codes:\n")
print(unclass(performance))


# ============================================================
# 19. FACTOR WITH EXPLICIT LEVELS
# ============================================================

cat("\n============================================================\n")
cat("19. EXPLICIT LEVELS\n")
cat("============================================================\n")

x <- c(
  "Red",
  "Blue",
  "Red",
  "Green"
)

colour_factor <- factor(
  x,
  levels = c(
    "Red",
    "Blue",
    "Green",
    "Yellow"
  )
)

cat("\nOriginal vector:\n")
print(x)

cat("\nFactor:\n")
print(colour_factor)

cat("\nAll specified levels:\n")
print(levels(colour_factor))


# ============================================================
# 20. FACTOR SUMMARY\n
# ============================================================

cat("\n============================================================\n")
cat("20. FACTOR SUMMARY\n")
cat("============================================================\n")

student_gender <- factor(
  c(
    "Male",
    "Female",
    "Female",
    "Male",
    "Male"
  )
)

cat("\nStudent gender:\n")
print(student_gender)

cat("\nLevels:\n")
print(levels(student_gender))

cat("\nClass:\n")
print(class(student_gender))

cat("\nInternal codes:\n")
print(unclass(student_gender))

cat("\nNumber of levels:\n")
print(nlevels(student_gender))


# ============================================================
# FINAL MESSAGE
# ============================================================

cat("\n============================================================\n")
cat("ALL FACTOR EXAMPLES COMPLETED SUCCESSFULLY\n")
cat("===========================================================\n")
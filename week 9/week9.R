# ============================================================
# WEEK 9 - STRINGS: DISPLAY AND FORMATTING
# NPTEL R PROGRAMMING
# LECTURE 36, 37, 38 AND 39
# ============================================================


# ============================================================
# LECTURE 36
# PRINT AND CAT FUNCTION
# ============================================================


# ------------------------------------------------------------
# 1. PRINT FUNCTION
# ------------------------------------------------------------

print("Hello R")

x <- 10
print(x)

name <- "Siddharth"
print(name)


# ------------------------------------------------------------
# 2. PRINT MULTIPLE ITEMS
# ------------------------------------------------------------

# print() can print only one object at a time.

# The following gives an error:
# print("The zero occurs at", 2*pi, "radians.")


# Therefore print them one by one

print("The zero occurs at")
print(2*pi)
print("radians")


# OUTPUT:
# [1] "The zero occurs at"
# [1] 6.283185
# [1] "radians"


# ------------------------------------------------------------
# 3. CAT FUNCTION
# ------------------------------------------------------------

cat(
  "The zero occurs at",
  2*pi,
  "radians.",
  "\n"
)

# OUTPUT:
# The zero occurs at 6.283185 radians.


# cat() can combine multiple items
# into continuous output.


# ------------------------------------------------------------
# 4. CAT WITH VARIABLES
# ------------------------------------------------------------

x <- 7

cat(
  "The square of",
  x,
  "is",
  x^2,
  "!\n"
)

# OUTPUT:
# The square of 7 is 49 !


# ------------------------------------------------------------
# 5. CAT WITH format()
# ------------------------------------------------------------

cat(
  "The square root of",
  x,
  "is approximately",
  format(sqrt(x), digits = 3),
  "\n"
)

# OUTPUT:
# The square root of 7 is approximately 2.65


# ------------------------------------------------------------
# 6. CAT AND NEW LINE
# ------------------------------------------------------------

cat("First line\n")
cat("Second line\n")
cat("Third line\n")

# OUTPUT:
# First line
# Second line
# Third line


# ------------------------------------------------------------
# 7. CAT WITH sep
# ------------------------------------------------------------

x <- 1:10

cat(x, sep = " ++ ")
cat("\n")

# OUTPUT:
# 1 ++ 2 ++ 3 ++ 4 ++ 5 ++
# 6 ++ 7 ++ 8 ++ 9 ++ 10


cat(x, sep = " / ")
cat("\n")

# OUTPUT:
# 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 10


# ------------------------------------------------------------
# 8. CAT WITH VECTOR
# ------------------------------------------------------------

evenno <- c(2,4,6,8,10)

cat(
  "The first few even numbers are:",
  evenno,
  "...\n"
)

# OUTPUT:
# The first few even numbers are: 2 4 6 8 10 ...


# ------------------------------------------------------------
# 9. CAT WITH fill AND labels
# ------------------------------------------------------------

x <- 1:10

cat(
  x,
  fill = 2,
  labels = paste("(", letters[1:10], "):")
)

# OUTPUT:
# ( a ): 1
# ( b ): 2
# ( c ): 3
# ...
# ( j ): 10


# ------------------------------------------------------------
# 10. CAT WITH DATE
# ------------------------------------------------------------

d <- date()

cat(
  "Today's date is:",
  d,
  "\n"
)

# OUTPUT will contain the current date.
# Example:
# Today's date is: Tue Sep 22 14:20:00 2026


# ============================================================
# LECTURE 37
# PASTE FUNCTION
# ============================================================


# ------------------------------------------------------------
# 11. BASIC paste()
# ------------------------------------------------------------

paste(
  "Everybody",
  "loves",
  "R Programming."
)

# OUTPUT:
# [1] "Everybody loves R Programming."


# ------------------------------------------------------------
# 12. STORE paste() RESULT
# ------------------------------------------------------------

result <- paste(
  "Everybody",
  "loves",
  "R Programming."
)

print(result)

# OUTPUT:
# [1] "Everybody loves R Programming."


# ------------------------------------------------------------
# 13. paste() WITH sep
# ------------------------------------------------------------

paste(
  "Everybody",
  "loves",
  "R Programming.",
  sep = "*"
)

# OUTPUT:
# [1] "Everybody*loves*R Programming."


paste(
  "Everybody",
  "loves",
  "R Programming.",
  sep = "==="
)

# OUTPUT:
# [1] "Everybody===loves===R Programming."


# ------------------------------------------------------------
# 14. paste() WITH NUMBERS
# ------------------------------------------------------------

paste(1:12)

# OUTPUT:
# [1] "1"  "2"  "3"  "4"  "5"  "6"
# [7] "7"  "8"  "9"  "10" "11" "12"


# Alternative

as.character(1:12)

# OUTPUT is the same character vector.


# ------------------------------------------------------------
# 15. paste() WITH VECTOR
# ------------------------------------------------------------

names <- c(
  "Prof. Singh",
  "Mr. Venkat",
  "Dr. Jha"
)

names


paste(
  names,
  "is",
  "a good",
  "person."
)

# OUTPUT:
# [1] "Prof. Singh is a good person."
# [2] "Mr. Venkat is a good person."
# [3] "Dr. Jha is a good person."


# ------------------------------------------------------------
# 16. paste() WITH collapse
# ------------------------------------------------------------

paste(
  names,
  "is",
  "a good",
  "person.",
  collapse = ", and "
)

# OUTPUT:
# [1] "Prof. Singh is a good person., and
# Mr. Venkat is a good person., and
# Dr. Jha is a good person."


# ------------------------------------------------------------
# 17. paste() WITH sep AND collapse
# ------------------------------------------------------------

x <- paste(
  "Ex",
  1:5,
  sep = "_"
)

x

# OUTPUT:
# [1] "Ex_1" "Ex_2" "Ex_3" "Ex_4" "Ex_5"


# Now use collapse

x <- paste(
  "Ex",
  1:5,
  sep = "_",
  collapse = ""
)

x

# OUTPUT:
# [1] "Ex_1Ex_2Ex_3Ex_4Ex_5"


# ------------------------------------------------------------
# 18. ACCESS paste() ELEMENTS
# ------------------------------------------------------------

x <- paste(
  "Ex",
  1:5,
  sep = "_"
)

x[1]
x[2]
x[3]
x[4]
x[5]

# OUTPUT:
# [1] "Ex_1"
# [1] "Ex_2"
# [1] "Ex_3"
# [1] "Ex_4"
# [1] "Ex_5"


# ------------------------------------------------------------
# 19. paste() AND BLANK SPACES
# ------------------------------------------------------------

paste(
  1,
  " is first",
  2,
  " is second",
  3,
  " is third",
  sep = "#"
)

# OUTPUT:
# [1] "1# is first#2# is second#3# is third"


paste(
  1,
  " is first ",
  2,
  " is second ",
  3,
  " is third ",
  sep = "#"
)

# Notice the extra spaces inside the strings.


# ============================================================
# LECTURE 37
# paste0()
# ============================================================


# ------------------------------------------------------------
# 20. paste0()
# ------------------------------------------------------------

paste0(1:10)

# OUTPUT:
# [1] "1" "2" "3" "4" "5"
# [6] "6" "7" "8" "9" "10"


paste(1:10)

# Output is also the same for a single vector.


# ------------------------------------------------------------
# 21. paste0() WITH TWO VECTORS
# ------------------------------------------------------------

paste0(
  1:10,
  c("st", "nd", "rd", rep("th", 7))
)

# OUTPUT:
# [1] "1st"  "2nd"  "3rd"  "4th"  "5th"
# [6] "6th"  "7th"  "8th"  "9th"  "10th"


# Compare with paste()

paste(
  1:10,
  c("st", "nd", "rd", rep("th", 7))
)

# OUTPUT:
# [1] "1 st"  "2 nd"  "3 rd"  "4 th"  "5 th"
# [6] "6 th"  "7 th"  "8 th"  "9 th"  "10 th"


# ============================================================
# LECTURE 38
# STRING SPLITTING
# ============================================================


# ------------------------------------------------------------
# 22. strsplit()
# ------------------------------------------------------------

x <- "The&!syntax&!of&!paste&!is!&available!&inthe online-help"

x


# Split using !

strsplit(
  x,
  split = "!"
)

# Output is a list containing the split strings.


# ------------------------------------------------------------
# 23. strsplit() USING &!
# ------------------------------------------------------------

x <- "The&!syntax&!of&!paste&!is!&available!&inthe online-help"

strsplit(
  x,
  split = "&!"
)

# OUTPUT:
# [[1]]
# [1] "The"
# [2] "syntax"
# [3] "of"
# [4] "paste"
# [5] "is!&available! &inthe online-help"


# ------------------------------------------------------------
# 24. STORE strsplit() RESULT
# ------------------------------------------------------------

x <- "The&!syntax&!of&!paste&!is!&available!&inthe online-help"

y <- strsplit(
  x,
  split = "!&"
)

y


# ------------------------------------------------------------
# 25. ACCESS strsplit() ELEMENTS
# ------------------------------------------------------------

y[[1]]

y[[1]][1]

y[[1]][2]

y[[1]][3]

# Important:
# y[[1]] accesses the first element of the list.
# [1], [2], [3] then access elements of that character vector.


# ------------------------------------------------------------
# 26. SPLIT DATES
# ------------------------------------------------------------

dates <- c(
  "2020-07-24",
  "2021-08-25",
  "2022-09-26",
  "2023-10-27"
)

dates


datesplt <- strsplit(
  dates,
  "-"
)

datesplt


# OUTPUT:
# [[1]]
# [1] "2020" "07" "24"
#
# [[2]]
# [1] "2021" "08" "25"
#
# [[3]]
# [1] "2022" "09" "26"
#
# [[4]]
# [1] "2023" "10" "27"


# ------------------------------------------------------------
# 27. CONVERT SPLIT DATES TO CHARACTER MATRIX
# ------------------------------------------------------------

datemat <- matrix(
  unlist(datesplt),
  nrow = 4,
  ncol = 3,
  byrow = TRUE
)

datemat

# OUTPUT:
#      [,1]   [,2] [,3]
# [1,] "2020" "07" "24"
# [2,] "2021" "08" "25"
# [3,] "2022" "09" "26"
# [4,] "2023" "10" "27"


# ------------------------------------------------------------
# 28. CONVERT TO NUMERIC MATRIX
# ------------------------------------------------------------

datematrix <- matrix(
  as.numeric(unlist(datesplt)),
  nrow = 4,
  ncol = 3,
  byrow = TRUE
)

datematrix

# OUTPUT:
#      [,1] [,2] [,3]
# [1,] 2020    7   24
# [2,] 2021    8   25
# [3,] 2022    9   26
# [4,] 2023   10   27


# ------------------------------------------------------------
# 29. SPLIT WORD CHARACTER BY CHARACTER
# ------------------------------------------------------------

strsplit(
  "Shalabh",
  split = ""
)

# OUTPUT:
# [[1]]
# [1] "S" "h" "a" "l" "a" "b" "h"


# Another example

strsplit(
  "Siddharth",
  split = ""
)


# ============================================================
# LECTURE 39
# STRING MANIPULATION
# ============================================================


# ------------------------------------------------------------
# 30. nchar()
# ------------------------------------------------------------

x <- "R course 24.07.2022"

y <- "Number of participants: 25"

nchar(x)

# OUTPUT:
# [1] 19

nchar(y)

# OUTPUT:
# [1] 26


# ------------------------------------------------------------
# 31. nchar() WITH VECTOR
# ------------------------------------------------------------

x <- c(
  "Apple",
  "Banana",
  "Cake"
)

nchar(x)

# OUTPUT:
# [1] 5 6 4


# ------------------------------------------------------------
# 32. nchar() WITH NUMBERS
# ------------------------------------------------------------

y <- c(2, 4, 6)

nchar(y)

# OUTPUT:
# [1] 1 1 1


z <- c(11, 222, 3333)

nchar(z)

# OUTPUT:
# [1] 2 3 4


z1 <- c(1.1, 2.22, 3.333)

nchar(z1)

# Output depends on the character representation,
# but demonstrates that nchar() can also be applied
# to numeric values.


# ------------------------------------------------------------
# 33. nzchar()
# ------------------------------------------------------------

x <- "R course 24.07.2022"

y <- "Number of participants: 25"

nzchar(x)

# OUTPUT:
# [1] TRUE

nzchar(y)

# OUTPUT:
# [1] TRUE


# ------------------------------------------------------------
# 34. nzchar() WITH VECTOR
# ------------------------------------------------------------

x <- c(
  "Apple",
  "Banana",
  "Cake"
)

nzchar(x)

# OUTPUT:
# [1] TRUE TRUE TRUE


# ------------------------------------------------------------
# 35. nzchar() WITH EMPTY STRING
# ------------------------------------------------------------

y <- c(
  "Apple",
  "",
  "Cake"
)

y

nzchar(y)

# OUTPUT:
# [1] TRUE FALSE TRUE


# TRUE  = non-empty string
# FALSE = empty string


# ------------------------------------------------------------
# 36. toupper()
# ------------------------------------------------------------

x <- "R course will start from 24.07.2022"

toupper(x)

# OUTPUT:
# [1] "R COURSE WILL START FROM 24.07.2022"


# ------------------------------------------------------------
# 37. tolower()
# ------------------------------------------------------------

z <- "INDIAN INSTITUTE OF TECHNOLOGY"

tolower(z)

# OUTPUT:
# [1] "indian institute of technology"


# ------------------------------------------------------------
# 38. toupper() WITH VECTOR
# ------------------------------------------------------------

x <- c(
  "apple",
  "banana",
  "cake"
)

toupper(x)

# OUTPUT:
# [1] "APPLE"  "BANANA" "CAKE"


# ------------------------------------------------------------
# 39. tolower() WITH VECTOR
# ------------------------------------------------------------

x <- c(
  "APPLE",
  "BANANA",
  "CAKE"
)

tolower(x)

# OUTPUT:
# [1] "apple"  "banana" "cake"


# ============================================================
# IMPORTANT CONCEPT SUMMARY
# ============================================================

# print()
# -> Prints objects one at a time.

# cat()
# -> Combines and prints multiple objects.

# paste()
# -> Combines strings and RETURNS the result.

# paste0()
# -> Same as paste() with sep = "".

# sep
# -> Separates input elements.

# collapse
# -> Combines resulting vector into one string.

# strsplit()
# -> Splits strings into pieces.

# nchar()
# -> Counts number of characters.

# nzchar()
# -> Checks whether a string is non-empty.

# toupper()
# -> Converts characters to uppercase.

# tolower()
# -> Converts characters to lowercase.


# ============================================================
# WEEK 9 COMPLETED
# ============================================================

cat("\n")
cat("============================================================\n")
cat("WEEK 9 COMPLETED SUCCESSFULLY\n")
cat("Strings - Display and Formatting\n")
cat("============================================================\n")
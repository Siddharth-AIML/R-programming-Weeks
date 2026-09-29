
# ============================================================
# R PROGRAMMING - NPTEL WEEK 10
# Topics: String Replacement, Searching, Data Frames,
#         Data Frame Operations, Combining and Merging
# ============================================================

cat("\n========== WEEK 10: R PROGRAMMING ==========\n")


# ============================================================
# PART 1: STRINGS - SUBSTITUTION AND REPLACEMENT
# ============================================================

cat("\n========== PART 1: sub() and gsub() ==========\n")

# Example 1: Replace the first occurrence using sub()

y <- "Number of participants: 25"

print(y)
print(sub("25", "30", y))


# Example 2: Replace only the first occurrence

y <- "Mr. Singh is the smart one. Mr. Singh is funny, too."

print(y)

result_sub <- sub("Mr. Singh", "Professor Jha", y)
print(result_sub)


# Example 3: Replace all occurrences using gsub()

result_gsub <- gsub("Mr. Singh", "Professor Jha", y)
print(result_gsub)


# Example 4: Difference between sub() and gsub()

text1 <- "R is easy. R is useful. R is popular."

cat("\nOriginal string:\n")
print(text1)

cat("\nUsing sub():\n")
print(sub("R", "Python", text1))

cat("\nUsing gsub():\n")
print(gsub("R", "Python", text1))


# ============================================================
# PART 2: SEARCHING STRINGS USING grep()
# ============================================================

cat("\n========== PART 2: grep() ==========\n")

# Example 5: Create a character vector

str_text <- c(
  "R Course",
  "exercises",
  "include examples of R language"
)

print(str_text)


# Example 6: Return matching strings using value = TRUE

print(grep("ex", str_text, value = TRUE))


# Example 7: Return positions of matching strings

print(grep("ex", str_text, value = FALSE))


# Example 8: Case-sensitive searching

str_text2 <- c(
  "R Course",
  "exercises",
  "include examples of r language",
  "in R software"
)

cat("\nCase-sensitive search:\n")
print(grep("R", str_text2, ignore.case = FALSE, value = TRUE))


# Example 9: Case-insensitive searching

cat("\nCase-insensitive search:\n")
print(grep("R", str_text2, ignore.case = TRUE, value = TRUE))


# Example 10: Search for a word in two strings

x <- "R course 24.07.2022"
y <- "Number of participants: 50"

print(c(x, y))

cat("\nPosition containing 'our':\n")
print(grep("our", c(x, y)))

cat("\nPosition containing 'Num':\n")
print(grep("Num", c(x, y)))


# ============================================================
# PART 3: SEARCHING STRINGS USING grepl()
# ============================================================

cat("\n========== PART 3: grepl() ==========\n")

# Example 11: grepl() returns TRUE or FALSE

str_text <- c(
  "R Course",
  "exercises",
  "include examples of R language"
)

print(grepl("R", str_text))

# Example 12: Search for "ex"

print(grepl("ex", str_text))


# Example 13: Case-insensitive matching with grepl()

print(grepl("r", str_text, ignore.case = TRUE))


# Example 14: Compare grep() and grepl()

cat("\nMatching positions using grep():\n")
print(grep("R", str_text))

cat("\nLogical results using grepl():\n")
print(grepl("R", str_text))


# ============================================================
# PART 4: DATA FRAMES
# ============================================================

cat("\n========== PART 4: DATA FRAMES ==========\n")

# Example 15: Create a data frame

student_data <- data.frame(
  Name = c("Amit", "Neha", "Rahul", "Priya", "Siddharth"),
  Age = c(20, 21, 20, 22, 21),
  Marks = c(85, 92, 76, 88, 95),
  Department = c("Computer", "IT", "Computer", "IT", "Computer")
)

cat("\nStudent data frame:\n")
print(student_data)


# Example 16: Display the structure of a data frame

str(student_data)


# Example 17: Display column names

print(colnames(student_data))


# Example 18: Access a column using $

print(student_data$Name)
print(student_data$Marks)


# Example 19: Check whether a column is numeric

print(is.numeric(student_data$Marks))
print(is.numeric(student_data$Name))


# Example 20: Check whether a column is a factor

print(is.factor(student_data$Department))


# Example 21: Summary of the data frame

print(summary(student_data))


# Example 22: Summary of a numeric column

print(summary(student_data$Marks))


# Example 23: Summary of a categorical column

print(summary(as.factor(student_data$Department)))


# ============================================================
# PART 5: USING THE painters DATA FRAME
# ============================================================

cat("\n========== PART 5: painters DATA FRAME ==========\n")

# The painters data set is available in the MASS package.

library(MASS)

# Example 24: Display the painters data

print(painters)


# Example 25: Display row names

print(rownames(painters))


# Example 26: Display column names

print(colnames(painters))


# Example 27: Check column data types

print(is.numeric(painters$Drawing))
print(is.factor(painters$School))


# Example 28: Summary of painters

print(summary(painters))


# Example 29: Frequency table of School

print(summary(painters$School))


# ============================================================
# PART 6: attach() AND detach()
# ============================================================

cat("\n========== PART 6: attach() and detach() ==========\n")

# Example 30: Attach the painters data frame

attach(painters)

# Access columns directly without painters$

print(summary(School))
print(summary(Composition))

# Detach the data frame after use

detach(painters)

# After detach(), use painters$ to access columns.

print(summary(painters$Composition))


# ============================================================
# PART 7: SUBSETTING DATA FRAMES
# ============================================================

cat("\n========== PART 7: subset() ==========\n")

# Example 31: Select painters belonging to School F

print(subset(painters, School == "F"))


# Example 32: Select painters with Composition <= 6

print(subset(painters, Composition <= 6))


# Example 33: Select School F and remove columns 3 and 5

# Column 3 = Colour
# Column 5 = School

print(
  subset(
    painters,
    School == "F",
    select = c(-3, -5)
  )
)


# Example 34: Select rows using logical indexing

print(painters[painters[["School"]] == "F", ])


# Example 35: Select rows with Drawing >= 15

print(subset(painters, Drawing >= 15))


# ============================================================
# PART 8: SPLITTING A DATA FRAME
# ============================================================

cat("\n========== PART 8: split() ==========\n")

# Example 36: Split painters according to School

splitted <- split(painters, painters$School)

# Display the split data frames

print(splitted)


# Example 37: Access the data frame for School A

print(splitted$A)


# Example 38: Access the data frame for School F

print(splitted$F)


# Example 39: Check whether splitted$A is a data frame

print(is.data.frame(splitted$A))


# Example 40: Display all school categories

print(names(splitted))


# ============================================================
# PART 9: COMBINING DATA FRAMES USING cbind()
# ============================================================

cat("\n========== PART 9: cbind() ==========\n")

# Example 41: Create the first data frame

df1 <- data.frame(
  state = c("UP", "MP", "AP", "JK"),
  popnsize = c(1000, 2000, 3000, 4000)
)

print(df1)


# Example 42: Create the second data frame

df2 <- data.frame(
  state = c("UP", "MP", "AP", "JK"),
  samplesize = c(100, 200, 300, 400),
  surveycompleted = c("Yes", "No", "Yes", "No")
)

print(df2)


# Example 43: Combine columns side-by-side

combined_columns <- cbind(df1, df2)

print(combined_columns)


# ============================================================
# PART 10: MERGING DATA FRAMES USING merge()
# ============================================================

cat("\n========== PART 10: merge() ==========\n")

# Example 44: Merge using the common column "state"

merged_data <- merge(df1, df2, by = "state")

print(merged_data)


# Example 45: Merge while preserving the original row order
# of df1 (sort = FALSE)

merged_data2 <- merge(df1, df2, by = "state", sort = FALSE)

print(merged_data2)


# ============================================================
# PART 11: COMBINING DATA FRAMES USING rbind()
# ============================================================

cat("\n========== PART 11: rbind() ==========\n")

# Example 46: Create the first data frame

df11 <- data.frame(
  state = c("UP", "MP", "AP", "JK"),
  popnsize = c(1000, 2000, 3000, 4000)
)

print(df11)


# Example 47: Create the second data frame

df22 <- data.frame(
  state = c("Bihar", "Delhi", "Punjab"),
  popnsize = c(100, 200, 300)
)

print(df22)


# Example 48: Stack rows vertically

combined_rows <- rbind(df11, df22)

print(combined_rows)


# ============================================================
# PART 12: FINAL COMPARISON
# ============================================================

cat("\n========== FINAL COMPARISON ==========\n")

cat("sub()   : Replaces the first matching occurrence.\n")
cat("gsub()  : Replaces all matching occurrences.\n")
cat("grep()  : Returns matching positions or matching strings.\n")
cat("grepl() : Returns TRUE/FALSE for each element.\n")
cat("subset(): Selects rows and/or columns.\n")
cat("split() : Divides a data frame into groups.\n")
cat("cbind() : Combines columns side-by-side.\n")
cat("merge() : Joins data frames using a common column.\n")
cat("rbind() : Combines rows vertically.\n")

cat("\n========== WEEK 10 COMPLETED SUCCESSFULLY ==========\n")
# ============================================================
# NPTEL - FOUNDATIONS OF R SOFTWARE
# WEEK 6
# Loops, Functions and Sequences
# ============================================================


# ============================================================
# PART 1: FOR LOOP
# ============================================================

# Example 1
# Print squares of numbers from 1 to 5

for (i in 1:5) {
  print(i^2)
}


# Expected:
# 1
# 4
# 9
# 16
# 25


# ------------------------------------------------------------
# Example 2: for loop with a vector
# ------------------------------------------------------------

for (i in c(2, 4, 6, 7)) {
  print(i^2)
}


# Expected:
# 4
# 16
# 36
# 49


# ============================================================
# PART 2: FOR LOOP + FUNCTION + IF
# ============================================================

x <- c(2, 4, 6, 8, 10, 12)

excount <- function(x) {

  count <- 0

  for (xval in x) {

    if (xval / 2 > 3) {
      count <- count + 1
    }

  }

  print(count)
}

excount(x)

# Expected:
# [1] 3


# ============================================================
# PART 3: NESTED FOR LOOP
# ============================================================

child <- c("child1", "child2", "child3")

sweet <- c("sweet1", "sweet2", "sweet3")

for (x in child) {

  for (y in sweet) {

    print(paste(x, y))

  }

}


# Expected:
# child1 sweet1
# child1 sweet2
# child1 sweet3
# child2 sweet1
# child2 sweet2
# child2 sweet3
# child3 sweet1
# child3 sweet2
# child3 sweet3


# ============================================================
# PART 4: BREAK COMMAND
# ============================================================

drink <- c("coffee", "lemonade", "tea", "juice")

for (x in drink) {

  if (x == "tea") {
    break
  }

  print(x)
}


# Expected:
# coffee
# lemonade

# Why?
# When x becomes "tea", break immediately terminates the loop.


# ============================================================
# PART 5: NEXT COMMAND
# ============================================================

drink <- c("coffee", "lemonade", "tea", "juice")

for (x in drink) {

  if (x == "lemonade") {
    next
  }

  print(x)
}


# Expected:
# coffee
# tea
# juice

# next skips the current iteration
# but DOES NOT terminate the loop.


# ------------------------------------------------------------
# Another next example: skip tea
# ------------------------------------------------------------

drink <- c("coffee", "lemonade", "tea", "juice")

for (x in drink) {

  if (x == "tea") {
    next
  }

  print(x)
}


# Expected:
# coffee
# lemonade
# juice



# ============================================================
# PART 6: WHILE LOOP
# ============================================================

# Example 1

i <- 1

while (i < 10) {

  print(i^2)

  i <- i + 2

}


# Expected:
# 1
# 9
# 25
# 49
# 81


# Values of i are:
# 1, 3, 5, 7, 9
# Their squares:
# 1, 9, 25, 49, 81


# ============================================================
# PART 7: WHILE LOOP + FUNCTION + USER INPUT
# ============================================================

sumfunction <- function() {

  sum <- 0

  number <- as.integer(
    readline(prompt = "Please select any number less than 25: ")
  )

  while (number <= 25) {

    sum <- sum + number

    number <- number + 1

  }

  print(
    paste(
      "The sum of numbers received from the While Loop: ",
      sum
    )
  )
}

# Run this separately because it asks for input:
# sumfunction()


# Example:
# If input = 22
# 22 + 23 + 24 + 25 = 94


# ============================================================
# PART 8: REPEAT LOOP
# ============================================================

i <- 1

repeat {

  print(i^2)

  i <- i + 2

  if (i > 10) {
    break
  }

}


# Expected:
# 1
# 9
# 25
# 49
# 81


# ============================================================
# PART 9: REPEAT + NEXT + BREAK
# ============================================================

i <- 1

repeat {

  i <- i + 1

  if (i < 10) {
    next
  }

  print(i^2)

  if (i >= 13) {
    break
  }

}


# Expected:
# 100
# 121
# 144
# 169


# ============================================================
# PART 10: FUNCTIONS
# ============================================================

# Function with one argument

abc <- function(x) {

  x^2

}


# Calling the function

abc(3)
abc(6)
abc(9)


# Expected:
# 9
# 36
# 81


# ============================================================
# PART 11: FUNCTION WITH TWO ARGUMENTS
# ============================================================

abc <- function(x, y) {

  x^2 + y^2

}


abc(3, 4)

abc(10, 10)

abc(-2, -3)


# Expected:
# 25
# 200
# 13


# ============================================================
# PART 12: FUNCTION USING sin() AND cos()
# ============================================================

abc <- function(x) {

  sin(x)^2 + cos(x)^2 + x

}


abc(9)

abc(99)

abc(-15)


# Expected:
# 10
# 100
# -14


# ============================================================
# PART 13: FUNCTION WITHOUT ARGUMENT
# ============================================================

abc <- function() {

  for (i in 1:3) {

    print(i^3)

  }

}


abc()


# Expected:
# 1
# 8
# 27


# ============================================================
# PART 14: SEQUENCES
# ============================================================

# Basic sequence

seq(from = 2, to = 4)

seq(from = 4, to = 2)

seq(from = -4, to = 4)


# Expected:
# 2 3 4
# 4 3 2
# -4 -3 -2 -1 0 1 2 3 4


# ============================================================
# PART 15: SEQUENCE WITH CONSTANT INCREMENT
# ============================================================

seq(from = 10, to = 20, by = 2)


# Expected:
# 10 12 14 16 18 20


# ============================================================
# PART 16: SEQUENCE WITH CONSTANT DECREMENT
# ============================================================

seq(from = 20, to = 10, by = -2)


# Expected:
# 20 18 16 14 12 10


# ============================================================
# PART 17: FRACTIONAL DECREMENT
# ============================================================

seq(from = 3, to = -2, by = -0.5)


# Expected:
# 3.0 2.5 2.0 1.5 1.0 0.5
# 0.0 -0.5 -1.0 -1.5 -2.0


# ============================================================
# PART 18: SEQUENCE WITH PREDEFINED LENGTH
# ============================================================

seq(to = 10, length = 10)


# Expected:
# 1 2 3 4 5 6 7 8 9 10


# ------------------------------------------------------------
# Starting from 10
# ------------------------------------------------------------

seq(from = 10, length = 10)


# Expected:
# 10 11 12 13 14 15 16 17 18 19


# ============================================================
# PART 19: PREDEFINED LENGTH + FRACTIONAL INCREMENT
# ============================================================

seq(
  from = 10,
  length = 10,
  by = 0.1
)


# Expected:
# 10.0 10.1 10.2 10.3 10.4
# 10.5 10.6 10.7 10.8 10.9


# ============================================================
# PART 20: PREDEFINED LENGTH + DECREMENT
# ============================================================

seq(
  from = 10,
  length = 10,
  by = -2
)


# Expected:
# 10 8 6 4 2 0 -2 -4 -6 -8


# ============================================================
# PART 21: PREDEFINED LENGTH + FRACTIONAL DECREMENT
# ============================================================

seq(
  from = 10,
  length = 5,
  by = -0.2
)


# Expected:
# 10.0 9.8 9.6 9.4 9.2


# ============================================================
# END OF WEEK 6
# ============================================================
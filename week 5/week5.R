# =========================
# NPTEL R - WEEK 5
# =========================

# Missing Data
x = c(11, NA, 13, NA)

is.na(x)

mean(x)
mean(x, na.rm = TRUE)

which(is.na(x))

sum(is.na(x))

complete.cases(x)

y = na.omit(x)
y


# =========================
# IF
# =========================

x = 5

if (x > 4) {
    x * 3
}


# =========================
# IF ELSE
# =========================

x = 5

if (x == 4) {
    x = x - 1
} else {
    x = 2 * x
}

x


# =========================
# IF ELSE IF
# =========================

x = 2

if (x == 3) {
    x = x - 1
} else if (x < 3) {
    x = x + 5
} else {
    x = 2 * x
}

x


# =========================
# IFELSE
# =========================

x = 1:10

ifelse(x < 6, x^2, x + 1)


# =========================
# SWITCH
# =========================

switch(2, "apple", "banana", "orange")

switch(1, "apple", "banana", "orange")


# =========================
# WHICH
# =========================

x = c(10, 15, 8, 14, 6, 12)

which(x == 14)
which(x != 12)
which(x > 10)

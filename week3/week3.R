print(c(2,3,5,7) + c(-2, -3, -5, 8))
 
# power operator
print(2^3)
print(2**0.5)
print(2 ** -0.5)
 
# power with scalar
print(c(3, 5, 8, 7)^2)
 
print(c(3, 4, 5, 6) ^ c(2, 3))
# warning msg when length of vectors are not multiple of each other
 
 
#division operator %/% remainder is discarded
print(2 %/% 2)
print(2 %/% 3)
print(5 %/% 2)
 
print(c(2, 3, 4, 5) %/% c(1, 2 ))
 
# modulo operator %% remainder is kept
print(2 %% 2)
print(2 %% 3)
print(5 %% 2)
 
print(c(2, 3, 4, 5) %% c(1, 2 ))
 
# max
print(max(1.2, 3.4, 5.6, 7.8))
print(max(c(2, 3, 4, 5)))
 
# min
print(min(1.2, 3.4, 5.6, 7.8))
print(min(c(2, 3, 4, 5)))
 
# mean
print(mean(1.2, 3.4, 5.6, 7.8))
print(mean(c(2, 3, 4, 5)))
 
# abs
print(abs(-2))
print(abs(c(-2, -3, 4, 5)))
 
# sqrt
print(sqrt(4))
print(sqrt(c(4, 9, 16, 25)))
 
# sum
print(sum(1.2, 3.4, 5.6, 7.8))
print(sum(c(2, 3, 4, 5)))
 
# prod
print(prod(1.2, 3.4, 5.6, 7.8))
print(prod(c(2, 3, 4, 5)))
 
# round
print(round(3.14159))
print(round(3.14159, 2))
print(round(c(3.14159, 2.71828, 1.41421), 3))
 
print(c(2,3,5,7) + c(-2,-3,-5,8))

print(c(2,3,5,7) - c(1,2,3,4))

print(c(2,3,5,7) * c(1,2,3,4))

print(c(2,3,5,7) / c(1,2,3,4))
 
print(2^3)

print(2**3)

print(2^0.5)

print(2**0.5)

print(2^-0.5)

print(c(2,3,5,7)^2)

print(c(2,3,5,7)^c(2,3))
 
print(2 %/% 2)

print(5 %/% 2)

print(7 %/% 3)

print(c(2,3,5,7) %/% 2)

print(c(2,3,5,7) %/% c(2,3))
 
print(2 %% 2)

print(3 %% 2)

print(7 %% 3)

print(7 %% 4)

print(c(2,3,5,7) %% 2)

print(c(2,3,5,7) %% c(2,3))
 
print(max(1.2,3.4,-7.8))

print(max(c(1.2,3.4,-7.8)))
 
print(min(1.2,3.4,-7.8))

print(min(c(1.2,3.4,-7.8)))
 
print(mean(c(2,3,4)))
 
print(abs(-4))

print(abs(c(-1,-2,-3,4,5)))
 
print(sqrt(4))

print(sqrt(c(4,9,16,25)))
 
print(sum(c(2,3,5,7)))

print(prod(c(2,3,5,7)))
 
print(round(1.23))

print(round(1.83))
 
print(floor(1.23))

print(floor(1.83))
 
print(ceiling(1.23))

print(ceiling(1.83))
 
print(log(10))

print(log(exp(1)))

print(log(c(10,100,1000)))
 
print(log10(10))

print(log10(100))

print(log10(c(10,100,1000)))
 
print(log2(2))

print(log2(4))

print(log2(c(2,4,8,16)))
 
print(exp(1))

print(exp(2))

print(exp(c(1,2,3)))
 
print(sin(0))

print(cos(0))

print(tan(0))

print(asin(0))

print(acos(1))

print(atan(0))
 
print(sinh(0))

print(cosh(0))

print(tanh(0))

print(asinh(0))

print(acosh(1))

print(atanh(0))
 
x1 = c(1,2,3,4)

print(x1)
 
x2 = x1^2

print(x2)
 
print(c(1,2,3,4) + sum(c(1,2,3,4)) * prod(c(1,2)))

print(abs(c(1,2,3,4) - sum(c(1,2,3,4))*prod(c(1,2))))
 
x = matrix(nrow=4,ncol=2,data=c(1,2,3,4,5,6,7,8))

print(x)
 
print(x[3,2])

print(x[1,])

print(x[2,])

print(x[,1])

print(x[,2])
 
print(dim(x))

print(nrow(x))

print(ncol(x))

print(mode(x))

print(attributes(x))
 
x = matrix(nrow=4,ncol=2,data=c(1,2,3,4,5,6,7,8),byrow=FALSE)

print(x)
 
y = matrix(nrow=4,ncol=2,data=c(1,2,3,4,5,6,7,8),byrow=TRUE)

print(y)
 
A = matrix(c(1,2,3,4),nrow=2,ncol=2)

B = matrix(c(5,6,7,8),nrow=2,ncol=2)
 
print(A)

print(B)
 
print(A+B)

print(A-B)

print(A*B)

print(A/B)

print(A^2)
 
print(t(A))

print(A %*% B)
 
print(dim(A))

print(nrow(A))

print(ncol(A))

print(mode(A))

print(attributes(A))

print(is.matrix(A))
 

# Subsetting Data


```r
knitr::knit_hooks$set(document = function(x) {
    gsub("```\n*```r\n*", "", x)
})
```



R has many powerful subset operators and mastering them will allow you to easily perform complex operation on any kind of dataset. Allows you to manipulate data very succinctly.

As the last section for this topic we'll cover:

* The three subsetting operators,
* The six types of subsetting,
* Important difference in subsetting behaviour for different objects 
* Using subsetting in conjunction with assignment


## Subsetting atomic vectors


```r
x <- c(5.4, 6.2, 7.1, 4.8)
```


**We can subset this in 5 ways**

Using positive integers


```r
x[1]
```

```
## [1] 5.4
x[c(3, 1)]
```

```
## [1] 7.1 5.4
# We can duplicate indices
x[c(1, 1)]
```

```
## [1] 5.4 5.4
# Real numbers are silently truncated to integers
x[c(2.1, 2.9)]
```

```
## [1] 6.2 6.2
```


Using negative integers


```r
# skip the first element
x[-1]
```

```
## [1] 6.2 7.1 4.8
# skip the first and the fifth
x[-c(1, 5)]
```

```
## [1] 6.2 7.1 4.8
```


Using logical operators


```r
x[c(TRUE, TRUE, FALSE, FALSE)]
```

```
## [1] 5.4 6.2
# or based on a condition
x[x > 3]
```

```
## [1] 5.4 6.2 7.1 4.8
x[which(x > 3)]
```

```
## [1] 5.4 6.2 7.1 4.8
# Also see `which.max()` and `which.min()`
```


with nothing


```r
x[]
```

```
## [1] 5.4 6.2 7.1 4.8
# useful when dealing with 2 or higher dimensional objects
```


with zero


```r
x[0]
```

```
## numeric(0)
# helpful for generating test data or creating empty objects
```



Referencing objects by their names


```r
(y <- setNames(x, letters[1:4]))
```

```
##   a   b   c   d 
## 5.4 6.2 7.1 4.8
y[c("d", "c", "a")]
```

```
##   d   c   a 
## 4.8 7.1 5.4
# We can also repeat indices
y[c("a", "a", "a")]
```

```
##   a   a   a 
## 5.4 5.4 5.4
# Names are always matched exactly, not partially
z <- c(abc = 1, def = 2)
z[c("a", "d")]
```

```
## <NA> <NA> 
##   NA   NA
```


---

## Subsetting lists

Subsetting a list works in exactly the same way as subsetting an atomic vector. Subsetting a list with [ will always return a list: `[[` and `$`, as described below, let you pull out the components of the list.


```r
x <- as.list(1:10)
x[1:5]
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
## 
## [[4]]
## [1] 4
## 
## [[5]]
## [1] 5
# What class is this object?
```


To extract individual elements inside a list, use the `[[` operator


```r
# to get element 5
x[[5]]
```

```
## [1] 5
class(x[[5]])
```

```
## [1] "integer"
another_variable <- x[[5]]
```


Or using their names


```r
names(x) <- letters[1:5]
x$a
```

```
## [1] 1
x[["a"]]
```

```
## [1] 1
```


## Subsetting matrices

A matrix is subset with two arguments within single brackets, `[]`, and separated by a comma. The first argument specifies the rows, and the second the columns.


```r
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a[1:2, ]
```

```
##      A B C
## [1,] 1 4 7
## [2,] 2 5 8
a[c(T, F, T), c("B", "A")]
```

```
##      B A
## [1,] 4 1
## [2,] 6 3
a[0, -2]
```

```
##      A C
```


## Subsetting data frames


```r
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[df$x == 2, ]
```

```
##   x y z
## 2 2 2 b
df[c(1, 3), ]
```

```
##   x y z
## 1 1 3 a
## 3 3 1 c
```


There are two ways to select columns from a data frame
+ Like a list:


```r
df[c("x", "z")]
```

```
##   x z
## 1 1 a
## 2 2 b
## 3 3 c
```


+ Like a matrix:


```r
df[, c("x", "z")]
```

```
##   x z
## 1 1 a
## 2 2 b
## 3 3 c
```


There's an important difference if you select a simple column: matrix subsetting simplifies by default, list subsetting does not.


```r
df["x"]
```

```
##   x
## 1 1
## 2 2
## 3 3
df[, "x"]
```

```
## [1] 1 2 3
```


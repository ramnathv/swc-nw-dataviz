# Functions

If you have to repeat the same few lines of code more than once, then you really need to write a function. Functions are a fundamental building block of R. You use them all the time in R and it's not that much harder to string functions together (or write entirely new ones from scratch) to do more.

* R functions are objects just like anything else.
* By default, R function arguments are lazy - they're only evaluated if they're actually used:
* Every call on a R object is almost always a function call.

## Basic components of a function

* The `body()`, the code inside the function.
* The `formals()`, the "formal" argument list, which controls how you can call the function.
* The `environment()`` which determines how variables referred to inside the function are found.
* `args()` to list arguments.


```r
f <- function(x) x
f
formals(f)
environment(f)
```


**Question: How do we delete this function from our environment?**

## More on environments
Variables defined inside functions exist in a different environment than the global environment. However, if a variabe is not defined inside a function, it will look one level above.

example.


```r
x <- 2
g <- function() {
    y <- 1
    c(x, y)
}
g()
```

```
## [1] 2 1
```

```r
rm(x, g)
```


Same rule applies for nested functions.


A first useful function.


```r
first <- function(x, y) {
    z <- x + y
    return(z)
}
```



```r
add <- function(a, b) {
    return(a + b)
}
vector <- c(3, 4, 5, 6)

sapply(vector, add, 1)
```


**What does this function return?**


```r
x <- 5
f <- function() {
    y <- 10
    c(x = x, y = y)
}
f()
```


**What does this function return?**


```r
x <- 5
g <- function() {
    x <- 20
    y <- 10
    c(x = x, y = y)
}
g()
```


**What does this function return??**


```r
x <- 5
h <- function() {
    y <- 10
    i <- function() {
        z <- 20
        c(x = x, y = y, z = z)
    }
    i()
}
h()
```



**Functions with pre defined values**


```r
temp <- function(a = 1, b = 2) {
    return(a + b)
}
```


**Functions usually return the last value it computed**


```r
f <- function(x) {
    if (x < 10) {
        0
    } else {
        10
    }
}
f(5)
f(15)
```


## Scoping Rules

Assuming we run the following code:


```r
c <- 100
(c + 1)
```


Can we still use `c()` to concactenate vectors?


```r
(x1 <- c(1:4))
```


How does R know which value of `c` to use when? R has separate namespaces for functions and non-functions. That's why this is possible.


When R tried to "bind" a value to a symbol (in this case `c`), it follows a very specific search path, looking first at the Global environment, then the namespaces of each package.

What is this order?


```r
> search()
 [1] ".GlobalEnv"        "package:graphics"  "package:grDevices"
 [4] "package:datasets"  "package:devtools"  "package:knitr"
 [7] "package:plyr"      "package:reshape2"  "package:ggplot2"
[10] "package:stats"     "package:coyote"    "package:utils"
[13] "package:methods"   "Autoloads"         "package:base"
```


Newly loaded packages end up in position 2 and everything else gets bumped down the list. `base` is always at the very end.

`.GlobalEnv` is just your workspace. If there's a symbol matching your request, it will take that value based on your request.

If nothing is found, it will search the namespace of each of the packages you've loaded (your list will look different).

Package loading order matters.

Example:



```r
library(plyr)
library(Hmisc)
is.discrete
```



```r
library(Hmisc)
library(plyr)
is.discrete
```


Reference functions inside a package's namespace using the `::` operator.


```r
Hmisc::is.discrete
plyr::is.discrete
```


R uses scoping rules called Lexical scoping (otherwise known as static scoping).

It determines how a value is associated with a free variable in a function.


```r
add <- function(a, b) {
    (a + b)/n
}
```


`n` here is the free variable.

**Rules of scoping**

R first searches in the environment where the function was defined. An environment is a collection of symbols and values. Environments have parents.


```r
> parent.env(globalenv())
<environment: package:graphics>
attr(,"name")
[1] "package:graphics"
attr(,"path")
[1] "/Library/Frameworks/R.framework/Versions/3.0/Resources/library/graphics"
> search()
 [1] ".GlobalEnv"        "package:graphics"  "package:grDevices"
 [4] "package:datasets"  "package:devtools"  "package:knitr"
 [7] "package:plyr"      "package:reshape2"  "package:ggplot2"
[10] "package:stats"     "package:coyote"    "package:utils"
[13] "package:methods"   "Autoloads"         "package:base"
```


Since we defined `add` in the global env, R looks for `n` in that environment. You can confirm that the function `add` was defined in the global env using the function `environment`.


```r
environment(add)
```


These rules matter because you can define nested functions.

Example:



```r
make.power <- function(n) {
    pow <- function(x) {
        x^n
    }
    pow
}
```


This is a constructor function, i.e. a function that creates another one.


```r
cube <- make.power(3)
square <- make.power(2)
```



```r
cube(3)
square(3)
```



```r
ls(environment(cube))
get("n", environment(cube))
```



```r
ls(environment(square))
get("n", environment(square))
```


You can see that `R` is searching for `n` first within each environment before looking elsewhere.

Why scoping matters?


```r
y <- 10

f1 <- function(x) {
    y <- 2
    y^2 + f2(x)
}


f2 <- function(x) {
    x * y
}
```


What does `f1(10)` return?

Possible answers:
* `104`
* `24`


This is a consequence of lexical or static scoping. The alternate will result if R were using dynamic scoping. One downside (as you'll see with larger tasks) is that R has to carry everything in memory.

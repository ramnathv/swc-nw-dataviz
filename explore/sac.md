# Split-Apply-Combine: I

The split-apply-combine paradigm can be concisely summarized using the diagram below (thanks hadley!)

<img src=http://inundata.org/R_talks/meetup/images/splitapply.png width=75%></img>

Base R has several functions that make this easy. Let us start by revisiting __Exercise 3__ from the previous lesson. This time, we will use the base function `aggregate` to carry out the computations. We use the formula interface provided by `aggregate`.


```r
bnames2_b = mutate(bnames2_b, tot = prop * births)
result <- aggregate(formula = tot ~ name, data = bnames2_b, FUN = sum)
```


__Exercise 1__

What is the most popular `name` by `gender` between the years 2000 to 2008? (Hint: The `aggregate` function accepts a `subset` argument!) Once again, enter your guesses on Etherpad before starting out!

__Solution 1__


```r
result2 <- aggregate(formula = tot ~ name + sex, data = bnames2_b, FUN = sum, 
    subset = (year >= 2000))
most_pop_boy <- arrange(subset(result2, sex == "boy"), desc(tot))[1, "name"]
most_pop_girl <- arrange(subset(result2, sex == "girl"), desc(tot))[1, "name"]
```


<a href="javascript:expandcollapse('solution1')">
   [+/-] Solution
</a><br>

<span class='posthidden' id='solution1'>
The most popular names between 2000 and 2008 are __Jacob__ and __Emily__
</span>


So far, we have seen `split-apply-combine` applied in the context of data frames. However, you can think of similar problems for other data structures. Here are some examples.

1. Extract components by name from a `list`.
2. Compute the mean across rows/columns of a `matrix`.
3. Apply a `function` across multiple sets of arguments.

Base R has a family of functions, popularly referred to as the `apply` family to carry out such operations. 

__apply__

`apply` applies a function to each row or column of a matrix.


```r
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
# 1 is the row index 2 is the column index
apply(m, 1, sum)
```

```
##  [1] 12 14 16 18 20 22 24 26 28 30
```

```r
apply(m, 2, sum)
```

```
## [1]  55 155
```

```r
apply(m, 1, mean)
```

```
##  [1]  6  7  8  9 10 11 12 13 14 15
```

```r
apply(m, 2, mean)
```

```
## [1]  5.5 15.5
```


__lapply__


`lapply` applies a function to each element of a list



```r
my_list <- list(a = 1:10, b = 2:20)
lapply(my_list, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 11
```


__sapply__

`sapply` is a more user friendly version of `lapply` and will return a list of matrix where appropriate. Let us work with the same list we just created.


```r
my_list
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
x <- sapply(my_list, mean)
x
```

```
##    a    b 
##  5.5 11.0
```

```r
class(x)
```

```
## [1] "numeric"
```


__mapply__

Its more or less a multivariate version of `sapply`. It applies a function to all corresponding elements of each argument. 


```r
list_1 <- list(a = c(1:10), b = c(11:20))
list_1
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1] 11 12 13 14 15 16 17 18 19 20
```

```r
list_2 <- list(c = c(21:30), d = c(31:40))
list_2
```

```
## $c
##  [1] 21 22 23 24 25 26 27 28 29 30
## 
## $d
##  [1] 31 32 33 34 35 36 37 38 39 40
```

```r
mapply(sum, list_1$a, list_1$b, list_2$c, list_2$d)
```

```
##  [1]  64  68  72  76  80  84  88  92  96 100
```



__tapply__

`tapply` applies a function to subsets of a vector.


```r
head(warpbreaks)
```

```
##   breaks wool tension
## 1     26    A       L
## 2     30    A       L
## 3     54    A       L
## 4     25    A       L
## 5     70    A       L
## 6     52    A       L
```

```r
with(warpbreaks, tapply(breaks, list(wool, tension), mean))
```

```
##       L     M     H
## A 44.56 24.00 24.56
## B 28.22 28.78 18.78
```




__by__

`by` applies a function to subsets of a data frame.


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
by(iris[, 1:2], iris[, "Species"], summary)
```

```
## iris[, "Species"]: setosa
##   Sepal.Length   Sepal.Width  
##  Min.   :4.30   Min.   :2.30  
##  1st Qu.:4.80   1st Qu.:3.20  
##  Median :5.00   Median :3.40  
##  Mean   :5.01   Mean   :3.43  
##  3rd Qu.:5.20   3rd Qu.:3.67  
##  Max.   :5.80   Max.   :4.40  
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.00  
##  1st Qu.:5.60   1st Qu.:2.52  
##  Median :5.90   Median :2.80  
##  Mean   :5.94   Mean   :2.77  
##  3rd Qu.:6.30   3rd Qu.:3.00  
##  Max.   :7.00   Max.   :3.40  
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.20  
##  1st Qu.:6.22   1st Qu.:2.80  
##  Median :6.50   Median :3.00  
##  Mean   :6.59   Mean   :2.97  
##  3rd Qu.:6.90   3rd Qu.:3.17  
##  Max.   :7.90   Max.   :3.80
```

```r
by(iris[, 1:2], iris[, "Species"], sum)
```

```
## iris[, "Species"]: setosa
## [1] 421.7
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
## [1] 435.3
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
## [1] 478.1
```




__replicate__

An extremely useful function to generate datasets for simulation purposes. The final arguments turns the result into a vector or matrix if possible.


```r
replicate(10, rnorm(10))
```

```
##          [,1]       [,2]    [,3]      [,4]     [,5]    [,6]    [,7]
##  [1,] -0.7645  0.3185895 -0.5689 -0.319964  1.49882 -0.1593 -0.5763
##  [2,] -1.4341 -0.6606781  0.1524 -1.198101  0.66228 -2.5825 -1.4917
##  [3,] -0.4506 -1.2797852  0.8286  0.996100  0.85089 -1.4561 -1.8850
##  [4,] -1.1801 -0.4159011 -0.2935  2.993512  0.75832  1.1798 -1.4708
##  [5,]  0.8747  0.2859087  0.3850  0.135864 -0.06600 -1.1847 -0.6427
##  [6,]  0.5061 -1.7811872  0.4246 -0.150876 -0.41276 -1.8907 -1.4703
##  [7,] -1.2202 -0.0261400 -1.2307 -0.002978 -0.05067 -0.8345  0.5299
##  [8,] -1.9122 -0.0492036 -0.2750  1.169480 -0.07576 -0.4210 -0.2340
##  [9,]  0.7003 -0.0005288  0.4755 -1.018941  0.71602 -0.4772  1.0729
## [10,] -0.9529  0.4603188 -0.8582  0.276076  1.89744 -1.4785 -0.8311
##          [,8]     [,9]    [,10]
##  [1,]  1.4185  1.11500  0.69105
##  [2,] -1.0606  0.59550  1.17109
##  [3,] -1.4184  0.03055  0.38472
##  [4,] -0.5362 -0.16319  0.09477
##  [5,] -1.1632  0.23351 -2.82787
##  [6,]  0.6561  1.05047 -0.45404
##  [7,] -1.9730 -0.42788 -0.52041
##  [8,]  0.2142  0.06984 -0.48828
##  [9,] -0.8232  0.18984  1.66038
## [10,] -0.3286 -0.23661 -0.14971
```

```r
replicate(10, rnorm(10), simplify = TRUE)
```

```
##           [,1]     [,2]     [,3]    [,4]     [,5]     [,6]     [,7]
##  [1,]  1.40054  0.03782  0.78123  0.5410 -1.91830  1.28884  0.13196
##  [2,] -0.48184  0.45810 -1.28727  1.9267  2.04608 -0.44330 -0.68003
##  [3,] -0.70475 -0.03546 -0.87877 -0.6897 -0.17008 -0.03965  0.19166
##  [4,]  0.55422  1.91311 -0.30243  0.6063  0.08633  0.05310  1.73896
##  [5,]  0.07958  1.85288 -0.18641  0.5110  0.43457 -0.66518  3.29714
##  [6,]  1.13159  0.47895 -1.34840 -0.1361 -0.23868  0.80694 -0.58947
##  [7,]  1.50151 -1.70485  0.18591  1.3231  0.02367  0.48548  0.17218
##  [8,] -0.75878  0.25700  0.04495  1.1295 -0.06657 -0.68207 -1.44063
##  [9,]  1.22445 -0.62720  0.61522 -0.6100  0.11585 -0.21544 -0.34115
## [10,] -1.38435  1.02435 -0.37469 -0.4636 -0.07225 -1.53654  0.04528
##           [,8]    [,9]   [,10]
##  [1,] -0.04667  0.1478 -1.5232
##  [2,]  0.13871  0.2219 -0.9314
##  [3,] -0.71036 -0.4076  0.3054
##  [4,] -0.53646 -1.4261  0.4189
##  [5,] -1.44751  1.9548  1.3638
##  [6,] -0.64740 -0.3214 -0.3939
##  [7,] -1.34268  1.3749  0.7859
##  [8,] -0.04138 -0.9589  0.6699
##  [9,]  1.64503  0.9598  1.3884
## [10,] -0.93664  0.4841  0.7852
```


While these functions in Base R get the job done, the inconsistent syntax often trips up users. Over the years, several alternatives have emerged, that aim to provide a simpler and more consistent syntax to operationalize `split-apply-combine`. In the next lesson, we will explore three packages in particular: `plyr`, `data.table` and `dplyr`.


<style>
  .posthidden {display:none} 
  .postshown {display:inline}
</style>

<script type="text/Javascript"> 

  function expandcollapse (postid) { 
    whichpost = document.getElementById(postid); 
   
     if (whichpost.className=="postshown") { 
      whichpost.className="posthidden"; 
     } 
     else { 
      whichpost.className="postshown"; 
     } 
  } 
</script>



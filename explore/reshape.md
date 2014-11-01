# Reshape




One way to tidy data is to `reshape` it so that it adheres to the three rules of tidy data. While base R has several functions aimed at reshaping data, we will use the `reshape2` package by [Hadley Wickham](http://github.com/hadley), as it provides a simple and consistent set of functions to reshape data.


### Basics

In the simplest terms, reshaping data is like doing a pivot table in excel, where you shuffle columns, rows and values. Let us start by tidying the [pew](data/pew.txt) dataset.


```r
pew <- read.delim(
  file = "data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)
```


We can tidy this data using the `melt` function in the `reshape2` package.


```r
library(reshape2)
pew_tidy <- melt(
  data = pew,
  id = "religion",
  variable.name = "income",
  value.name = "frequency"
)
```


<!-- html table generated in R 3.0.3 by xtable 1.7-3 package -->
<!-- Tue Apr 15 05:00:02 2014 -->
<TABLE >
<TR> <TH> religion </TH> <TH> income </TH> <TH> frequency </TH>  </TR>
  <TR> <TD> Agnostic </TD> <TD> &lt;$10k </TD> <TD align="right"> 27 </TD> </TR>
  <TR> <TD> Atheist </TD> <TD> &lt;$10k </TD> <TD align="right"> 12 </TD> </TR>
  <TR> <TD> Buddhist </TD> <TD> &lt;$10k </TD> <TD align="right"> 27 </TD> </TR>
  <TR> <TD> Catholic </TD> <TD> &lt;$10k </TD> <TD align="right"> 418 </TD> </TR>
  <TR> <TD> Don’t know/refused </TD> <TD> &lt;$10k </TD> <TD align="right"> 15 </TD> </TR>
  <TR> <TD> Evangelical Prot </TD> <TD> &lt;$10k </TD> <TD align="right"> 575 </TD> </TR>
   </TABLE>


### Exercise 1

Now that you know how to `melt` a data frame, use the same idea to tidy the [tb](data/tb.csv) dataset. Think about how you can split `gender` and `age` after melting the data


```r
tb <- read.csv(
  file = "data/tb.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)
```


### Solution 1



```r
library(reshape2)

# set column `new_sp` to NULL and clean up column names
tb$new_sp = NULL
names(tb) <- gsub("new_sp_", "", names(tb))

# Use na.rm = TRUE to remove missing observations
tb_tidy <- melt(
  data = tb,
  id = c("iso2", "year"),
  variable.name = "gender_age",
  value.name = "cases",
  na.rm = TRUE
)

# split gender_age into gender and age group
library(plyr)
tb_tidy <- mutate(tb_tidy,
  gender = sub("^([m|f])(.*)$", "\\1", gender_age),
  age = sub("^([m|f])(.*)$", "\\2", gender_age),
  gender_age = NULL
)
tb_tidy <- tb_tidy[c('iso2', 'year', 'gender', 'age', 'cases')]
```


There is one more step of cleaning required to assign the `age` groups more meaningful names. For example, `04` stands for `0-4`.

### Exercise 2

Use the same principles to clean the [weather](data/weather.txt) dataset.


```{r}
weather <- read.delim(
 file = "data/weather.txt",
 stringsAsFactors = FALSE
)
```


### Solution 2

We first melt the data and convert the `day` variable into numbers.


```r
weather_tidy <- melt(
  data = weather,
  id = 1:4,
  variable.name = "day",
  value.name = "temparature",
  na.rm = TRUE
)
weather_tidy <- mutate(weather_tidy,
  day = sub("^d", "", day)
)
```


We still have the issue of variables `TMAX` and `TMIN` being present in rows. We can fix this using the `dcast` function in `reshape2`. Type `?dcast` to read up the documentation on this function.


```r
weather_tidy2 <- dcast(
  data = weather_tidy,
  formula = id + year + month + day ~ element,
  value.var = "temparature"
)
```


### Exercise 3

Tidy the dataset `billboards.csv`! Note that this dataset suffers from messiness of other types. So you will need to think beyond what was done in the previous exercises.


### Solution 3

We start by reading the dataset using `read.csv`. I don't like using periods in column names, and so let us convert periods to underscores.


```r
billboards <- read.csv(
  file = "http://stat405.had.co.nz/data/billboard.csv",
  stringsAsFactors = FALSE
)
names(billboards) <- gsub("\\.", "_", names(billboards))
```





```r
billboards <- mutate(billboards,
  artist_inverted = iconv(artist_inverted, "MAC", "UTF-8"),
)
billboards_tidy <- melt(billboards,
  id = 1:7,
  variable.name = "week",
  value.name = "rank",
  na.rm = TRUE
)
billboards_tidy <- mutate(billboards_tidy,
  week = as.numeric(gsub("^x([[:digit:]]+).*", "\\1", week))
)
```




<style>
table{
  display: block;
  margin-left: auto;
  margin-right: auto;
}

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



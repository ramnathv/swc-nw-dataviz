# Tidy Data




Raw data in the real-world is often `untidy` and poorly formatted. Furthermore, it may lack appropriate details of the study. Correcting data in place can be a dangerous exercise since the original raw data would get overwritten and there would be no way to audit this process or recover from mistakes made during this time. A good data practice would be to maintain the original data, but use a programmatic script to clean it, fix mistakes and save that cleaned dataset for further analysis. In this lesson, you will learn all about tidy data.


__Question:__ Consider the following data below. How many variables does this dataset contain?




<!-- html table generated in R 3.0.3 by xtable 1.7-3 package -->
<!-- Tue Apr 15 04:51:50 2014 -->
<TABLE style='width:50%;'>
<TR> <TH> males </TH> <TH> females </TH>  </TR>
  <TR> <TD align="right"> 4 </TD> <TD align="right"> 1 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD align="right"> 5 </TD> </TR>
   </TABLE>


<a href="javascript:expandcollapse('solution1')">
   [+/-] Solution
 </a><br>

<span class='posthidden' id='solution1'>
The way the table is presented, it seems like there are only two variables. However, the correct answer is __3__. The variables are `injured?`, `count` and `gender`.
</span>

### What is Tidy Data?

A dataset is said to be tidy if it satisfies the following conditions

1. observations are in rows
2. variables are in columns
3. contained in a single dataset.

Tidy data makes it easy to carry out data analysis.

### Explore Messy Data

Let us explore some common causes of messiness by inspecting a few datasets.

__Income Distribution by Religion__


Our first dataset is based on a survey done by Pew Research that examines the relationship between [income and religious affiliation](http://www.pewforum.org/2009/01/30/income-distribution-within-us-religious-groups/).

Read the dataset into your R session and inspect the first few rows to assess if it is tidy.


```r
pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)
```


<!-- html table generated in R 3.0.3 by xtable 1.7-3 package -->
<!-- Tue Apr 15 04:51:50 2014 -->
<TABLE border=1>
<TR> <TH> religion </TH> <TH> &lt;$10k </TH> <TH> $10-20k </TH> <TH> $20-30k </TH> <TH> $30-40k </TH> <TH> $40-50k </TH> <TH> $50-75k </TH> <TH> $75-100k </TH> <TH> $100-150k </TH> <TH> &gt;150k </TH>  </TR>
  <TR> <TD> Agnostic </TD> <TD align="right"> 27 </TD> <TD align="right"> 34 </TD> <TD align="right"> 60 </TD> <TD align="right"> 81 </TD> <TD align="right"> 76 </TD> <TD align="right"> 137 </TD> <TD align="right"> 122 </TD> <TD align="right"> 109 </TD> <TD align="right"> 84 </TD> </TR>
  <TR> <TD> Atheist </TD> <TD align="right"> 12 </TD> <TD align="right"> 27 </TD> <TD align="right"> 37 </TD> <TD align="right"> 52 </TD> <TD align="right"> 35 </TD> <TD align="right"> 70 </TD> <TD align="right"> 73 </TD> <TD align="right"> 59 </TD> <TD align="right"> 74 </TD> </TR>
  <TR> <TD> Buddhist </TD> <TD align="right"> 27 </TD> <TD align="right"> 21 </TD> <TD align="right"> 30 </TD> <TD align="right"> 34 </TD> <TD align="right"> 33 </TD> <TD align="right"> 58 </TD> <TD align="right"> 62 </TD> <TD align="right"> 39 </TD> <TD align="right"> 53 </TD> </TR>
  <TR> <TD> Catholic </TD> <TD align="right"> 418 </TD> <TD align="right"> 617 </TD> <TD align="right"> 732 </TD> <TD align="right"> 670 </TD> <TD align="right"> 638 </TD> <TD align="right"> 1116 </TD> <TD align="right"> 949 </TD> <TD align="right"> 792 </TD> <TD align="right"> 633 </TD> </TR>
   </TABLE>


<a href="javascript:expandcollapse('solution1')">
   [+/-] Solution
 </a><br>

<span class='posthidden' id='solution1'>
Except for `religion`, the rest of the columns headers are actually values of a lurking variable `income`. This dataset violates the second rule of tidy data.
</span>

__Tuberculosis Incidence__


```r
tb <- read.csv(
  file = "http://stat405.had.co.nz/data/tb.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)
```



<!-- html table generated in R 3.0.3 by xtable 1.7-3 package -->
<!-- Tue Apr 15 04:51:51 2014 -->
<TABLE style="width:90%;">
<TR> <TH> iso2 </TH> <TH> year </TH> <TH> new_sp </TH> <TH> new_sp_m04 </TH> <TH> new_sp_m514 </TH> <TH> new_sp_m014 </TH> <TH> new_sp_m1524 </TH>  </TR>
  <TR> <TD> ZW </TD> <TD align="right"> 2004 </TD> <TD align="right"> 14581 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 187 </TD> <TD align="right"> 833 </TD> </TR>
  <TR> <TD> ZW </TD> <TD align="right"> 2005 </TD> <TD align="right"> 13155 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 210 </TD> <TD align="right"> 837 </TD> </TR>
  <TR> <TD> ZW </TD> <TD align="right"> 2006 </TD> <TD align="right"> 12718 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 215 </TD> <TD align="right"> 736 </TD> </TR>
  <TR> <TD> ZW </TD> <TD align="right"> 2007 </TD> <TD align="right"> 10583 </TD> <TD align="right"> 6 </TD> <TD align="right"> 132 </TD> <TD align="right"> 138 </TD> <TD align="right"> 500 </TD> </TR>
  <TR> <TD> ZW </TD> <TD align="right"> 2008 </TD> <TD align="right"> 9830 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 127 </TD> <TD align="right"> 614 </TD> </TR>
   </TABLE>


<a href="javascript:expandcollapse('solution2')">
   [+/-] Solution
 </a><br>

<span class='posthidden' id='solution2'>
Except for `iso2` and `year`, the rest of the columns headers are actually values of a lurking variable, in fact combination of __two__ lurking variables, `gender` and `age`.
</span>

__Weather Data__


```r
weather <- read.delim(
 file = "http://stat405.had.co.nz/data/weather.txt",
 stringsAsFactors = FALSE
)
```


<!-- html table generated in R 3.0.3 by xtable 1.7-3 package -->
<!-- Tue Apr 15 04:51:51 2014 -->
<TABLE border=1>
<TR> <TH> id </TH> <TH> year </TH> <TH> month </TH> <TH> element </TH> <TH> d1 </TH> <TH> d2 </TH> <TH> d3 </TH> <TH> d4 </TH> <TH> d5 </TH> <TH> d6 </TH> <TH> d7 </TH>  </TR>
  <TR> <TD> MX000017004 </TD> <TD align="right"> 2010 </TD> <TD align="right"> 10 </TD> <TD> TMIN </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 140 </TD> <TD align="right">  </TD> <TD align="right"> 129 </TD> </TR>
  <TR> <TD> MX000017004 </TD> <TD align="right"> 2010 </TD> <TD align="right"> 11 </TD> <TD> TMAX </TD> <TD align="right">  </TD> <TD align="right"> 313 </TD> <TD align="right">  </TD> <TD align="right"> 272 </TD> <TD align="right"> 263 </TD> <TD align="right">  </TD> <TD align="right">  </TD> </TR>
  <TR> <TD> MX000017004 </TD> <TD align="right"> 2010 </TD> <TD align="right"> 11 </TD> <TD> TMIN </TD> <TD align="right">  </TD> <TD align="right"> 163 </TD> <TD align="right">  </TD> <TD align="right"> 120 </TD> <TD align="right"> 79 </TD> <TD align="right">  </TD> <TD align="right">  </TD> </TR>
  <TR> <TD> MX000017004 </TD> <TD align="right"> 2010 </TD> <TD align="right"> 12 </TD> <TD> TMAX </TD> <TD align="right"> 299 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 278 </TD> <TD align="right">  </TD> </TR>
  <TR> <TD> MX000017004 </TD> <TD align="right"> 2010 </TD> <TD align="right"> 12 </TD> <TD> TMIN </TD> <TD align="right"> 138 </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right">  </TD> <TD align="right"> 105 </TD> <TD align="right">  </TD> </TR>
   </TABLE>



<a href="javascript:expandcollapse('solution3')">
   [+/-] Solution
</a><br>

<span class='posthidden' id='solution3'>
This dataset seems to have two problems. First, it has variables in the rows in the column `element`. Second, it has a variable `d` in the column header spread across multiple columns.
</span>


### Causes of Messiness

There are various features of messy data that one can observe in practice. Here are some of the more commonly observed patterns.

- Column headers are values, not variable names
- Multiple variables are stored in one column
- Variables are stored in both rows and columns
- Multiple types of experimental unit stored in the same table
- One type of experimental unit stored in  multiple tables

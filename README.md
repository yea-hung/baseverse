# Motivation

As [mentioned elsewhere](https://github.com/tidyverse/funs/issues/72), `case_match()` and `case_when()` do not return a factor. A [typical tidyverse solution](https://stackoverflow.com/questions/49572416/r-convert-to-factor-with-order-of-levels-same-with-case-when) for getting a factor out of `case_match()` with the levels in a desired order is something like this:
 
```r
nhanes<-nhanes %>%
  mutate(
    country=factor(
      case_match(dmdborn4,1 ~ 'USA',2 ~ 'Other'),
      levels=c('USA','Other')
    )
  )
```

In this sort of solution, we have to type the level labels twice. The first occurrence defines the label-level mapping, while the second occurrence defines the order of the levels. I think this is inefficient.

Compare the above with the following base-R solution:

```r
dmdborn4_codebook<-c('USA'=1,'Other'=2)
nhanes$country<-factor(nhanes$dmdborn4,levels=dmdborn4_codebook,
                       labels=names(dmdborn4_codebook))
```

Here, we only have to type the level labels once: that one occurrence defines both the label-level mapping and the order of the levels.

My starting principle in writing *basecase* is that one should only have to type the level labels once.

# Summary

An R package that uses base R to mimic dplyr's `case_match()` and `case_when()`. Unlike the *dplyr* functions, `base_match()` and `base_when()` will each return a factor. The desired order of the levels is honored.

# Installation

Install *remotes* if you don't already have it:

```r
install.packages('remotes')
```

Install the *baseverse* package:

```r
remotes::install_github('yea-hung/baseverse')
```

# Examples

## Data

Load the *baseverse* package, if you haven't already loaded it:

```r
library(baseverse)
```

Load the data:

```r
data('nhanes')
```

## `base_match()`

Using native piping:

```r
nhanes<-nhanes |>
  transform(country=base_match(dmdborn4,'USA'=1,'Other'=2))
```

Using dollar-sign notation:

```r
nhanes$country<-base_match(nhanes$dmdborn4,'USA'=1,'Other'=2)
```

##  `base_when()`

Using native piping:

```r
nhanes<-nhanes |>
  transform(
    cholesterol=base_when(
      'Desirable' = (lbxtc<200),
      'Borderline high' = (lbxtc>=200)&(lbxtc<240),
      'High' = (lbxtc>=240)
    )
  )
```

Using dollar-sign notation:

```r
nhanes$cholesterol<-base_when(
   'Desirable' = (nhanes$lbxtc<200),
   'Borderline high' = (nhanes$lbxtc>=200)&(nhanes$lbxtc<240),
   'High' = (nhanes$lbxtc>=240)
)
```

# Note

Despite the cute name, `base_when()` does not exactly mimic `case_when()`, and I do not intend it to. A key difference is `base_when()` will evaluate all conditions defined in `conditions` whereas `case_when()` will, for each position, stop when a condition is met.

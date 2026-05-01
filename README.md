## Overview

`baseverse` is a collection of functions intended to support the continued use of base R in the modern era. The package includes three main types of functions:

- **wrapper functions for existing base-R functions**: These begin with `p_` and support native piping. For example, `p_lm()` is a wrapper for `lm()` supporting native piping.
- **wrapper functions for existing base-R features**: These are named after the underlying symbols. For example, `dollar()` is a wrapper for dollar-sign notation.
- **functions that mimic tidyverse functions**: These include `base_match()` and `base_when()`, which mimic `case_match()` and `case_when()` from `dplyr`. Unlike their `dplyr` counterparts, `base_match()` and `base_when()` will honor the user's desired order of groups (see the discussion in the [section below](#base_match-and-base_when)). 

## Installation

The package is now available [on CRAN](https://cran.r-project.org/web/packages/baseverse/index.html)! 🥳 

To install the package from CRAN:

```r
install.packages('baseverse')
```

## Getting started

The package includes [a vignette](https://cran.r-project.org/web/packages/baseverse/vignettes/introduction.html).

## `base_match()` and `base_when()`

### Motivation

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

In this sort of solution, we have to type the level labels twice. The first occurrence defines the label-level mapping, while the second occurrence defines the order of the levels. I think this is inefficient and unnecessarily introduces the possibility of human error.

Compare the above with the following base-R solution:

```r
dmdborn4_codebook<-c('USA'=1,'Other'=2)
nhanes$country<-factor(nhanes$dmdborn4,levels=dmdborn4_codebook,
                       labels=names(dmdborn4_codebook))
```

Here, we only have to type the level labels once: that one occurrence defines both the label-level mapping and the order of the levels.

My starting principle in writing `base_match()` and `base_when()` is that one should only have to type the level labels once.

### Examples

`base_match()` using native piping:

```r
nhanes<-nhanes |>
  transform(country=base_match(dmdborn4,'USA'=1,'Other'=2))
```

`base_when()` using native piping:

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

### Further details

`base_when()` does not exactly mimic `case_when()`, and I do not intend it to. A key difference is `base_when()` will evaluate all conditions defined in `conditions` whereas `case_when()` will, for each position, stop when a condition is met.

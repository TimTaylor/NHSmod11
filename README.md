
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/TimTaylor/NHSmod11/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/TimTaylor/NHSmod11/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

# Overview

<span style="color:red"> ***This package has not yet been code reviewed
and is not yet used in production. Buyer beware*** </span>

------------------------------------------------------------------------

Minimal and efficient package to validate that a given NHS number passes
the modulo 11 check (see
<https://www.datadictionary.nhs.uk/attributes/nhs_number.html> for
details).

## Installation

The development version, which this documentation refers to, can be
installed from GitHub via

    if (!require(remotes))
        install.packages("remotes")

    remotes::install_github("TimTaylor/NHSmod11")

## Example

``` r
library(NHSmod11)

# all of these should be valid
dat1 <- c("5390502108", "2788584652", "3510670485", "4001126419", "5309741852")
is_nhs_number(dat1)
#> [1] TRUE TRUE TRUE TRUE TRUE

# these are numeric versions of above and should therefore also be valid
dat2 <- c(5390502108, 2788584652, 3510670485, 4001126419, 5309741852)
is_nhs_number(dat2)
#> [1] TRUE TRUE TRUE TRUE TRUE

# these should all be invalid unless we set the na_as_false argument as FALSE
dat3 <- c("5390502107", "2788584651", "3510670484", "4001126418", NA_character_)
is_nhs_number(dat3)
#> [1] FALSE FALSE FALSE FALSE    NA
is_nhs_number(dat3, na_as_false = FALSE)
#> [1] FALSE FALSE FALSE FALSE    NA
```

## Getting help online

Bug reports and feature requests should be posted on *GitHub* using the
[*issue system*](https://github.com/TimTaylor/NHSmod11/issues).

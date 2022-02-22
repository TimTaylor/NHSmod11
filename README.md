
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NHSmod11

<!-- badges: start -->
<!-- badges: end -->

Minimal and efficient package to validate that a given NHS number passes
the modulo 11 check (see
<https://www.datadictionary.nhs.uk/attributes/nhs_number.html> for
details).

## Installation

The development version, which this documentation refers to, can be
installed from the internal GitLab instance via

    if (!require(remotes)) install.packages("remotes")

    remotes::install_git(
        "https://gitlab.phe.gov.uk/Timothy.Taylor/NHSmod11.git",
        subdir="pkg",
        dependencies = TRUE,
        build_vignettes = TRUE
    )

## Example

``` r
library(NHSmod11)

# all of these should be valid
dat1 <- c("5390502108", "2788584652", "3510670485", "4001126419", "5309741852")
is_valid_mod11(dat1)
#> [1] TRUE TRUE TRUE TRUE TRUE

# these are numeric versions of above and should therefore also be valid
dat2 <- c(5390502108, 2788584652, 3510670485, 4001126419, 5309741852)
is_valid_mod11(dat2)
#> [1] TRUE TRUE TRUE TRUE TRUE

# these should all be invalid
dat3 <- c("5390502107", "2788584651", "3510670484", "4001126418", NA_character_)
is_valid_mod11(dat3)
#> [1] FALSE FALSE FALSE FALSE FALSE
```

## Getting help online

Bug reports and feature requests should be posted on *gitlab* using the
[*issue*
system](https://gitlab.phe.gov.uk/Timothy.Taylor/NHSmod11/issues).

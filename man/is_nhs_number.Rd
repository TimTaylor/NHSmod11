% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_nhs_number.R
\name{is_nhs_number}
\alias{is_nhs_number}
\alias{is_nhs_number.default}
\alias{is_nhs_number.numeric}
\alias{is_nhs_number.character}
\title{Validate NHS number}
\usage{
is_nhs_number(x, ...)

\method{is_nhs_number}{default}(x, ...)

\method{is_nhs_number}{numeric}(x, ...)

\method{is_nhs_number}{character}(x, ...)
}
\arguments{
\item{x}{An R object.}

\item{...}{Not currently used.}
}
\value{
A Logical vector the same length as `x`.
}
\description{
`is_nhs_number()` is a generic for testing whether input is a valid NHS
number in terms of the modulo 11 check. Methods are provided for character
and numeric input.
}
\note{
Validity is determined solely on whether of not the input passes the modulo
11 check. The number is not verified against numbers issued nor is any
additional checking of the first nine digits performed.

Character input should only contain integer values (e.g.
no hyphens or spaces).
}
\examples{
dat <- c("5390502108", NA_character_, "2788584652", "3510670484")
is_nhs_number(dat)

dat <- c(5390502108, NA_real_, 2788584652, 3510670484)
is_nhs_number(dat)

}
\seealso{
https://www.datadictionary.nhs.uk/attributes/nhs_number.html for details on
the validation algorithm.
}

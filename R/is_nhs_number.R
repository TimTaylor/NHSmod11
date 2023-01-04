#' Validate NHS number
#'
#' `is_nhs_number()` is a generic for testing whether input is a valid NHS
#' number in terms of the modulo 11 check. Methods are provided for character
#' and numeric input.
#'
#' @note
#'
#' Validity is determined solely on whether of not the input passes the modulo
#' 11 check. The number is not verified against numbers issued nor is any
#' additional checking of the first nine digits performed.
#'
#' Character input should only contain integer values (e.g.
#' no hyphens or spaces).
#'
#' @seealso
#' https://www.datadictionary.nhs.uk/attributes/nhs_number.html for details on
#' the validation algorithm.
#'
#' @param x
#' An R object.
#'
#' @param ...
#' Not currently used.
#'
#' @return A Logical vector the same length as `x`.
#'
#' @examples
#' dat <- c("5390502108", NA_character_, "2788584652", "3510670484")
#' is_nhs_number(dat)
#'
#' dat <- c(5390502108, NA_real_, 2788584652, 3510670484)
#' is_nhs_number(dat)
#'
#' @export
is_nhs_number <- function(x, ...) {
    UseMethod("is_nhs_number")
}

#' @rdname is_nhs_number
#' @export
is_nhs_number.default <- function(x, ...) {
    stop(
        sprintf(
            "Not implemented for class %s",
            paste(class(x), collapse = ", ")
        )
    )
}

#' @rdname is_nhs_number
#' @export
is_nhs_number.numeric <- function(x, ...) {
    # note 1 - it may be a little more efficient to have a dedicated integer
    # method but not all possible inputs will be valid integers (i.e. they can
    # be greater than .Machine$integer.max) as the character method already
    # provides simple handling for doubles and is still sufficiently quick it's
    # not really worth it

    # note 2 - scipen can effect the conversion so we temporally increase it
    old <- options(scipen = 999)
    on.exit(options(old), add = TRUE)
    x <- as.character(x)
    is_nhs_number.character(x, ...)
}

#' @rdname is_nhs_number
#' @export
is_nhs_number.character <- function(x, ...) {

    # number of entries to check
    n <- length(x)

    # handle zero length input
    if (n == 0L)
        return(logical(0L))

    # handle all NA case
    na_idx <- is.na(x)
    if (all(na_idx))
        return(logical(length = n))

    # handle single input
    if (n == 1L) {
        if (nchar(x) != 10L)
            return(FALSE)
        x <- strsplit(x, "", fixed = TRUE)
        x <- suppressWarnings(as.integer(x[[1]]))
        if (anyNA(x)) # integer conversion failed
            return(FALSE)
        checksum <- x[10L]
        x <- x[-10L]
        # remainder <- (11 - (sum(x * (10:2))  %% 11)) %% 11
        remainder <- (-sum(x * (10:2)))  %% 11
        return(checksum == remainder)
    }

    # convert incorrect length to NA
    not_length_10 <- nchar(x) != 10L
    x[not_length_10] <- NA_character_

    # create matrix of individual characters as integers
    x <- do.call(rbind, strsplit(x, "", fixed = TRUE))
    dat <- suppressWarnings(as.integer(x))
    dim(dat) <- dim(x)

    # pull out the checksums
    checksums <- dat[,10]

    # select only first 9 digits
    dat <- dat[,-10]

    # calculate remainders
    # remainders <- (11 - ((dat %*% (10:2))  %% 11)) %% 11
    dat <- dat %*% (10:2)
    remainders <- (-dat)  %% 11

    # identify valid entries
    valid <- checksums == remainders

    # set NA to false (invalid)
    valid[is.na(valid)] <- FALSE

    # ensure return is vector not array
    dim(valid) <- NULL

    # add back NA
    valid[na_idx] <- NA

    valid
}

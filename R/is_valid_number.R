#' Valid NHS number
#'
#' Generic for testing whether input is a valid NHS number in terms of the
#' modulo 11 check.
#'
#' Methods are provided for character and numeric input. Character input should
#' only contain integer values (e.g. no hyphens or spaces). Options are given
#' to prioritise either `speed` or `memory` usage (the default, `speed`, should
#' be fine in most circumstances).
#'
#' @note Validity is determined solely on whether of not the input passes the
#' modulo 11 check. The number is not verified against numbers issued nor is
#' any additional checking of the first nine digits performed.
#'
#' @seealso https://www.datadictionary.nhs.uk/attributes/nhs_number.html for
#'   details on the validation algorithm.
#'
#' @param x An R object.
#' @param priority `[character]` Prioritise "speed" or "memory" usage?
#' @param ... Not currently used.
#'
#' @return A Logical vector the same length as `x`.
#'
#' @export
is_valid_mod11 <- function(x, ...) {
    UseMethod("is_valid_mod11")
}

#' @rdname is_valid_mod11
#' @aliases is_valid_mod11.default
#' @export
is_valid_mod11.default <- function(x, ...) {
    stop(
        sprintf(
            "Not implemented for class %s",
            paste(class(x), collapse = ", ")
        ),
        call. = FALSE
    )
}

#' @rdname is_valid_mod11
#' @aliases is_valid_mod11.numeric
#' @export
is_valid_mod11.numeric <- function(x, priority = c("speed", "memory"), ...) {
    x <- as.character(x)
    is_valid_mod11.character(x, priority)
}

#' @rdname is_valid_mod11
#' @aliases is_valid_mod11.numeric
#' @export
is_valid_mod11.character <- function(x, priority = c("speed", "memory"), ...) {

    n <- length(x)

    # handle zero length input
    if (n == 0L)
        return(logical(0L))

    # handle single input
    if (n == 1L)
        return(.is_valid_individual(x))

    # fast version
    if (match.arg(priority) == "speed") {

        # hack to deal with the all NA case
        x <- c(x, "1234567890")

        # convert incorrect length to NA
        x[nchar(x) != 10L] <- NA_character_

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

        # remove the hack and return
        return(valid[-length(valid)])
    }

    # memory version
    vapply(x, .is_valid_individual, TRUE, USE.NAMES = FALSE)
}



.is_valid_individual <- function(x) {
    if (is.na(x) || nchar(x) != 10L)
        return(FALSE)
    x <- strsplit(x, "", fixed = TRUE)
    x <- suppressWarnings(as.integer(x[[1]]))
    if (anyNA(x)) # integer conversion failed
        return(FALSE)
    checksum <- x[10L]
    x <- x[-10L]
    # remainder <- (11 - (sum(x * (10:2))  %% 11)) %% 11
    remainder <- (-sum(x * (10:2)))  %% 11
    checksum == remainder
}

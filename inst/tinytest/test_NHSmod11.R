# tests from nhsnumber package (https://cran.r-project.org/package=nhsnumber)
dat <- c(1234567881, 1234567890, 9876543210, 2345678901)
expected <- c(TRUE, FALSE, TRUE, FALSE)
expect_identical(is_nhs_number(dat), expected)
expect_identical(is_nhs_number(as.character(dat)), expected)

# tests from nhsnumber package but with NA
dat <- c(1234567881, 1234567890, 9876543210, 2345678901, NA)
expected <- c(TRUE, FALSE, TRUE, FALSE, NA)
expect_identical(is_nhs_number(dat), expected)
expect_identical(is_nhs_number(as.character(dat)), expected)

# tests with numbers generated from http://danielbayley.uk/nhs-number/
dat <- c(
    "5390502108", "2788584652", "3510670485", "4001126419", "5309741852",
    "0572002688", "3633899960", "5149315400", "7642459904", "1299943284"
)
expected <- !logical(length(dat))
expect_identical(is_nhs_number(dat), expected)

# tests from generator numbers tweaked by one
# (as above but subtract 1 from last digit)
dat <- as.double(dat) - 1
expected <- logical(length(dat))
expect_identical(is_nhs_number(dat), expected)

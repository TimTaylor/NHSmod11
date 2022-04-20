# same as from nhsnumber package (https://cran.r-project.org/package=nhsnumber)
dat_1 <- c(1234567881, 1234567890, 9876543210, 2345678901)
expected_1 <- c(TRUE, FALSE, TRUE, FALSE)
expect_identical(is_valid_mod11(dat_1), expected_1)
expect_identical(is_valid_mod11(as.character(dat_1)), expected_1)
expect_true(is_valid_mod11(dat_1[1]))
expect_false(is_valid_mod11(dat_1[2]))

# from generator here http://danielbayley.uk/nhs-number/
dat_2 <- c("5390502108", "2788584652", "3510670485", "4001126419",
            "5309741852", "0572002688", "3633899960", "5149315400",
            "7642459904", "1299943284")
expected_2 <- rep(TRUE, length(dat_2))
expect_identical(is_valid_mod11(dat_2), expected_2)
expect_true(is_valid_mod11(dat_2[1]))

# as above but subtract 1 from last digit
dat_3 <- c("5390502107", "2788584651", "3510670484", "4001126418",
            "5309741851", "0572002687", "3633899969", "5149315409",
            "7642459903", "1299943283")
expected_3 <- rep(FALSE, length(dat_3))
expect_identical(is_valid_mod11(dat_3), expected_3)
expect_false(is_valid_mod11(dat_3[1]))

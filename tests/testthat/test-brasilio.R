test_that("Ministério da Saúde", {
  expect_is(brasilio(cache = TRUE), "tbl_df")
  expect_is(brasilio(cache = TRUE), "tbl_df")
  system("rm -r .datacovidbr/")
})

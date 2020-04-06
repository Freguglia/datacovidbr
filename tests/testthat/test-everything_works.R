test_that("Ministério da Saúde", {
  expect_is(brMinisterioSaude(), "tbl_df")
})

test_that("JHU", {
  expect_is(CSSEGISandData(TRUE), "tbl_df")
  expect_is(CSSEGISandData(FALSE), "tbl_df")
  expect_is(CSSEGISandData_us(), "tbl_df")
})

test_that("Ministério da Saúde", {
  expect_is(brasilio(), "tbl_df")
})

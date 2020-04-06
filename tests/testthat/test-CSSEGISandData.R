test_that("JHU", {
  expect_is(CSSEGISandData(TRUE), "tbl_df")
  expect_is(CSSEGISandData(FALSE), "tbl_df")
  expect_is(CSSEGISandData_us(), "tbl_df")
})
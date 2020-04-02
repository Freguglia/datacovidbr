test_that("multiplication works", {
  expect_is(brMinisterioSaude(silent = TRUE), "tbl_df")
  expect_is(CSSEGISandData(silent = TRUE), "tbl_df")
})

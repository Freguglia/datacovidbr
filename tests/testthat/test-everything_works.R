test_that("Ministério da Saúde", {
  expect_is(brMinisterioSaude(), "tbl_df")
})

test_that("JHU", {
  expect_is(CSSEGISandData(), "tbl_df")
})

test_that("Ministério da Saúde", {
  expect_is(brasilio(), "tbl_df")
})

test_that("Ministério da Saúde", {
  a <- brMinisterioSaude()
  expect_is(a, "tbl_df")
  expect_true(all(c("regiao", "estado", "municipio", "coduf",
                "codmun", "codRegiaoSaude", "nomeRegiaoSaude",
                "date", "semanaEpi", "Recuperadosnovos", 
                "populacaoTCU2019", "casosAcumulado","casosNovos",
                "obitosAcumulado", "obitosNovos",
                "Recuperadosnovos", "emAcompanhamentoNovos") %in%
                colnames(a)))
})

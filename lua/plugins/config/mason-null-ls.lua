require("mason-null-ls").setup {
  automatic_installation = {
    -- mason version has issues with GLIBC missing, use cargo
    exclude = "selene",
  },
}

return {
  cmd = {
    "clangd",
    "--background-index",
    "--enable-config",
    "--malloc-trim",
    "--header-insertion=never",
    -- INFO: remove after clangd-20
    "--function-arg-placeholders=false",
  },
}

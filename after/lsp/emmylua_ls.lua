---@type vim.lsp.Config
return {
  cmd = { "emmylua_ls", "--editor", "neovim" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}

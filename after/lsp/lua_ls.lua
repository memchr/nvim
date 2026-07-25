---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = 'Disable',
      },
      doc = {
        privateName = { '^_' },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = 'Disable',
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
      runtime = {
        version = 'LuaJIT',
      },
    },
  },
  on_init = function (client)
    -- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.emmyrc.json') or vim.uv.fs_stat(path .. '/.luarc.json')) then
        client.config.settings = {}
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = { -- (see `:h lua-module-load`)
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        -- pull neovim runtime and plugins
        library = vim.tbl_filter(
          ---@diagnostic disable-next-line: param-type-mismatch
          x -> not x:find(vim.fn.stdpath('config')),
          vim.api.nvim_get_runtime_file('', true)
        ),
      },
    })
  end,
}

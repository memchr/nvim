local H = {}

local api = vim.api

---@type vim.lsp.Config
local M = {
  -- cmd = vim.lsp.rpc.connect('localhost', 5007),
  -- TODO: diagnostics only on opened files
  -- [configuration guide](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md)
  settings = {
    emmylua = {
      completion = {
        autoRequire = false,
        callSnippet = false,
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
  end,
  ---@param client vim.lsp.Client
  on_attach = function (client, buf)
    api.nvim_buf_create_user_command(buf, 'LspEmmyluaAddNvimRuntime', function ()
      H.load_nvim_runtime(client)
    end)
    H.should_load_nvim_runtime(client, buf)
  end,
}

function H.should_load_nvim_runtime(client, buf)
  if client.__nvim_runtime_loaded then
    return
  end
  local bufpath = api.nvim_buf_get_name(buf)

  -- load nvim runtime when
  if vim.fs.basename(bufpath) == '.nvim.lua' -- editing .nvim.lua
    or vim.iter({
      vim.fn.stdpath('config'),
      vim.fn.stdpath('data'),
      unpack(vim.fn.stdpath('data_dirs')),
      unpack(vim.fn.stdpath('config_dirs')),
    }):any(x -> bufpath:sub(1, #x) == x) -- inside one of stdpath
  then
    H.load_nvim_runtime(client)
    client.__nvim_runtime_loaded = true
  end
end

--- notify language server to load neovim runtime and plugins into workspace
---@param client vim.lsp.Client
function H.load_nvim_runtime(client)
  client.settings.emmylua = vim.tbl_deep_extend('force', client.settings.emmylua, {
    runtime = {
      version = 'LuaJIT',
      requirePattern = { -- (see `:h lua-module-load`)
        'lua/?.lua',
        'lua/?/init.lua',
      },
    },
    diagnostics = { globals = { 'vim' } },
    workspace = {
      -- HACK: for some reason emmylua_ls doesn't provide diagnostics for library nested in root_dir
      library = vim.tbl_filter(
        x -> x ~= vim.fs.joinpath(vim.fn.stdpath('config'), 'after'),
        api.nvim_get_runtime_file('', true)
      ),
    },
  })
  client:notify('workspace/didChangeConfiguration', { settings = client.settings })
end

return M

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- lsp
    -- TODO: lazy loading
    -- TODO: move to another file
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        -- FIXME: to lazy load cmp, make a capabilities object yourself
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local servers = {
          clangd = {},
          pyright = {},
        }

        for server, config in pairs(servers) do
          config.capabilities = capabilities
          lspconfig[server].setup(config)
        end
      end,
    },
    -- completion
    {
      -- wiki: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
      "hrsh7th/nvim-cmp",
      lazy = false,
      config = function ()
        require("conf.cmp").setup()
      end,
      dependencies = {
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        { "https://codeberg.org/FelipeLema/cmp-async-path", pin = true },
      }
    },
    -- syntax highlighting using treesitter
    {
      -- doc: https://github.com/nvim-treesitter/nvim-treesitter
      -- wiki: https://github.com/nvim-treesitter/nvim-treesitter/wiki
      -- it also supports:
      -- - Statusline indicator
      -- see doc for more
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require 'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all" (the listed parsers MUST always be installed)
          ensure_installed = { "c", "cpp", "rust", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          -- List of parsers to ignore installing (or "all")
          -- ignore_install = { "javascript" },

          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

          highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            -- disable = function(lang, buf)
            --   local max_filesize = 100 * 1024 -- 100 KB
            --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --   if ok and stats and stats.size > max_filesize then
            --     return true
            --   end
            -- end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a **list of languages**
            additional_vim_regex_highlighting = false,
          },
          -- Incremental selection based on the named nodes from the grammar.
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn", -- set to `false` to disable one of the mappings
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
          indent = {
            enable = true
          }
        }
        -- Tree-sitter based folding (implemented in Neovim itself, see :h vim.treesitter.foldexpr()). To enable it for the current window, set
        -- vim.wo.foldmethod = 'expr'
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end
    },
    -- zk
    -- TODO: checkout nvim-lspconfig for zk
    -- TODO: checkout other zk plugins
    {
      "mickael-menu/zk-nvim",
      main = "zk",
      opts = {
        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },

      }
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
})

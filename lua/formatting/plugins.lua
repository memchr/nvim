---@module "lazy"
---@type LazySpec[]
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      -- disable format on save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
    keys = {
      {
        "=f",
        function()
          require("conform").format({ async = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    --- @module "conform"
    --- @type conform.setupOpts
    opts = {
      format_on_save = function(bufnr)
        -- disable format on save
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        -- disable autoformat on certain filetypes
        local ignored_ft = {}
        if vim.list_contains(ignored_ft, vim.bo[bufnr].filetype) then
          return
        end

        -- disable for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)

        if bufname:match("/node_modules/") then
          return
        end

        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua", lsp_format = "never" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        markdown = { "deno_fmt" },
      },
    },
  },
}

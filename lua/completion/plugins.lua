---@type LazySpec[]
return {
  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        -- Fallback to nvi-cmp's highlight groups. compatibility
        use_nvim_cmp_as_default = true,

        nerd_font_variant = "normal",
      },
      completion = {
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 250 },

        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        -- Display a preview of the selected item on the current line
        -- TODO: enable
        -- ghost_text = { enabled = true },
      },
      cmdline = {
        keymap = {
          preset = "super-tab",
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
        },
        completion = { menu = { auto_show = true } },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      fuzzy = {
        implementation = "rust",
        prebuilt_binaries = {
          -- prefer build binary locally
          download = false,
        },
      },
      -- Experimental signature help support
      signature = {
        enabled = true,
      },
    },
  },
}

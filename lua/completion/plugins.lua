---@module 'blink.cmp'
---@type blink.cmp.Config
local blink_opts = {
  keymap = { preset = "super-tab" },
  appearance = {
    -- Fallback to nvi-cmp's highlight groups. compatibility
    use_nvim_cmp_as_default = true,

    nerd_font_variant = "normal",
  },
  completion = {
    -- Show documentation when selecting a completion item
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 1000,
      update_delay_ms = 100,
    },

    -- use treesitter to highlight the label text
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    -- Display a preview of the selected item on the current line
    -- TODO: enable
    -- ghost_text = { enabled = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      },
      path = {
        opts = {
          show_hidden_files_by_default = true,
        },
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
  -- Experimental signature help support
  signature = {
    enabled = true,
    window = {
      -- Press <C-s> (built-in) to show docs
      show_documentation = false,
    },
  },
  fuzzy = {
    implementation = "rust",
    prebuilt_binaries = {
      -- prefer build binary locally
      download = false,
    },
  },
  cmdline = {
    keymap = {
      preset = "super-tab",
      -- TODO: map arrow keys to history search
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
    },
    completion = { menu = { auto_show = true } },
  },
}

---@module "lazy"
---@type LazySpec[]
return {
  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = blink_opts,
  },
}

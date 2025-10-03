local MAX_LAG_MS = 150
local function accept_index(n)
  return {
    function(cmp)
      cmp.accept({ index = n })
    end,
  }
end

---@module 'blink.cmp'
---@type blink.cmp.Config
local blink_opts = {
  keymap = {
    preset = "super-tab",
    ["<A-1>"] = accept_index(1),
    ["<A-2>"] = accept_index(2),
    ["<A-3>"] = accept_index(3),
    ["<A-4>"] = accept_index(4),
    ["<A-5>"] = accept_index(5),
  },
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
      auto_show_delay_ms = 80,
    },
    -- Display a preview of the selected item on the current line
    -- TODO: enable
    -- ghost_text = { enabled = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        -- After this timeout, show the completion menu before this provider returns. i.e. treating it as async
        timeout_ms = MAX_LAG_MS,
      },
      path = {
        opts = {
          show_hidden_files_by_default = true,
        },
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        timeout_ms = MAX_LAG_MS,
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
      ["<Tab>"] = { "select_and_accept", "fallback" },
      -- ["<CR>"] = { "accept_and_enter", "fallback" },
      ["<Right>"] = {},
      ["<Left>"] = {},
    },
    completion = { menu = { auto_show = true } },
  },
}

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

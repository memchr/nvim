---@module "lazy"
---@type LazySpec[]
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<c-p>"] = "focus_preview",
          ["<c-f>"] = { "scroll_preview", config = { direction = -20 } },
          ["<c-b>"] = { "scroll_preview", config = { direction = 20 } },
          ["\\"] = "close_window",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
}

---@module "lazy"
---@type LazySpec[]
return {
  {
    "ibhagwan/fzf-lua",
    init = function()
      ---@diagnostic disable-next-line
      vim.ui.select = function(...)
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end,
    opts = {},
  },
}

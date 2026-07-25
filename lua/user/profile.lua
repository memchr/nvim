--- performance profiling

local M = {}

function M.setup()
  if vim.env.PROF then
    local snacks = vim.fn.stdpath('data') .. '/site/pack/core/opt/snacks.nvim'
    vim.opt.rtp:append(snacks)
    ---@diagnostic disable-next-line: missing-fields, param-type-mismatch
    require('snacks.profiler').startup({
      presets = {
        startup = { min_time = 1, sort = false },
      },
      startup = {
        event = 'UIEnter',
      },
    })
  end
end
return M

local M = {}
local hrtime = vim.uv.hrtime

---Mesure runtime of funciton in nanoseconds
---@param fn function
---@return number
function M.measure_ns(fn)
  local start = hrtime()
  local diff = hrtime() - start
  start = hrtime()
  fn()
  return hrtime() - start - diff
end

---Mesure runtime of funciton in microseconds
---@param fn function
---@return number
function M.measure_ms(fn)
  return M.measure_ns(fn) / 1e6
end

return M

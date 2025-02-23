local M = {}

local log_dir = vim.api.nvim_call_function("stdpath", { "log" })
local levels = vim.log.levels

local default_config = {
  name = "nvim",
}

-- Create a new logger function, which accepts a formatstring and variable
-- number of arguments
function M.new(config)
  config = vim.tbl_deep_extend("force", default_config, config or {})
  local log_file_path = vim.fs.joinpath(log_dir, config.name .. ".log")
  local log_file = io.open(log_file_path, "a+")
  if not log_file then
    vim.notify("Cloud not open log file: " .. log_file_path, levels.ERROR)
    return function()
      vim.notify("Logger initialization failed: " .. config.name, levels.ERROR)
    end
  end

  local log_queue = {}
  local is_logging = false

  local function write_log()
    while #log_queue > 0 do
      local entry = table.remove(log_queue, 1)
      log_file:write(entry)
      log_file:flush()
    end
    is_logging = false
  end

  return function(format, ...)
    local timestamp = os.time()
    local log_str
    if type(format) == "table" then
      log_str = vim.inspect(format)
    else
      log_str = string.format(format, ...)
    end

    local entry = string.format("%s [%d] ", config.name, timestamp) .. log_str .. "\n"
    table.insert(log_queue, entry)

    if not is_logging then
      is_logging = true
      vim.schedule(write_log)
    end
  end
end

return M

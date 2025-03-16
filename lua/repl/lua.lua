local api = vim.api
local output = {
  --- @type integer
  window = nil,
  --- @type integer
  buffer = nil,
  line_count = 0,
}

function output.init()
  if not output.buffer then
    output.buffer = api.nvim_create_buf(false, true)
    api.nvim_buf_set_name(output.buffer, "output")
  end

  if not output.window or not api.nvim_win_is_valid(output.window) then
    output.window = vim.api.nvim_open_win(output.buffer, false, {
      split = "below",
      width = vim.o.columns,
      height = 15,
    })
    api.nvim_set_option_value("number", false, {
      win = output.window,
    })
    vim.keymap.set({ "n", "v" }, "q", function()
      if api.nvim_win_is_valid(output.window) then
        api.nvim_win_hide(output.window)
      end
    end, {
      buffer = output.buffer,
    })
  end
  output.line_count = 0
  api.nvim_buf_set_lines(output.buffer, 0, -1, false, {})
end

function output.writelines(lines, scheduled)
  if vim.in_fast_event() and not scheduled then
    vim.schedule(function()
      output.writelines(lines, true)
    end)
  else
    api.nvim_buf_set_lines(output.buffer, output.line_count, -1, false, lines)
    output.line_count = output.line_count + #lines
  end
end

function output.print(...)
  ---@type string[]
  local msg = {}
  for _, x in ipairs({ ... }) do
    table.insert(msg, type(x) == "string" and x or vim.inspect(x))
  end
  output.writelines(vim.split(table.concat(msg, " "), "\n", { plain = true }))
end

local function luabuf()
  local content = table.concat(api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  local code = loadstring(content)
  local env = getfenv(code)
  env.print = output.print

  output.init()
  code()
end

api.nvim_create_autocmd("BufEnter", {
  pattern = "*.lua",
  callback = function()
    vim.keymap.set({ "n", "i" }, "<c-a-n>", luabuf, nil)
  end,
})

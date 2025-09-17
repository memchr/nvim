-- # Strings
local STRING_FORMAT_MAX_PAD = 99

---Right pad multiple lines
---@return string
function string:pad_lines_right()
  local lines = vim.split(self, "\n")
  local max = 0
  for _, L in ipairs(lines) do
    if #L > STRING_FORMAT_MAX_PAD then
      max = 99
      break
    end
    if #L > max then
      max = #L
    end
  end
  for i = 1, #lines do
    lines[i] = string.format("%-" .. max .. "s", lines[i])
  end
  return table.concat(lines, "\n")
end

local monkey = require("monkey")
local M = {}

local function patch(Query)
  ---@param self vim.treesitter.Query
  monkey.patch(Query, "iter_captures", function(iter_captures, self, ...)
    ---@type fun(string): ...
    local iter = iter_captures(self, ...)

    local priorities = M.priorities[self.lang]
    -- no priorities override
    if priorities == nil then
      return iter
    end

    return function(end_line)
      local capture, captured_node, metadata, match, tree = iter(end_line)
      if capture ~= nil then
        local name = self.captures[capture]
        local priority = priorities[name]
        if priority ~= nil then
          metadata.priority = priority
        end
      end
      return capture, captured_node, metadata, match, tree
    end
  end)
end

function M.override(priorities)
  M.priorities = priorities

  -- indirectly obtain reference to vim.treesitter.Query
  monkey.patch_once(vim.treesitter.highlighter, "new", function(new, tree, opts)
    ---@type vim.treesitter.highlighter
    local h = new(tree, opts)
    patch(getmetatable(h:get_query(tree:lang()):query()))
    return h
  end)
end

return M

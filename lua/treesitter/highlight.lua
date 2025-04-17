local M = {}

---@param Query vim.treesitter.Query
local function patch(Query)
  local iter_captures_orig = Query.iter_captures

  function Query:iter_captures(node, source, start, stop, opts)
    local iter = iter_captures_orig(self, node, source, start, stop, opts)
    ---@type table<integer, integer>
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
  end
end

function M.override(priorities)
  M.priorities = priorities
  local new_orig = vim.treesitter.highlighter.new
  function vim.treesitter.highlighter.new(tree, opts)
    local h = new_orig(tree, opts)
    local ok, query = pcall(h.get_query, h, tree:lang())
    if ok then
      patch(getmetatable(query:query()))
      vim.treesitter.highlighter.new = new_orig
    end
    return h
  end
end

return M

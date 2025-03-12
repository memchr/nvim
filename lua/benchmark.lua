local takes = 1000

---@param payload fun(): nil
---@param iteration integer
return function(payload, iteration)
  local runs = {}
  for take = 1, takes do
    local start = os.clock()
    for _ = 1, iteration do
      payload()
    end
    table.insert(runs, os.clock() - start)
  end
  local s = vim.iter(runs):fold({ sum = 0 }, function(acc, v)
    acc.sum = acc.sum + v
    acc.min = math.min(v, acc.min or v)
    acc.max = math.max(v, acc.max or v)
    return acc
  end)
  return {
    min = s.min,
    max = s.max,
    avg = s.sum / takes,
    med = runs[math.floor(takes / 2)],
  }
end

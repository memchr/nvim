local monkey = {}
---Monkey patch
---@param M table model to monkey patch
---@param func string function name
---@param new fun(orig: function, ...): any replacement function
function monkey.patch(M, func, new)
  ---@type function
  local orig = M[func]
  M[func] = function(...)
    return new(orig, ...)
  end
end

---Monkey patch once, then restore the original functoin
---@param M table model to monkey patch
---@param func string function name
---@param new fun(orig: function, ...): any replacement function
function monkey.patch_once(M, func, new)
  ---@type function
  local orig = M[func]
  M[func] = function(...)
    local ok, r = pcall(new, orig, ...)
    if ok then
      M[func] = orig
    end
    return r
  end
end

return monkey

---@class Stack<T>
---@field private _items table[]
---@field private _head integer
---@field private _cap integer
---@overload fun(self): table?
local Stack = {}

--- Adds an item, overriding the oldest item if the history is full.
---@generic T
---@param item T
function Stack:push(item)
  self._size = math.min(self._size + 1, self._cap)
  self._items[self._head] = item
  self._head = self._head % self._cap + 1
end

--- Pop the last element
---@return any
function Stack:pop()
  if self._size == 0 then
    return nil
  end
  self._size = self._size - 1
  self._head = (self._head - 2) % self._cap + 1
  return self._items[self._head]
end

--- Get nth item in the History
---@param n integer
---@return any
function Stack:peek(n)
  return self._items[(self._head - 1 - n) % self._cap + 1]
end

--- Find the nth item in the stack that meets condition f, without modifiying it
---@param f any
---@param n integer?
---@return any
function Stack:find(f, n)
  n = n or 1
  if type(f) ~= "function" then
    local val = f
    f = function(v)
      return v == val
    end
  end
  for i = 1, self._cap do
    local item = self:peek(i)
    if f(item) then
      n = n - 1
      if n == 0 then
        return item
      end
    end
  end
  return nil
end

--- Create a circular stack limited to maximal number of items.
---@param cap integer
return function(cap)
  local history = {
    _items = {},
    _cap = cap,
    _size = 0,
    _head = 1,
  }
  return setmetatable(history, {
    __index = Stack,
    __call = Stack.pop,
  })
end

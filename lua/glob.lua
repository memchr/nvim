---@diagnostic disable: undefined-field

local ffi = require("ffi")

ffi.cdef([[
typedef struct {
    size_t   gl_pathc;    /* Count of paths matched so far  */
    char   **gl_pathv;    /* List of matched pathnames       */
    size_t   gl_offs;     /* Slots to reserve in gl_pathv    */
    int      gl_flags;    /* Flags  */
    void    *gl_private;  /* Private data for `globfree'    */
} glob_t;

int glob(const char *pattern, int flags, int (*errfunc) (const char *epath, int eerrno), glob_t *pglob);
void globfree(glob_t *pglob);
]])

local glob = ffi.C.glob
local globfree = ffi.C.globfree

local M = {}

---@class GlobResult
---@field buf userdata
---@field pathc integer
---@field pathv userdata[]

---@param s GlobResult
local function iter(s, i)
  if i == s.pathc then
    globfree(s.buf)
    return nil
  end
  local path = ffi.string(s.pathv[i])
  i = i + 1
  return i, path
end

--[[
glob(3) from libc, usually 2 times faster than using vim.fn.glob
Usage
```lua
for _, path in glob(ptn) do
  dosomething(path)
end
```
--]]
function M.glob(pattern)
  local globbuf = ffi.new("glob_t")
  if glob(pattern, 0, nil, globbuf) == 0 then
    local s = {
      buf = globbuf,
      pathc = tonumber(globbuf.gl_pathc),
      pathv = globbuf.gl_pathv,
    }
    return iter, s, 0
  else
    return nil
  end
end

return M

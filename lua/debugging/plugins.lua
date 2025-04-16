---@diagnostic disable: undefined-field
---@module "lazy"
---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.delve = function(callback, config)
        if config.mode == "remote" and config.request == "attach" then
          callback({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or "38697",
          })
        else
          callback({
            type = "server",
            port = "${port}",
            executable = {
              command = "dlv",
              args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
              detached = vim.fn.has("win32") == 0,
            },
          })
        end
      end
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap", -- adjust as needed, must be absolute path
        name = "lldb",
      }
      dap.configurations.c = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
          outputMode = "remote",
          -- console = "integratedTerminal",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
      ---@param last boolean
      local function continue(last)
        if not dap.session() then
          vim.cmd.write()
        end
        if last then
          dap.run_last()
        else
          dap.continue()
        end
      end

      vim.keymap.set("n", "<F5>", function()
        continue(false)
      end)
      vim.keymap.set("n", "<F17>", function()
        dap.terminate({ hierarchy = true })
      end)
      vim.keymap.set("n", "<F10>", function()
        require("dap").step_over()
      end)
      vim.keymap.set("n", "<F11>", function()
        require("dap").step_into()
      end)
      vim.keymap.set("n", "<F12>", function()
        require("dap").step_out()
      end)
      vim.keymap.set("n", "gb", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "gl", function() -- logpoint
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Create logpoint" })
      vim.keymap.set("n", "gro", function()
        require("dap").repl.open({
          height = 16,
        })
      end, { desc = "Open Repl" })
      vim.keymap.set("n", "<Leader>dl", function()
        continue(true)
      end)
      vim.keymap.set("n", "<F29>", function()
        continue(true)
      end)
      vim.keymap.set("n", "<C-F5>", function()
        continue(true)
      end)
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "hover" })
      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end, { desc = "preview" })
      vim.keymap.set("n", "<Leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end, { desc = "frames" })
      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "scopes" })
    end,
  },
}

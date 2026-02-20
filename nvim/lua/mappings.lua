require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Run Python with <leader>rp
map("n", "<leader>rp", function()
  vim.cmd "write"
  local file = vim.fn.expand "%"
  -- This runs the code and then adds a pause command
  local cmd = string.format('silent !start cmd /C "python %s && pause"', file)
  vim.cmd(cmd)
end, { desc = "Python: Run and Pause" })



map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

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

-- Compile and Run C file in a new external terminal (Windows)
vim.keymap.set("n", "<F5>", function()
    -- Save the file first so you don't run old code
    vim.cmd("w")

    -- 1. Get current file name (e.g., "hello world.c")
    local file = vim.fn.expand("%")
    -- 2. Get file name without extension (e.g., "hello world")
    local exe = vim.fn.expand("%:r")

    -- 3. Build the Windows command
    -- 'start cmd /c' opens a new window
    -- Quotes "" are added around variables to handle file paths with spaces
    local cmd = string.format('start cmd /c "gcc "%s" -o "%s" && "%s" & pause"', file, exe, exe)

    -- 4. Execute silently
    vim.cmd("silent !" .. cmd)
end, { desc = "Compile and Run C" })

-- Compile and run using MSVC
vim.keymap.set("n", "<F6>", function()
    -- 1. Save the file
    vim.cmd("w")

    -- 2. Define the path to your VS setup script
    --    CHANGE THIS PATH to match your installation!
    --    Note: Use double backslashes \\ for Windows paths in Lua
    local vs_script =
        "C:\\Program Files (x86)\\Microsoft Visual Studio\\18\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat"

    -- 3. Get file info
    local file = vim.fn.expand("%")
    local exe_name = vim.fn.expand("%:r") .. ".exe"

    -- 4. Construct the command
    --    start cmd /c  -> Opens new window
    --    call "..."    -> Runs the environment script to fix include paths
    --    && cl ...     -> Compiles only if env setup worked
    --       /nologo    -> Hides the copyright banner
    --       /Fe:       -> Specifies the output executable name
    --    && ...        -> Runs the generated exe
    local cmd = string.format(
        'start cmd /c "call "%s" && cl /nologo "%s" /Fe:"%s" && "%s" & pause"',
        vs_script,
        file,
        exe_name,
        exe_name
    )

    -- 5. Execute
    vim.cmd("silent !" .. cmd)
end, { desc = "Compile with MSVC (cl.exe)" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


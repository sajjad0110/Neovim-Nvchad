-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------
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


--------------------------------------------------------------------------------------
-- Compile and Run C in a separate Linux Terminal
vim.keymap.set("n", "<F5>", function()
    -- 1. Save the file
    vim.cmd("w")

    -- 2. SET YOUR TERMINAL HERE
    -- Common options: "alacritty", "konsole", "kitty", "gnome-terminal", "wezterm"
    -- CachyOS usually defaults to "alacritty"
    local term = "alacritty"

    -- 3. Get file info
    local file = vim.fn.expand("%")
    local exe = vim.fn.expand("%:r")

    -- 4. Create the bash command
    --    gcc compiles it
    --    && ./exe runs it (Linux requires ./ to run local files)
    --    ; read ... pauses the window so it doesn't close immediately
    local bash_cmd =
        string.format("gcc '%s' -o '%s' && ./'%s'; echo ''; echo 'Press Enter to close...'; read", file, exe, exe)

    -- 5. Execute based on the terminal
    --    Most terminals (Alacritty, Konsole, XTerm) use -e to execute a command
    local final_cmd = string.format('%s -e bash -c "%s"', term, bash_cmd)

    -- Special case for Kitty (if you use it)
    if term == "kitty" then
        final_cmd = string.format('kitty bash -c "%s"', bash_cmd)
    end

    -- 6. Run the command detached (so Neovim doesn't freeze)
    vim.fn.jobstart(final_cmd, { detach = true })
end, { desc = "Compile and Run C (Linux)" })


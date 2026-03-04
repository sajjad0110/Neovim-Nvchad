require "nvchad.options"

-- add yours here!

-- Set the default font for GUI nvim clients like neovide etc.
vim.o.guifont = "Comic Code:h12"

-- Set the line height
vim.o.linespace = 10

-- Make line numbers default 
-- vim.o.number = true -- Commenting it out because nvchad automatically has linenumbers enabled
-- Relative line numbers
vim.o.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Set wordwrap to true
vim.opt.wrap = true
vim.opt.linebreak = true -- Prevents breaking in the middle of a word
vim.opt.breakindent = true -- Indents wrapped lines to match the start of the line


-- Gemini way of getting similar feature to "scroll beyond last line"
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("CenterLastLine", { clear = true }),
  callback = function()
    local last_line = vim.fn.line("$")
    local curr_line = vim.fn.line(".")
    if curr_line == last_line then
      vim.cmd("normal! zz")
    end
  end,
})
-- 1. Define your cursor styles
-- n-v-c: Normal, Visual, Command-line (Block cursor)
-- i-ci-ve: Insert, Command-line Insert, Visual-exclude (Vertical bar)
-- blinkwait: Delay before blinking starts
-- blinkon/blinkoff: Duration of the blink phases

local active_cursor = "n-v-c:block-Cursor/lCursor-blinkwait700-blinkon500-blinkoff500,i-ci-ve:ver25-Cursor/lCursor-blinkwait300-blinkon600-blinkoff600,r-cr:hor20,o:hor50"
local inactive_cursor = "a:blinkon0" -- 'a' stands for all modes; blinkon0 disables blinking

-- Set the initial state
vim.opt.guicursor = active_cursor

-- 2. Handle Focus for Windows 10 / Neovide
-- This ensures the cursor stops blinking when you switch to another app
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.guicursor = active_cursor
    end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    pattern = "*",
    callback = function()
        vim.opt.guicursor = inactive_cursor
    end,
})

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.13 -- Default is 0.13, increase for "softer" movement
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_smooth_blink = true 


    -- Progress bar settings
    vim.g.neovide_progress_bar_enabled = true -- enables the bar 
    vim.g.neovide_progress_bar_height = 5.0 -- sets the height of bar 
    vim.g.neovide_progress_bar_animation_speed = 200.0 -- speed 
    vim.g.neovide_progress_bar_hide_delay = 0.2 -- sets the delay in seconds before the progress bar is hidden after reaching 100%
    
    -- Hiding the mouse as soon as you start typing
    -- moving the mouse makes it visible again
    vim.g.neovide_hide_mouse_when_typing = true 
    
    -- Setting the refresh rate of the app
    vim.g.neovide_refresh_rate = 60
    
    -- Animate the cursor in insert mode
    vim.g.neovide_cursor_animate_in_insert_mode = true
    
    -- Specify cursor outline width while window is unfocused (in em)
    -- should be > 0 [=<0 == invisible]. 
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    
    -- Set padding 
    vim.g.neovide_padding_top = 10 
    vim.g.neovide_padding_bottom = 10 
    vim.g.neovide_padding_right = 28
    vim.g.neovide_padding_left = 0 
    
    -- Disable/enable Ligatures
    --vim.g.neovide_font_features = {
    --    ["Monaspace Argon NF"] = {
    --        "calt",     -- Texture Healing
    --        "liga",     -- Standard Ligatures
    --    }, 
    --    ["Monaspace Xenon NF"] = {
    --        "calt",
    --        "liga"
    --    },
    --}


end




-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


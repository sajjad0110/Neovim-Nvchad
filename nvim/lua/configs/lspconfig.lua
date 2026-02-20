-- 1. Load the NvChad defaults (still required for UI/mappings)
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- 2. Define your list of servers
local servers = { "html", "cssls", "pyright", "ruff" }

-- 3. Use the NEW native way to initialize them (Fixes the deprecation error)
for _, lsp in ipairs(servers) do
  local config = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Pyright-specific optimizations we discussed earlier
  if lsp == "pyright" then
    config.settings = {
      pyright = { disableOrganizeImports = true },
      python = { analysis = { ignore = { '*' } } },
    }
  end

  -- NEW API CALLS (Replacing .setup)
  vim.lsp.config(lsp, config) -- Defines the configuration
  vim.lsp.enable(lsp)         -- Activates the server
end

-- read :h vim.lsp.config for changing options of lsp servers 

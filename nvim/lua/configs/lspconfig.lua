local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- Add servers here; mason will ensure they're installed (see plugins/init.lua)
local servers = { "html", "cssls", "ts_ls", "pyright", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

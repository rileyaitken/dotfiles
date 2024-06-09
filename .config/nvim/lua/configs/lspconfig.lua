local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require "lspconfig/util"

local lspconfig = require "lspconfig"
local servers = { "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
  })
end

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true,
      }
    }
  }
})

local ok, mason_registry = pcall(require, 'mason-registry')
if not ok then
    vim.notify 'mason-registry could not be loaded'
    return
end

local angularls_path =
    mason_registry.get_package('angular-language-server'):get_install_path()

local cmd = {
    'ngserver',
    '--stdio',
    '--tsProbeLocations',
    table.concat({
        angularls_path,
        vim.uv.cwd(),
    }, ','),
    '--ngProbeLocations',
    table.concat({
        angularls_path .. '/node_modules/@angular/language-server',
        vim.uv.cwd(),
    }, ','),
}

lspconfig.angularls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = cmd,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
})

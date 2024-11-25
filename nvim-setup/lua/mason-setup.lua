require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "pyright" } -- Automatically install Pyright
})
require('lspconfig').pyright.setup{}


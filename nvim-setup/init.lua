local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Fix JSON
    { "rhysd/vim-fixjson", ft = { "json" } },
    { "pseewald/vim-anyfold", ft = { "json" } },
    
    -- Vim-dadbod plugins
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",

    -- LSP and completion
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Miscellaneous
    "numToStr/Comment.nvim",
    { "linux-cultist/venv-selector.nvim", version = "*" },

    -- Telescope
    "nvim-telescope/telescope.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",

    -- Colorschemes
    "folke/tokyonight.nvim",
    -- "ellisonleao/gruvbox.nvim",
    -- "navarasu/onedark.nvim",
    -- { "catppuccin/nvim", name = "catppuccin" },
    -- "shaunsingh/nord.nvim",
    -- "sainnhe/everforest",

    -- Treesitter
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     build = ":TSUpdate",
    -- },

    -- Lazy.nvim (if you want to keep it for managing itself)
    --"folke/lazy.nvim",

    "dstein64/vim-startuptime"
})

-- Setup git-path with the associated Python environment
local vim_setup_path = vim.fn.stdpath('config')
vim.env.PYTHONPATH = vim_setup_path .. '/py:' .. (vim.env.PYTHONPATH or '')
vim.g.python3_host_prog = vim_setup_path .. "/.venv/bin/python3"

-- Setup per module
require('cmp-setup')
require('mason-setup')
require('comment-setup')
require('venv-setup')
require('color-setup')
require('dadbod-setup')


vim.cmd('source ~/.config/nvim/post-lua-init.vim')

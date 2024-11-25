set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#add('rhysd/vim-fixjson', {'lazy' : 0,  'autoload' : {'filetypes' : 'json'}})
call neobundle#add('pseewald/vim-anyfold', {'lazy' : 0,  'autoload' : {'filetypes' : 'json'}})
call neobundle#add('tpope/vim-dadbod')
call neobundle#add('kristijanhusak/vim-dadbod-ui')
call neobundle#add('kristijanhusak/vim-dadbod-completion')
call neobundle#add('neovim/nvim-lspconfig')
call neobundle#add('hrsh7th/cmp-nvim-lsp')
call neobundle#add('hrsh7th/cmp-buffer')
call neobundle#add('hrsh7th/cmp-path')
call neobundle#add('hrsh7th/cmp-cmdline')
call neobundle#add('hrsh7th/nvim-cmp')
call neobundle#add('williamboman/mason.nvim')
call neobundle#add('williamboman/mason-lspconfig.nvim')
call neobundle#add('numToStr/Comment.nvim')
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

lua require('cmp-setup')
lua require('mason-setup')
lua require('comment-setup')

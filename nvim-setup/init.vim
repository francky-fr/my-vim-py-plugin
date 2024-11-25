" neobundle
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
call neobundle#add('linux-cultist/venv-selector.nvim', {'rev' : 'regexp'})
call neobundle#add('nvim-telescope/telescope.nvim')
call neobundle#add('nvim-lua/popup.nvim')
call neobundle#add('nvim-lua/plenary.nvim')
call neobundle#add('ellisonleao/gruvbox.nvim')
call neobundle#add('folke/tokyonight.nvim')
call neobundle#add('navarasu/onedark.nvim')
call neobundle#add('catppuccin/nvim', {'as': 'catppuccin'})
call neobundle#add('shaunsingh/nord.nvim')
call neobundle#add('sainnhe/everforest')
call neobundle#add('nvim-treesitter/nvim-treesitter')
call neobundle#end()
NeoBundleCheck

" set background=light
"

" Setup git-path with the associated env
let s:vim_py_plugin_path = expand('~/git_rep/my-vim-py-plugin/')
let $PYTHONPATH = s:vim_py_plugin_path . ':' . (exists('$PYTHONPATH') ? $PYTHONPATH : '')
let g:python3_host_prog = s:vim_py_plugin_path . ".venv/bin/python3"

" Import lua setup
lua require('cmp-setup')
lua require('mason-setup')
lua require('comment-setup')
lua require('venv-setup')
lua require('color-setup')

let s:themes = ['gruvbox', 'tokyonight', 'catppuccin', 'onedark', 'nord', 'everforest']
let g:current_theme = 0

command! CycleColorscheme call s:CycleColors()

function! s:CycleColors()
  let g:current_theme = (g:current_theme + 1) % len(s:themes)
  execute 'colorscheme ' . s:themes[g:current_theme]
  echo 'Switched to ' . s:themes[g:current_theme]
endfunction


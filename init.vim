if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = '~/.config' | endif
if empty($NVIM_DIR) | let $NVIM_DIR = $XDG_CONFIG_HOME . "/nvim" | endif

if empty(glob("$NVIM_DIR/autoload/plug.vim"))
  if empty(glob("$NVIM_DIR/autoload")) | silent exec "!mkdir $NVIM_DIR/autoload" | endif

  silent exec "!curl -fLo $NVIM_DIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:rc = ["vars", "utils", "mappings", "settings"]
let g:imports = map(g:rc, "v:val . '.vim'")

if !exists("*Init")
  fun! Init (reset)
    if a:reset
      call feedkeys("\<space>r")

      exec "so $NVIM_DIR/init.vim"

      echo "Reset"
    else
      for i in g:imports | exec "so $NVIM_DIR/" . i | endfor
    endif

    call SetColours()
  endfunction
endif

call plug#begin("$NVIM_DIR/plug")

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pangloss/vim-javascript'
Plug 'leafoftree/vim-vue-plugin'
Plug 'shougo/context_filetype.vim'
Plug 'rakr/vim-one'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'moll/vim-bbye'
Plug 'blueyed/vim-diminactive'
Plug 'tpope/vim-rails'
Plug 'sheerun/vim-polyglot'
Plug 'tyru/caw.vim'
Plug 'othree/eregex.vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-fugitive'
Plug 'andrewradev/splitjoin.vim'
Plug 'tpope/vim-dispatch'
Plug 'janko/vim-test'
Plug 'simnalamburt/vim-mundo'
Plug 'honza/vim-snippets'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
" Plug 'jacoborus/tender.vim'
" Plug 'dikiaap/minimalist'
" Plug 'romainl/Apprentice'
" Plug 'sirver/ultisnips'

call plug#end()
call Init(0)

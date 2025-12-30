let mapleader = " "
filetype plugin indent on
call plug#begin()
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf' 
    Plug 'junegunn/fzf.vim'
    Plug 'liuchengxu/vim-which-key'
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
    Plug 'kristijanhusak/vim-dadbod-completion'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'bkad/CamelCaseMotion'
    Plug 'wellle/targets.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500
let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline_section_z = 0
let g:airline_section_y = 0
let g:airline#extensions#whitespace#enabled = 0
" --- CONFIGURAÇÕES BÁSICAS (Estilo IDE) ---
set nocompatible            " Desativa compatibilidade com vi antigo
"filetype plugin indent on   " Detecta tipo de arquivo e indentação
syntax on                   " Habilita cores de sintaxe
set number                  " Números de linha
" set relativenumber          " Números relativos (opcional, bom para navegação)
set mouse=a                 " Habilita mouse (clicar, scroll, redimensionar)
set encoding=utf-8
set clipboard=unnamedplus   " Tenta usar o clipboard do sistema (Ctrl+C/V)
set splitbelow              " Novos splits abrem em baixo
set splitright              " Novos splits abrem na direita
set nowrap                  " Não quebra linhas longas


" --- Configurações de Indentação ---

" Mostra caracteres de tabulação existentes com 8 colunas de largura
set tabstop=8

" Usa 4 colunas para cada nível de indentação
set shiftwidth=4

" Ao pressionar <Tab>, insere 4 espaços ou move para a parada de 4 colunas
set softtabstop=4

" Converte tabulações em espaços
set expandtab

" Copia a indentação da linha anterior ao iniciar uma nova linha
set autoindent

" Indentação inteligente para linguagens baseadas em C (C, Java, etc)
set smartindent

" --- 1. EXPLORADOR DE ARQUIVOS (Netrw - Nativo) ---
" O Netrw já vem instalado. Vamos configurá-lo para parecer o sidebar do VSCode.
let g:netrw_banner = 0        " Remove o banner chato do topo
let g:netrw_liststyle = 3     " Exibição em árvore (Tree view)
let g:netrw_browse_split = 4  " Abre arquivos na janela anterior (não no sidebar)
let g:netrw_altv = 1          " Splits verticais abrem à direita
let g:netrw_winsize = 25      " Largura da janela (25%)

" Atalho Ctrl+b para abrir/fechar o explorador (igual VSCode)
nnoremap <C-e> :Files<CR>

" --- 2. TERMINAL INTEGRADO ---
" O Vim 8.1+ tem terminal nativo.
" Atalho Ctrl+j para abrir um terminal pequeno em baixo
nnoremap <C-/> :botright terminal<CR>

" Para sair do modo terminal e voltar para o código, use Ctrl+\ seguido de Ctrl+n
tnoremap <Esc> <C-\><C-n>

" --- 3. PESQUISA DE ARQUIVOS (Alternativa ao FZF Nativa) ---
" Se você não pode instalar o plugin fzf.vim, usaremos o 'find' nativo turbinado.

" Permite procurar recursivamente em subpastas
set path+=**

" Mostra sugestões ao apertar Tab (menu estilo wild)
set wildmenu
set wildmode=list:longest,full

" Ignora arquivos inúteis na busca
set wildignore+=*.o,*.obj,.git,node_modules,vendor,*.class,*.pyc

" Atalho Ctrl+p para pesquisar arquivos (igual VSCode)
" Isso abrirá o prompt ':find'. Digite *parte-do-nome* e aperte Tab.
nnoremap <C-p> :find 

" --- TEMA (Cores) ---
" Tenta usar um esquema de cores amigável que já vem no Vim
syntax enable
set background=dark
try
	colorscheme habamax
catch
endtry

" --- BUSCA TURBINADA (FZF + FD) ---
"if executable('fzf')
"    function! FzfComFd()
"        " Define o comando de busca. 
"        " No Debian/Ubuntu o binário chama-se 'fdfind', em outros é 'fd'.
"        if executable('fdfind')
"            let l:cmd_busca = 'fdfind'
"        elseif executable('fd')
"            let l:cmd_busca = 'fd'
"        else
"            echo "Erro: fd não encontrado. Instale o 'fd-find'."
"            return
"        endif
"
"        " Configurações do comando fd:
"        " --type f: procura apenas arquivos
"        " --strip-cwd-prefix: remove o './' do início dos nomes (estética)
"        " --follow: segue links simbólicos
"        " --exclude .git: garante que não vamos entrar na pasta git
"        let l:comando_completo = l:cmd_busca . ' --type f --strip-cwd-prefix --follow --exclude .git'
"
"        " Cria arquivo temporário para a escolha
"        let l:temp = tempname()
"        
"        " Executa: fd (lista arquivos) | fzf (seleciona) > arquivo_temp
"        " O < /dev/tty força o fzf a usar o terminal interativo mesmo dentro do vim
"	execute '!' . l:comando_completo . ' | fzf  > ' . l:temp
"
"        redraw! " Limpa a tela após fechar o fzf
"
"        " Abre o arquivo escolhido, se houver
"        if filereadable(l:temp)
"            let l:escolha = readfile(l:temp)
"            if !empty(l:escolha)
"                execute 'edit ' . l:escolha[0]
"            endif
"            call delete(l:temp)
"        endif
"    endfunction
"
"    " Mapeia Ctrl+p para essa nova função
"    nnoremap <C-p> :call FzfComFd()<CR>
"endif

" Atalho Ctrl+g para pesquisar TEXTO nos arquivos (Requer 'grep' ou 'ripgrep')
" Digite o termo, dê Enter, e ele abre uma lista rápida (Quickfix) com os resultados
command! -nargs=1 Grep execute 'rg --vimgrep <args> .' | copen
nnoremap <C-g> :Grep



set termguicolors

let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

" --- Mover entre janelas usando <Ctrl> hjkl ---
" Usamos nmap porque o comando destino (<C-w>h) é um atalho nativo
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" --- Redimensionar janelas usando <Ctrl> Setas ---
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" --- Buffers ---
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>
nnoremap <leader>bd :bd<CR>

" --- Tabs ---
nnoremap <leader><tab>l :tablast<CR>
nnoremap <leader><tab>o :tabonly<CR>
nnoremap <leader><tab>f :tabfirst<CR>
nnoremap <leader><tab><tab> :tabnew<CR>
nnoremap <leader><tab>] :tabnext<CR>
nnoremap <leader><tab>d :tabclose<CR>
nnoremap <leader><tab>[ :tabprevious<CR>


nnoremap <leader>fn :enew<CR>

" --- Mapeamentos FZF (Substituindo Telescope) ---
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" <leader>ff : Localizar arquivos (Files)
nnoremap <leader>ff :Files<CR>

" <leader>fg : Buscar texto dentro dos arquivos (Ripgrep)
" Nota: Requer o binário 'rg' (ripgrep) instalado no sistema
nnoremap <leader>fg :Rg<CR>

" <leader>fb : Listar e alternar entre buffers abertos
nnoremap <leader>fb :Buffers<CR>

" Extra: <leader>fh : Histórico de arquivos abertos (opcional, mas útil)
nnoremap <leader>fh :History<CR>


" Nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'
imap <c-space> <Plug>(asyncomplete_force_refresh)

if executable('java')
    augroup LSP_Java
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'eclipse-jdt-ls',
            \ 'cmd': {server_info->[
            \     'java',
            \     '-javaagent:/home/cally/.vscode/extensions/redhat.java-1.50.0-linux-x64/lombok/lombok-1.18.39-4050.jar',
            \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \     '-Dosgi.bundles.defaultStartLevel=4',
            \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \     '-Dlog.protocol=true',
            \     '-Dlog.level=ALL',
            \     '-Xms1g',
            \     '--add-modules=ALL-SYSTEM',
            \     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            \     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            \     '-jar', '/home/cally/.vscode/extensions/redhat.java-1.50.0-linux-x64/server/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar',
            \     '-configuration', '/home/cally/.vscode/extensions/redhat.java-1.50.0-linux-x64/server/config_linux',
            \     '-data', '/home/cally/.cache/jdtls-workspace'
            \ ]},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['pom.xml', 'build.gradle', '.git']))},
            \ 'allowlist': ['java'],
            \ })
    augroup END
endif

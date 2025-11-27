" --- CONFIGURAÇÕES BÁSICAS (Estilo IDE) ---
set nocompatible            " Desativa compatibilidade com vi antigo
filetype plugin indent on   " Detecta tipo de arquivo e indentação
syntax on                   " Habilita cores de sintaxe
set number                  " Números de linha
" set relativenumber          " Números relativos (opcional, bom para navegação)
set mouse=a                 " Habilita mouse (clicar, scroll, redimensionar)
set encoding=utf-8
set clipboard=unnamedplus   " Tenta usar o clipboard do sistema (Ctrl+C/V)
set splitbelow              " Novos splits abrem em baixo
set splitright              " Novos splits abrem na direita
set nowrap                  " Não quebra linhas longas

" --- 1. EXPLORADOR DE ARQUIVOS (Netrw - Nativo) ---
" O Netrw já vem instalado. Vamos configurá-lo para parecer o sidebar do VSCode.
let g:netrw_banner = 0        " Remove o banner chato do topo
let g:netrw_liststyle = 3     " Exibição em árvore (Tree view)
let g:netrw_browse_split = 4  " Abre arquivos na janela anterior (não no sidebar)
let g:netrw_altv = 1          " Splits verticais abrem à direita
let g:netrw_winsize = 25      " Largura da janela (25%)

" Atalho Ctrl+b para abrir/fechar o explorador (igual VSCode)
nnoremap <C-e> :Lexplore<CR>

" --- 2. TERMINAL INTEGRADO ---
" O Vim 8.1+ tem terminal nativo.
" Atalho Ctrl+j para abrir um terminal pequeno em baixo
nnoremap <C-j> :botright terminal<CR>

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

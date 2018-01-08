" generated by puppet from: modules/accounts/files/xnicollet/.vimrc

set encoding=utf-8

syntax on
syntax sync minlines=512 " start highlighting from 512 lines backward
set synmaxcol=300 " do noe highlight very long lines
set bg=dark

let g:airline_powerline_fonts = 1
" set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h20

filetype plugin indent on

au BufRead,BufNewFile Vagrantfile setfiletype ruby
set modelines=5
set modeline

" set list | set nolist
" set listchars=tab:\|-,trail:.
set listchars=tab:»\ ,trail:.,nbsp:~

" this is temporary: to get 256 colors
set t_Co=256

"	" should be called before go plugin is launched
"		GoFmt
"		if !empty(b:current_syntax)
"			unlet b:current_syntax
"		 endif
"		 syn include @html syntax/html.vim
"		syntax region htmlCode start=+<!DOCTYPE+ keepend end=+</html>+ contains=@html containedin=goRawString contained
"	endfunction
"
"	" autocmd BufEnter *.go call GoHtml()
"	autocmd BufWrite *.go call GoHtml()

" http://stackoverflow.com/questions/18576651/check-whether-pathogen-is-installed-in-vimrc
runtime! bundle/vim-pathogen/autoload/pathogen.vim
if exists("*pathogen#infect")
	call pathogen#infect('bundle/{}', '/usr/local/opt/fzf')
endif

inoremap jk <Esc>l

" remove arrows
for prefix in ['i', 'n', 'v']
	for key in ['<Up>', '<Down>', '<Left>', '<Right>']
		exe prefix . "noremap " . key . " <Nop>"
	endfor
endfor

let mapleader = "\<Space>"

if &runtimepath =~ 'vim-go'
	" function! FormatAndImports()
	"	 GoFmt
	"	 GoImports
	" endfunction

	function! SetGoOptions() abort
		nmap <Leader>gr <Plug>(go-run)
		nmap <Leader>gb <Plug>(go-build)
		nmap <Leader>gt <Plug>(go-test)
		nmap <Leader>gT <Plug>(go-test-func)
		nmap <Leader>gR <Plug>(go-rename)
		nmap <Leader>gf <Plug>(go-freevars)
		nmap <Leader>gl <Plug>(go-metalinter)
		nmap <Leader>ga <Plug>(go-alternate-edit)
		nmap <Leader>gc <Plug>(go-coverage-toggle)
		nmap <Leader>gd <Plug>(go-doc)
		nmap <Leader>gD <Plug>(go-describe)
		nmap <Leader>gi <Plug>(go-info)
		nmap <Leader>gI <plug>(go-imports)

		set list
		let g:go_fmt_autosave = 1
		" let g:go_fmt_options = "-s -w"
		let g:go_fmt_command = "goimports"

		" for golang: automatically run GoImports
		" autocmd BufWritePre *.go call FormatAndImports()

		" some stuff from github.com/fatih/vim-go-tutorial
		let g:go_list_type = "quickfix"
		let g:go_highlight_build_constraints = 1

	endfunction


	augroup golang
		autocmd!
		au FileType go call SetGoOptions()
		au FileType go setl list tabstop=2 shiftwidth=2 noexpandtab
	augroup end
endif

augroup yaml
	autocmd!
	autocmd FileType yaml setl softtabstop=2 expandtab
augroup end

augroup puppet
	autocmd!
	au FileType puppet setl et
augroup end

augroup ruby
	autocmd!
	au FileType ruby setl et
augroup end

augroup json
	autocmd!
	au FileType json setl et
augroup end

augroup vim
	autocmd!
	au FileType vim setl noet
augroup end

" Google style guide for bash
augroup bash
	autocmd!
	au FileType sh setl list sw=2 ts=2 et
	function! RemapEnter() abort
		nnoremap <return> :x<return>
		inoremap <return> <esc>:x<return>
	endfunction
	au BufNewFile,BufRead bash-fc* call RemapEnter()
augroup end

" let's test hidden mode
set hidden
set list shiftwidth=2 tabstop=2

nnoremap ' `
nnoremap ` '

set history=100
set visualbell

cnoremap w!! w !sudo tee %
" make C-g behave like C-c in command mode
" cnoremap <C-g> <C-c>
" does not fit well with inscearch

" todo remap set number to set number relativenumber
" when printing number, use relative numbers so that we can 3dd easily
" set relativenumber

" open vimrc more easily
nnoremap <Leader>ev :e $MYVIMRC<cr>
" todo: improve this: should only save $MYVIMRC
nnoremap <Leader>sv :w<cr> :source $MYVIMRC<cr>
" should find a way to close it easily

" sane backspace
set backspace=2

" for windows
if has('win64')
	set term=xterm-256
	syn on
endif

" don't put too large text by mistake
highlight ColorColumn ctermbg=darkblue
call matchadd('ColorColumn', '\%81v', 100)

set laststatus=2
" we need more colors
" set t_Co=256

" know where the cursor is located
set noruler

" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" set statusline=	 " clear the statusline for when vimrc is reloaded

" syntastic
" if exists('SyntasticStatuslineFlag')
" 	set statusline+=%#warningmsg#
" 	set statusline+=%{SyntasticStatuslineFlag()}
" 	set statusline+=%*
" endif
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

" set statusline+=%-3.3n\											" buffer number
" set statusline+=%f\													" file name
" set statusline+=%h%m%r%w										 " flags
" set statusline+=[%{strlen(&ft)?&ft:'none'},	" filetype
" set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
" set statusline+=%{&fileformat}]							" file format
" set statusline+=%=													 " right align
" " set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\	" highlight
" " set statusline+=%b,0x%-8B\									 " current char
" " set statusline+=%-14.(%l,%c%V%)\ %<%P				" offset
" set statusline+=%10((%l,%c)%)\						" line and column
" set statusline+=%p%%												" percentage of file

" help for file
set wildmenu
" set wildmode=longest,list:full
" testing a new version
set wildmode=list:longest,full
" Ignore compiled files
set wildignore+=.o,~,pyc
set wildignore+=.git,.hg,.svn

" just a try: let's forget ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

if &runtimepath =~ 'fzf'
	nnoremap <leader>;b :Buffers<CR>
	nnoremap <leader>;e :Files<CR>
	nnoremap <leader>;t :Tags<CR>
	" see: https://statico.github.io/vim3.html
end

set autowrite

" Looks like unimpaired.vim
function! s:setup_paste() abort
	set paste
	augroup unimpaired_paste
		autocmd!
		autocmd InsertLeave *
			\ set nopaste |
			\ autocmd! unimpaired_paste
	augroup end
endfunction

nnoremap <silent> yo :call <SID>setup_paste()<CR>o
nnoremap <silent> yO :call <SID>setup_paste()<CR>O

" set completeopt=menu,menuone
" if &runtimepath =~ 'neocomplete'
"	 let g:acp_enableAtStartup = 0
"	 let g:neocomplete#enable_at_startup = 0
"	 let g:neocomplete#enable_smart_case = 1
"
"	 if !exists('g:neocomplete#sources')
"		 let g:neocomplete#sources = {}
"	 endif
"	 let g:neocomplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary']
"	 let g:neocomplete#sources.go = ['omni']
"
"	 " enable heavy omni completion
"	 " if !exists('g:neocomplete#force_omni_input_patterns')
"	 "	let g:neocomplete#force_omni_input_patterns = {}
"	 " endif
"	 " let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'
"
"	 " Plugin key-mappings.
"	 "inoremap <expr><C-g> neocomplete#undo_completion()
"	 "inoremap <expr><C-l> neocomplete#complete_common_string()
"
"	 "imap <C-k>		 <Plug>(neosnippet_expand_or_jump)
"	 "smap <C-k>		 <Plug>(neosnippet_expand_or_jump)
"	 "xmap <C-k>		 <Plug>(neosnippet_expand_target)
"	 "nnoremap <leader>es :NeoSnippetEdit<CR>
"
"	 "let g:neosnippet#snippets_directory = "~/.vim/neosnippets"
"
"	 " For conceal markers.
"	 " if has('conceal')
"		 "set conceallevel=2 concealcursor=niv
"	 "endif
" endif

set splitright " split vertically to the right
set splitbelow

" let's give this a try
set clipboard^=unnamed
set clipboard^=unnamedplus

" just a test
set lazyredraw

" manage tabs
map <Leader>te :tabnew<cr>
map <Leader>to :tabonly<cr>
map <Leader>tm :tabmove<Space>

function! GitGrep() abort
	echom "gitgrep"
	execute "normal! :Grep <cwords -- './*' ':!*.js' ':!*.css'<cr>"
	execute "normal! :copen<cr>"
endfunction

nnoremap <Leader>] :call GitGrep()<cr>

" Set scripts to be executabe from the shell
au! BufWritePost *
au BufWritePost *
	\ if getline(1) =~ "^#!.*/bin/" |
	\ redraw! |
	\ echo "chmod u+x <afile>" |
	\ silent execute "!chmod u+x <afile>" |
	\ endif

" temp
" au BufWritePost *.html make

" toggle quickfix with q
function! Qf_toggle() abort
	let godoc = bufnr('Godoc')
	if godoc != "-1"
		execute "bd " . godoc
		return
	endif
	for i in range(1, winnr('$'))
		let bnum = winbufnr(i)
		if getbufvar(bnum, '&buftype') == 'quickfix'
			cclose
			return
		elseif getbufvar(bnum, '&buftype') == 'help'
				helpc " not supported in vim7
				" execute "bd " . bnum
				return
		endif
	endfor
	copen
endfunction

" remove quickfix or help screen with q
nnoremap <Leader>q q
nnoremap q :call Qf_toggle()<cr>

" comment the current line/region
if &runtimepath =~ 'nicecom'
	vnoremap <silent> <Leader>cc :NiceComment<cr>
	vnoremap <silent> <Leader>cu :NiceUncomment<cr>
	nnoremap <silent> <Leader>cc :NiceComment<cr>
	nnoremap <silent> <Leader>cu :NiceUncomment<cr>
endif



" function! WriteRemote() abort
"	 let pat = '^scp://\(.\{-}\)/'
"	 let l = matchlist( bufname('%'), pat)
"	 if len(l) < 2
"		 echom "could not get remote host"
"		 return
"	 end
"	 let remote = l[1]
"	 let temp_file = expand('%:t')
"	 let dest_file = substitute( bufname('%'), pat, '', '')
"
"	 execute "write! scp://" . remote . "//tmp/" . temp_file
"	 execute "!ssh -t " . remote .
"		 \ " 'sudo tee >/dev/null -- " . dest_file .
"		 \ " </tmp/".temp_file .
"		 \ " ; rm -- /tmp/".temp_file . "'"
" endfunction

" function! SetExecutableBit() abort
"	 let fname = expand("%:p")
"	 checktime
"	 execute "au FileChangedShell " . fname . " :echo"
"	 silent !chmod a+x %
"	 checktime
"	 execute "au! FileChangedShell " . fname
" endfunction
" command! Xbit call SetExecutableBit()


" function! MarkdownFolds() abort
"		 let thisline = getline(v:lnum)
"		 if match(thisline, '^##') >= 0
"				 return ">2"
"		 elseif match(thisline, '^#') >= 0
"				 return ">1"
"		 else
"				 return "="
"		 endif
" endfunction
"
" setlocal foldmethod=expr
" setlocal foldexpr=MarkdownFolds()

" function! MarkdownFoldText() abort
"		 "get first non-blank line
"		 let fs = v:foldstart
"		 while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
"		 endwhile
"		 if fs > v:foldend
"				 let line = getline(v:foldstart)
"		 else
"				 let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
"		 endif
"
"		 let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
"		 let foldSize = 1 + v:foldend - v:foldstart
"
"		 let i = v:foldstart
"		 let foldWords=0
"		 while (i<v:foldend)
"			 let lineWords = len(split(getline(i)))
"			 let foldWords = foldWords + lineWords
"			 let i += 1
"		 endwhile
"		 let wordCount = wordcount()["words"]
"
"		 " let foldWords = v:foldend,v:foldstart!wc -w
"		 let foldWordsStr = " " . foldWords . " w,"
"		 let foldSizeStr = foldWordsStr . foldSize . " lines "
"		 let foldLevelStr = repeat("+--", v:foldlevel)
"		 let foldPercentage = printf("[%.1f", (foldWords*1.0)/wordCount*100) . "%] "
"		 " let expansionString = "."
"		 let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
"		 return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
"		 " return line . expansionString . foldSizeStr . foldPercentage . foldWordsStr . foldLevelStr
"		 " return line . "......" . foldSizeStr . foldPercentage . foldLevelStr
" endfunction
"
" setlocal foldtext=MarkdownFoldText()


" do backups, and recovery files
set backup
" set backupdir=~/.vim/backup,~/tmp " backup files
" set directory=~/.vim/tmp,~/tmp " temp files

set backupdir=~/.vim/backup " backup files
set directory=~/.vim/tmp " temp files

function! EnsureDir(dir) abort
	if !isdirectory(a:dir)
		" mode 773 does not work for some reason... strange
		call mkdir(a:dir, "", 0773)
	endif
endfunction

for dir in split(&backupdir, ',') + split(&directory, ',')
	call EnsureDir(dir)
endfor


" skip backups for bosun -w, which watches files for writes
set backupskip+=*/cmd/bosun/{*.go\\,web/static/{js/*.ts\\,templates/*.html}}

set showcmd " show partial commands

" reduce timeouts a bit
set timeoutlen=500


if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j " Delete comment character when joining commented lines
	set formatoptions+=c
	set formatoptions-=ro
	set formatoptions-=lv
endif
set nrformats-=octal " we don't use octal that much for CTRL-A / CTRL-X

" Yank buffer as in emacs
if &runtimepath =~ 'vim-yankstack'
	let g:yankstack_map_keys = 0
	nmap <leader>p <Plug>yankstack_substitute_older_paste
	nmap <leader>P <Plug>yankstack_substitute_newer_paste
endif

" Lightline
" let g:lightline = {
" \ 'colorscheme': 'wombat',
" \ 'active': {
" \   'left': [['mode', 'paste'], ['filename', 'modified']],
" \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
" \ },
" \ 'component_expand': {
" \   'linter_warnings': 'LightlineLinterWarnings',
" \   'linter_errors': 'LightlineLinterErrors',
" \   'linter_ok': 'LightlineLinterOK'
" \ },
" \ 'component_type': {
" \   'readonly': 'error',
" \   'linter_warnings': 'warning',
" \   'linter_errors': 'error'
" \ },
" \ }
"
" function! LightlineLinterWarnings() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
" endfunction
"
" function! LightlineLinterErrors() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
" endfunction
"
" function! LightlineLinterOK() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '✓ ' : ''
" endfunction
"
" autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
" function! s:MaybeUpdateLightline()
"   if exists('#lightline')
"     call lightline#update()
"   end
" endfunction

" lightline does it now
set noshowmode

let g:lightline = {
	\ 'component_function': {
	\   'readonly': 'LightlineReadonly',
	\   'fileformat': 'LightlineFileformat',
	\   'filetype': 'LightlineFiletype',
	\   'filename': 'LightlineFilename',
	\ },
	\ }

		let g:lightline.active = {
		    \ 'left': [ [ 'mode', 'paste' ],
		    \           [ 'readonly', 'filename' ] ],
		    \ 'right': [ [ 'lineinfo' ],
		    \            [ 'percent' ],
		    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

function! LightlineReadonly() abort
	return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineFileformat() abort
	return &fileformat ==# 'unix' ? '' : &fileformat
endfunction

function! LightlineFiletype() abort
	return &filetype
endfunction

function! LightlineFilename() abort
	let filename = expand('%:t') != '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? '+' : ''
	return filename . modified
endfunction

set incsearch
set hls

if &runtimepath =~ 'ale'
	" function! SwapAleLintOnTextChanged()
	" 	if g:ale_lint_on_text_changed == 'always'
	" 		let g:ale_lint_on_text_changed = 0
	" 	else
	" 		let g:ale_lint_on_text_changed = 'always'
	" 	endif
	" endfunction
	nmap <Leader>at <Plug>(ale_toggle)
	" nnoremap <Leader>at :call SwapAleLintOnTextChanged()<cr>
	let g:ale_lint_on_insert_leave = 1
	let g:ale_lint_on_text_changed = 'normal'
endif

if &runtimepath =~ 'auto-pairs'
	inoremap <c-l> <c-o>A
endif

" vim: set list ts=2 sw=2:

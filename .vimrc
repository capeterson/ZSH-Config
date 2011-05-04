set nocp
set ruler 
set cindent
set history=50
set comments=:#
set backup
set ignorecase
set smartcase
set wildmode=list:longest,full
set showmode
set showcmd
filetype on
syntax on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Run python on this program when pressing F5
" map <silent> <F5> :!xterm -bg lightblue -fg red -geometry 172x14+100+774 -e "python % \|\| read"<CR><CR>

" Don't create backupfiles everywhere, but just in ~/.backup
" set backupdir=~/.backup
" set dir=~/.backup

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END


function HtmlEscape()
	  silent s/&/\&amp;/eg
	    silent s/</\&lt;/eg
	      silent s/>/\&gt;/eg
	      endfunction

	      function HtmlUnEscape()
	  silent s/&lt;/</eg
	    silent s/&gt;/>/eg
	      silent s/&amp;/\&/eg
	      endfunction

	      map <silent> <c-h> :call HtmlEscape()<CR>
	      map <silent> <c-u> :call HtmlUnEscape()<CR>

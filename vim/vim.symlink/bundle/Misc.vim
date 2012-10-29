" " When Vim configuration file is edited, reload it
" if has("win32") 
"     " Set font in windows
"     set gfn=Consolas:h11:cDEFAULT
" 
"     " Fast editing of the Vim configuration file
"     map <F3> :e ~/_vimrc<cr>
" 
"     " When Vim configuration file is edited, reload it
" 	au! bufwritepost _vimrc so ~/_vimrc
" 
"     if has("gui_running")
"         au! bufwritepost _gvimrc so ~/_gvimrc
"     endif
" else
"     " Fast editing of the Vim configuration file
"     map <F3> :e ~/.vimrc<cr>
" 
" 	au! bufwritepost .vimrc so ~/.vimrc
" 
"     if has("gui_running")
"         au! bufwritepost .gvimrc so ~/.gvimrc
"     endif
" endif

" " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" " http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

" Set an orange cursor in insert mode, and a red cursor otherwise.
" Works at least for xterm and rxvt terminals.
" Does not work for gnome terminal, konsole, xfce4-terminal.
" if &term =~ "xterm\\|rxvt\\|xterm-256color"
"    :silent !echo -ne "\033]12;red\007"
"    let &t_SI = "\033]12;orange\007"
"    let &t_EI = "\033]12;red\007"
"    autocmd VimLeave * :!echo -ne "\033]12;red\007"
" endif

" " Hex mode on and off
" map <Leader>hon :%!xxd<CR>
" map <Leader>hof :%!xxd -r<CR>


" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>


" " show number of occurences of a word under the cursor
" " map <f5> :execute ":%s@\\<" . expand("<cword>") . "\\>\@&@gn"<CR>
" 
" 
" au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

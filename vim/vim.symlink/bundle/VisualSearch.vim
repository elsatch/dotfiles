"""""""""""""""" START Find With Visual Selection """""""""""""""""

" " Search for selected text, forwards or backwards.
" vnoremap <silent> * :<C-U>
"   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
"   \gvy/<C-R><C-R>=substitute(
"   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
"   \gV:call setreg('"', old_reg, old_regtype)<CR>
" vnoremap <silent> # :<C-U>
"   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
"   \gvy?<C-R><C-R>=substitute(
"   \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
"   \gV:call setreg('"', old_reg, old_regtype)<CR>

"""""""""""""""" END Find With Visual Selection """""""""""""""""


"""""""""""""""" START Replace With Visual Selection """""""""""""""""

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

"hacky
function! GetUnescapedVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  " "Escape any special characters in the selection
  " let escaped_selection = EscapeString(selection)

  " return escaped_selection
  return selection
endfunction

" Start the find and replace command across the entire file
" vmap <leader>r <Esc>:%s/<c-r>=GetVisual()<cr>/
vnoremap <silent> R <Esc>:%s/<c-r>=GetVisual()<cr>/

"""""""""""""""" END Replace With Visual Selection """""""""""""""""

" Search google (In Chrome) with alt+g
function! Terms()
  call inputsave()
  let searchterm = input('Search: ')
  call inputrestore()
  return searchterm
endfunction

" Meta-g
map © <ESC>:! /usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/search?q=<C-R>=Terms()<CR>'<CR><CR>
" Meta-f
map ƒ <ESC>:! /usr/bin/open -a "/Applications/Google Chrome.app" 'https://google.com/search?q=<C-R>=GetUnescapedVisual()<CR>'<CR><CR>

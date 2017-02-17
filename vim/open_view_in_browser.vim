function! OpenInBrowser(url)
  let l:run_script = "!osascript ~/.dotfiles/tools/open_browser.applescript"
  if !exists("g:vim_browser")
    echo "Please set g:vim_browser in your vimrc file"
    return 0
  end
  silent execute ":up"
  silent execute l:run_script . " '". g:vim_browser . "'  '" . a:url . "' &"
  silent execute ":redraw!"
endfunction

function! GetViewUrl()
  if expand('%:p') !~ 'app/views/.*/.*\.html\.erb$'
    return -1
  elseif expand('%:t') =~ '^_'
    return -1
  endif
  let base = substitute(expand('%:t:r:r'), 'index$', '', '')
  let path = substitute(expand('%:p:h'), '^.*app/views/', '', '')
  let url = g:vim_domain . '/' . path . '/' . base
  return url
endfunction

function! OpenViewInBrowser()
  if !exists("g:vim_domain")
    echo "Please set g:vim_domain in your vimrc file"
    return 0
  end
  let url = GetViewUrl()
  if url != -1
    call OpenInBrowser(url)
  else
    echo "Must be an erb view file"
  endif
endfunction

command! OpenViewInBrowser call OpenViewInBrowser()

" Index ctags from any project, including those outside Rails
function! ReindexCtags()
  let l:ctags_hook = '$(git rev-parse --show-toplevel)/.git/hooks/ctags'

  if exists("l:ctags_hook")
    exec '!' . l:ctags_hook
  else
    exec "!ctags -R --exclude='.git' --exclude='log' --exclude='public' --exclude='tmp' --exclude='*.js' ."
  endif
endfunction

nmap <Leader>ct :call ReindexCtags()<CR>

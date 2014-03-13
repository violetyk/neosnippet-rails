let s:save_cpo = &cpo
set cpo&vim

let s:snippets = []

function! neosnippet_rails#set_rails_snippets() "{{{

  if type(g:neosnippet#snippets_directory) != type([])
    let g:neosnippet#snippets_directory = []
  endif

  let buf_type = ''
  try
    let buf_type = rails#buffer().type_name()
  catch
    return
  endtry

  call neosnippet_rails#unset_rails_snippets()
  let snippet_root = neosnippet_rails#get_snippets_root()

  if buf_type == 'model-arb'
    echo snippet_root
  endif
    " echo fnamemodify(expand('<sfile>'), ":p")
    " let snippets_directory = [
          " \ $HOME.'/.vim/snippets',
          " \ $HOME.'/works/neosnippet-cakephp2',
          " \ $HOME.'/works/neosnippet-rails',
          " \]
    " let g:neosnippet#snippets_directory = join(snippets_directory, ',')
endfunction "}}}

function! neosnippet_rails#unset_rails_snippets() "{{{

  if type(g:neosnippet#snippets_directory) != type([])
    let g:neosnippet#snippets_directory = []
  endif

  let l = neosnippet_rails#get_snippets_directories()
  for d in l 
    i = index(g:neosnippet#snippets_directory, d)
    if d != -1
      remove(g:neosnippet#snippets_directory, d)
    endif
  endfor
endfunction "}}}
function! neosnippet_rails#get_snippets_root() "{{{
  return finddir('autoload/neosnippet_rails/snippets', &runtimepath)
endfunction "}}}
function! neosnippet_rails#get_snippets_directories() "{{{
  let list = []
  let d = neosnippet_rails#get_snippets_root()
  for f in split(glob(d . '/**/*.snip'), "\n")
    call add(list, fnamemodify(f, ':h'))
  endfor
  return list
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:

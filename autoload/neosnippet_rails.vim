let s:save_cpo = &cpo
set cpo&vim

let s:snippets = []

function! neosnippet_rails#set_snippets() "{{{

  " reset
  call neosnippet_rails#unset_snippets()


  let buf_type = ''
  try
    let buf_type = rails#buffer().type_name()
  catch
  finally
    if !len(buf_type)
      return
    endif
  endtry

  let list = s:get_neosnippets_directory_list()
  let snippet_root = neosnippet_rails#get_snippets_root()

  if buf_type == 'model-arb'
    call add(list, printf('%s/app/models', snippet_root))
  elseif buf_type == 'view-erb'
    call add(list, printf('%s/app/views', snippet_root))
  else
    echo printf('no rails-snippet for type:%s', buf_type)
  endif
  call s:set_neosnippets_directory_list(list)
endfunction "}}}
function! neosnippet_rails#unset_snippets() "{{{

  let list = s:get_neosnippets_directory_list()

  for d in neosnippet_rails#get_snippets_directories()
    let i = index(list, d)
    if i != -1
      echo d
      call remove(list, i)
    endif
  endfor
  call s:set_neosnippets_directory_list(list)
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

function! s:set_neosnippets_directory_list(list) " {{{
  if type(g:neosnippet#snippets_directory) == type([])
    let g:neosnippet#snippets_directory = a:list
  elseif type(g:neosnippet#snippets_directory) == type('')
    let g:neosnippet#snippets_directory = join(a:list, ',')
  endif
  call neosnippet#init#_initialize()
endfunction " }}}
function! s:get_neosnippets_directory_list() " {{{
  if type(g:neosnippet#snippets_directory) == type([])
    return g:neosnippet#snippets_directory
  elseif type(g:neosnippet#snippets_directory) == type('')
    return split(g:neosnippet#snippets_directory, ',')
  endif
endfunction " }}}


let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:

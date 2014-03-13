" if exists('g:loaded_neosnippet_rails_vim')
  " finish
" endif
" let g:loaded_neosnippet_rails_vim = 1

let s:save_cpo = &cpo
set cpo&vim

augroup set_rails_snippets
  autocmd!
  autocmd BufEnter *.rb,*.erb call neosnippet_rails#set_rails_snippets()
  autocmd BufLeave *.rb,*.erb call neosnippet_rails#unset_rails_snippets()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:

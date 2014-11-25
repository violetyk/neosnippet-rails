let s:save_cpo = &cpo
set cpo&vim

" http://d.hatena.ne.jp/osyo-manga/20140818/1408370306
function! neosnippet_rails#html2slim(html) "{{{
  if !executable('html2slim')
    return ''
  endif
  let input  = tempname()
  call writefile(split(a:html, "\n"), input)
  let output = tempname()
  call system(printf("html2slim %s %s", input, output))
  return join(readfile(output), "\n")
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:

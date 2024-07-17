let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort'    : 0,
    \ 'deffile' : expand('<sfile>:p:h:h') . '/ctags/latex.cnf'
\ }
let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:macros;t:targets'

" Ensure filetype is set to tex for files with .tex extension
augroup tex_files
  autocmd!
  autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

let g:vimtex_fold_enabled = 1
set fillchars=fold:\  " Space
let g:vimtex_toc_config = {
      \ 'name' : 'ToC',
      \ 'fold_enable' : 1,
      \ 'show_help': 0,
      \ 'split_width': 30,
      \ 'todo_sorted': 0,
      \ 'layer_status': { 'include':0 },
      \ 'hotkeys_leader' : '<Space>',
      \ 'split_pos' : 'vert botright',
      \}

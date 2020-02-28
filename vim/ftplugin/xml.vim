setlocal sw=2 sts=2 et
"noremap <a-c> :s/\(\S.*\)/<!--\1--><cr>
"noremap <a-d> :s/<!--\(\S.*\)-->/\1<cr>
"map <F2> :s/\(\S.*\)/<!--\1--><cr>
"map <F3> :s/<!--\(\S.*\)-->/\1<cr>

augroup filetypedetect
  au BufRead,BufNewFile *.c setfiletype c.programming
  au BufRead,BufNewFile *.cpp setfiletype c.programming
  au BufRead,BufNewFile *.py setfiletype python.programming
  au BufRead,BufNewFile *.hs setfiletype haskell.programming
  au BufRead,BufNewFile *.gpl setfiletype gnuplot.programming
  au BufRead,BufNewFile *.awk setfiletype awk.programming
  au BufRead,BufNewFile *.js setfiletype javascript.programming
augroup END

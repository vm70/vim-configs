setlocal linebreak
setlocal makeprg=biber\ %:t:r\ &&\ pdflatex\ %\ &&\ pdflatex\ %
set showbreak=

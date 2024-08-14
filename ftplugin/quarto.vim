setlocal wrap
setlocal commentstring=<!--\ %s\ -->
setlocal syntax=quarto

let b:ale_linter_aliases = ['markdown']
let b:ale_fixers = ['prettier']

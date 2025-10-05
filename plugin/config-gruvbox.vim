if &background ==# 'dark'
  " hard contrast: #1d2021 / soft contrast: #32302f
  let g:terminal_ansi_colors = [
    \ '#282828',
    \ '#cc241d',
    \ '#98971a',
    \ '#d79921',
    \ '#458588',
    \ '#b16286',
    \ '#689d6a',
    \ '#a89984',
    \ '#928374',
    \ '#fb4934',
    \ '#b8bb26',
    \ '#fabd2f',
    \ '#83a598',
    \ '#d3869b',
    \ '#8ec07c',
    \ '#ebdbb2',
    \ ]
  highlight SpellCap cterm=underline guisp=#83a598
  highlight SpellBad cterm=underline guisp=#fb4934
  highlight SpellLocal cterm=underline guisp=#8ec07c
  highlight SpellRare cterm=underline guisp=#d3869b
elseif &background ==# 'light'
  " hard contrast: #f9f5d7 / soft contrast: #f2e5bc
  let g:terminal_ansi_colors = [
    \ '#fbf1c7',
    \ '#cc241d',
    \ '#98971a',
    \ '#d79921',
    \ '#458588',
    \ '#b16286',
    \ '#689d6a',
    \ '#7c6f64',
    \ '#928374',
    \ '#9d0006',
    \ '#79740e',
    \ '#b57614',
    \ '#076678',
    \ '#8f3f71',
    \ '#427b58',
    \ '#3c3836',
    \ ]
  highlight SpellCap cterm=underline guisp=#076678
  highlight SpellBad cterm=underline guisp=#9d0006
  highlight SpellLocal cterm=underline guisp=#427b58
  highlight SpellRare cterm=underline guisp=#8f3f71
endif

highlight link jsonString GruvboxAqua

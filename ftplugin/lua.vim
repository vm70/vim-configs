" Tabs, 2 characters long
setlocal noexpandtab
setlocal shiftwidth=2
setlocal tabstop=2

if executable('stylua')
  setlocal equalprg=stylua\ -
  setlocal formatprg=stylua\ -
endif

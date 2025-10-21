vim9script

# Mermaid CLI - https://github.com/mermaid-js/mermaid-cli
if executable('mmdc')
  # The `aa-exec` prefix is needed for Linux distros that use AppArmor. 
  # See also: https://github.com/mermaid-js/mermaid-cli/issues/730
  setlocal makeprg=aa-exec\ --profile=chrome\ mmdc\ -i\ %\ -o\ %:p:r.png
  setlocal errorformat=%trror:\ %m\ on\ line\ %l:
endif

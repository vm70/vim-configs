vim9script

# Mermaid CLI - https://github.com/mermaid-js/mermaid-cli
if executable('mmdc')
  # The `aa-exec` prefix is needed for Linux distros that use AppArmor.
  # See also: https://github.com/mermaid-js/mermaid-cli/issues/730
  setlocal makeprg=aa-exec\ --profile=chrome\ mmdc\ -i\ %\ -o\ %:p:r.png

  # Example `mmdc` error format:
  #
  # ```text
  # Error: Parse error on line 4:
  # ...b  c --> d  e --> -->
  # ---------------------^
  # Expecting 'AMP', 'COLON', 'PIPE', 'TESTSTR', 'DOWN', 'DEFAULT', 'NUM', 'COMMA', 'NODE_STRING', 'BRKT', 'MINUS', 'MULT', 'UNICODE_TEXT', got 'LINK'
  # ```
  setlocal errorformat=%EError:\ Parse\ Error\ on\ line\ %l:
  setlocal errorformat+=%C%.%#\ \ %s
  setlocal errorformat+=%C%p^
  setlocal errorformat+=%Z%m
endif

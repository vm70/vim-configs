vim9script

def UpstreamSyntax(filetype: string)
  # 1. Check if 'curl' is available
  if !executable('curl')
    echohl ErrorMsg
    echomsg 'Error: curl is not installed or not in your PATH. Please install curl to use this command.'
    echohl None
  endif

  # 2. Construct the URL for the upstream syntax file
  final url = 'https://raw.githubusercontent.com/vim/vim/master/runtime/syntax/' .. filetype .. '.vim'

  # 3. Determine the target directory and file path
  final target_dir = expand('~/.vim/syntax/')
  final target_file = target_dir .. filetype .. '.vim'

  # 4. Ensure the target directory exists
  if !isdirectory(target_dir)
    try
      # 'p' flag creates parent directories if they don't exist
      # The 'call' keyword is still needed for built-in functions like mkdir()
      call mkdir(target_dir, 'p')
      echomsg $"Created directory: {target_dir}"
    catch /E157:/
      echohl WarningMsg
      echomsg $"Could not create directory: {target_dir}. Check permissions."
      echohl None
    endtry
  endif

  # 5. Download the file using curl
  #    -sS: silent mode, but show errors (-S)
  #    -L: follow redirects
  #    -o: write output to a specified file
  #    shellescape() is crucial for security to properly quote arguments for the shell command
  final cmd = 'curl -sSLo ' .. shellescape(target_file) .. ' ' .. shellescape(url)
  echomsg $"Downloading {url} to {target_file}..."

  # Execute the shell command and capture its output
  final output = system(cmd)

  # 6. Report status based on curl's exit code
  if v:shell_error != 0
    echohl ErrorMsg
    echomsg $"Failed to download syntax file for {filetype}."
    echomsg $"Curl output (if any): {output}"
    echomsg $"Please check if the filetype \"{filetype}\" exists in the Vim repository at: {url}"
    echohl None
  else
    echomsg $"Successfully downloaded syntax file for {filetype} to {target_file}"
    # You might want to automatically source the file or reload syntax for current buffers
    # For now, we just confirm the download.
  endif
enddef

# Define the user command
# -nargs=1: requires exactly one argument (the filetype string)
# <f-args>: passes the arguments provided to the command to the function
# In Vim9, 'call' is not needed when invoking a script-local function from a command.
command! -nargs=1 UpstreamSyntax UpstreamSyntax(<f-args>)

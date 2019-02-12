let s:rspec_executable = 'rspec --format progress'

function! RSpec_RunAllSpecs()
  let s:last_spec = ''
  call s:RunSpecs(s:last_spec)
endfunction

function! RSpec_RunCurrentSpecFile()
  if s:InSpecFile()
    let s:last_spec = expand('%')
    call s:RunSpecs(s:last_spec)
  endif
endfunction

function! RSpec_RunNearestSpec()
  if s:InSpecFile()
    let s:last_spec = expand('%').':'.line('.')
    call s:RunSpecs(s:last_spec)
  endif
endfunction

function! RSpec_RunLastSpec()
  if exists('s:last_spec')
    call s:RunSpecs(s:last_spec)
  endif
endfunction

" local functions

function! s:RunSpecs(spec_location)
  let s:rspec_command = s:Command(a:spec_location)

  execute s:rspec_command
endfunction

function! s:Command(spec_location)
  return '!'.
       \ 'echo '.s:rspec_executable.' '.a:spec_location.
       \ s:AndCommand().
       \ s:rspec_executable.' '.a:spec_location
endfunction

function! s:AndCommand()
  if system('echo -n $SHELL') =~# 'fish$'
    return '; and '
  else
    return ' && '
  endif
endfunction

function! s:InSpecFile()
  return expand('%:t:r') =~# '_spec$'
endfunction

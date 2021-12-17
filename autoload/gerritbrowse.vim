if exists('g:autoloaded_gerritbrowse')
  finish
endif
let g:autoloaded_gerritbrowse = 1

function! gerritbrowse#HomepageForUrl(url) abort
  if match(a:url, '@gerrit\.') >= 0
    " E.g.: ssh://username@gerrit.subdomain.domain.org:18382/src
    " To:   https://gerrit.subdomain.domain.org
    let fix_start = substitute(a:url, '^ssh://[^@]*@', 'https://', '')
    let fix_end = substitute(l:fix_start, ':[^:]*$', '', '')
    return l:fix_end
  else
    return ''
  endif
endfunction

function! gerritbrowse#FugitiveUrl(...) abort
  if a:0 == 1 || type(a:1) == type({})
    let opts = a:1
    let root = gerritbrowse#HomepageForUrl(get(opts, 'remote', ''))
  else
    return ''
  endif
  if empty(root)
    return ''
  endif
  let commit = get(opts, 'commit')
  let body = system(FugitiveShellCommand() . ' show ' . l:commit)
  let change_id = substitute(matchstr(body, 'Change-Id: [^\n]*'), 'Change-Id: ', '', '')
  if change_id ==# ''
    return ''
  endif
  return root . '/#/q/'. l:change_id
endfunction

function! gerritbrowse#fugitive_url(...) abort
  return call('gerritbrowse#FugitiveUrl', a:000)
endfunction


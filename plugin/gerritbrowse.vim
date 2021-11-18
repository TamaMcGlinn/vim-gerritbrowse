
let s:gerrit_browse = function('gerritbrowse#FugitiveUrl')
if !exists("g:fugitive_browse_handlers")
  let g:fugitive_browse_handlers = []
endif
if index(g:fugitive_browse_handlers, s:gerrit_browse) < 0
  call insert(g:fugitive_browse_handlers, s:gerrit_browse)
endif

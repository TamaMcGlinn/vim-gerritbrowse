
if index(g:fugitive_browse_handlers, function('gerritbrowse#FugitiveUrl')) < 0
  call insert(g:fugitive_browse_handlers, function('gerritbrowse#FugitiveUrl'))
endif

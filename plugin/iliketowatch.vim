"-----------------------------------vim file-----------------------------------"
"  File Name: iliketowatch.vim
"  Purpose: Watches for changes to files in a given folder and refreshes
"           related browser tabs
"
"  Creation Date:
"  Last Modified:
"  Created By: Ian Mouzon
"--------------------------------------**--------------------------------------"

"default browser is google chrome
if !exists("g:iliketowatch_browser")
   let g:iliketowatch_browser = "Google Chrome"
endif

"start by watching nothing
if !exists("g:iliketowatch_roots")
   let g:iliketowatch_roots = []
endif

if !exists("g:iliketowatch_plugindir")
   let g:iliketowatch_plugindir="~/.vim/bundle/iliketowatch/"
endif
 
"Manage which folders are being watched
function! g:WatchFolders_iliketowatch(...)
   "determine which root folder we should be watching
   if a:0 == 0 
      let iliketowatch_this = expand("%:p:h")
   else
      let iliketowatch_this = expand(a:1)
   endif

   "check for duplicate entries unless no folders are being watched yet
   "check that we aren't already watching this folder
   "and remove folders we are watching that are contained by this folder
   let iliketowatch_newroot = 0
   let N = len(g:iliketowatch_roots)
   let stopwatching_list = []

   if N > 0
      let i = N 
      "we are already watching some roots so make sure this isn't a repeat
      while i > 0 
         let i = i - 1
         "match(dir_a,dir_b) = 0 if dir_a is under dir_b
         if match(iliketowatch_this,g:iliketowatch_roots[i]) > -1
            "then iliketowatch_newroot isn't zero anymore
            let iliketowatch_newroot = iliketowatch_newroot + 1
         else 
            if match(g:iliketowatch_roots[i],iliketowatch_this) > -1
               "then this directory contains element [i] from the list
               call remove(g:iliketowatch_roots,i)
            endif
         endif
      endwhile
   endif

   "iliketowatch_newroot = 0 if the root is new
   "                     = 1 if the root is not new
   if iliketowatch_newroot == 0
      echom "Watching everything under ".iliketowatch_this
      let g:iliketowatch_newroot = add(g:iliketowatch_roots,iliketowatch_this)
   else
      echom "Already watching everything under ".iliketowatch_this
   endif

   "sort the unique roots
   let g:iliketowatch_roots = uniq(sort(g:iliketowatch_roots))
endfunction

function! g:StopWatching_iliketowatch(...)
   if a:0 == 0
      let g:iliketowatch_roots = []
   else
      "check for duplicate entries unless no folders are being watched yet
      "check that we aren't already watching this folder
      "and remove folders we are watching that are contained by this folder
      let N = len(g:iliketowatch_roots)
      let stopwatching_list = []
      let iliketowatch_stop = a:1

      if N > 0
         let i = N 
         "we are already watching some roots so make sure this isn't a repeat
         while i > 0 
            let i = i - 1
            if match(g:iliketowatch_roots[i],iliketowatch_stop) > -1
               "then this directory contains element [i] from the list
               call remove(g:iliketowatch_roots,i)
            endif
         endwhile
      endif
   endif
endfunction

"write these as commands
command! -nargs=? Iliketowatch call g:WatchFolders_iliketowatch(<f-args>)
ab iliketowatch Iliketowatch

command! -nargs=? Nodontwatch call g:StopWatching_iliketowatch(<f-args>)
ab nodontwatch Nodontwatch 


let g:iliketowatch_JSenv = "osascript -l JavaScript"
let g:iliketowatch_JSfile = "iliketowatch.js"
"Run JS for current files root project directory
function! g:RunJS_iliketowatch()
   let folderarg = expand("%:p:h")
   for iliketowatch_root in g:iliketowatch_roots
      "if there is a partial match
      if match(folderarg,iliketowatch_root) > -1
         "then we need to refresh these roots
         let call_temp = g:iliketowatch_JSenv." ".g:iliketowatch_plugindir.g:iliketowatch_JSfile." ".g:iliketowatch_browser." ".folderarg
         silent call system(call_temp)
         execute  
      endif
   endfor
endfunction

"force a refresh
command! Ihavetowatch call g:RunJS_iliketowatch(<f-args>)
ab ihavetowatch Ihavetowatch

"refreshing automatically
autocmd Bufwritepost,filewritepost * call g:RunJS_iliketowatch()

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
function! s:WatchFolders_iliketowatch(...)
   "determine which root folder we should be watching
   if a:0 == 0 
      let iliketowatch_this = expand("%:p:h")
   else
      let iliketowatch_this = expand(a:1)
   endif

   "check for duplicate entries unless no folders are being watched yet
   let iliketowatch_newroot = 0

   "check that we aren't already watching this folder
   if len("g:iliketowatch_roots") > 0
      "we are already watching some roots so make sure this isn't a repeat
      for iliketowatch_root in g:iliketowatch_roots
         "match(dir_a,dir_b) = 0 if dir_a is under dir_b
         if match(iliketowatch_this,iliketowatch_root) > -1
            "then iliketowatch_newroot isn't zero anymore
            let iliketowatch_newroot = iliketowatch_newroot + 1
         endif
      endfor
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

"Run JS for current files root project directory
function! s:RunJS_iliketowatch()
   let folderarg = expand("%:p:h")
   for iliketowatch_root in g:iliketowatch_roots
      "if there is a partial match
      if match(folderarg,iliketowatch_root) > -1
         "then we need to refresh these roots
         let call_temp = "osascript -l JavaScript iliketowatch.js ".g:iliketowatch_browser." ".folderarg
         silent call system(call_temp)
         execute  
      endif
   endfor
endfunction


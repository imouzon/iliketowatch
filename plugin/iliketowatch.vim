"-----------------------------------vim file-----------------------------------"
"  File Name: iliketowatch.vim
"  Purpose: Watches for changes to files in a given folder and refreshes
"           related browser tabs
"
"  Creation Date:
"  Last Modified:
"  Created By: Ian Mouzon
"--------------------------------------**--------------------------------------"

" Overview
" ========

" ## Important Variables 
"
" -  g:iliketowatch_browser: the browser being used 
"    -  default: 'Google Chrome'
"    -  can be set in the vimrc; see README.md for valid values
"
" -  g:iliketowatch_roots: list of the root directories being watched
"    -  initially: empty
"    -  entries are added by g:WatchFolders_iliketowatch(...)
"    -  entries are removed by g:StopWatching_iliketowatch(...)
"
" -  g:iliketowatch_plugindir: the directory containing the plugin
"    -  default: '~/.vim/bundle/iliketowatch/'
"    -  can be set in the vimrc
"    -  a weakness on my part, I don't know how to store the js properly
"
" -  g:iliketowatch_JSenv: how is the js file being called
"    -  default: 'osascript -l JavaScript' (needs mac)

" ## Commands for the user
"
" -  iliketowatch: Start watching the current folder and down
" -  nodontwatch: Stop watching the current folder and down


" ## Initialization
" if the user has not set g:iliketowatch_browser then use Google Chrome
if !exists("g:iliketowatch_browser")
   let g:iliketowatch_browser = "Google Chrome"
endif

"start by watching nothing
if !exists("g:iliketowatch_roots")
   let g:iliketowatch_roots = []
endif

" where is this plugin stored?
if !exists("g:iliketowatch_plugindir")
   let g:iliketowatch_plugindir="~/.vim/bundle/iliketowatch/"
endif
 
" ## Updating
" ### Add new folder paths
function! g:WatchFolders_iliketowatch(...)
   "determine which root folder we should be watching
   if a:0 == 0 
      let watch_this = expand("%:p:h")
   else
      let watch_this = expand(a:1)
   endif

   "check for duplicate entries unless no folders are being watched yet
   "check that we aren't already watching this folder
   "and remove folders we are watching that are contained by this folder
   let watch_newroot = 0
   let N = len(g:iliketowatch_roots)
   let stopwatching_list = []

   if N > 0
      let i = N 
      "we are already watching some roots so make sure this isn't a repeat
      while i > 0 
         let i = i - 1
         "match(dir_a,dir_b) = 0 if dir_a is under dir_b
         if match(watch_this,g:iliketowatch_roots[i]) > -1
            "then watch_newroot isn't zero anymore
            let watch_newroot = watch_newroot + 1
         else 
            if match(g:iliketowatch_roots[i],watch_this) > -1
               "then this directory contains element [i] from the list
               call remove(g:iliketowatch_roots,i)
            endif
         endif
      endwhile
   endif

   "watch_newroot = 0 if the root is new
   "              = 1 if the root is not new
   if watch_newroot == 0
      echom "Watching everything under ".watch_this
      let new_roots = add(g:iliketowatch_roots,watch_this)
   else
      echom "Already watching everything under ".watch_this
   endif

   "sort the unique roots
   let g:iliketowatch_roots = uniq(sort(new_roots))
endfunction

" ### remove folder paths
function! g:StopWatching_iliketowatch(...)
   if a:0 == 0
      let g:iliketowatch_roots = []
   else
      "check for duplicate entries unless no folders are being watched yet
      "check that we aren't already watching this folder
      "and remove folders we are watching that are contained by this folder
      let N = len(g:iliketowatch_roots)
      let stopwatching_list = []
      let watch_stop = a:1

      if N > 0
         let i = N 
         "we are already watching some roots so make sure this isn't a repeat
         while i > 0 
            let i = i - 1
            if match(g:iliketowatch_roots[i],watch_stop) > -1
               "then this directory contains element [i] from the list
               call remove(g:iliketowatch_roots,i)
            endif
         endwhile
      endif
   endif
endfunction

" ## Running the App
"Run JS for current files root project directory
function! g:RunJS_iliketowatch()

   "define the call commands
   let JSenv = "osascript -l JavaScript"

   "the file name
   let JSfile = "iliketowatch.js"

   "get the folder of the current file being saved
   let folderarg = expand("%:p:h")

   "for each of the folders being watch
   for watch_root in g:iliketowatch_roots

      "if there is a partial match
      if match(folderarg,watch_root) > -1

         "then we need to refresh these roots
         let call_temp = JSenv." ".g:iliketowatch_plugindir."js/".JSfile." ".g:iliketowatch_browser." ".folderarg

         silent call system(call_temp)
         "execute  
         
      endif

   endfor

endfunction


" ## Commands for the user
"
" -  Start watching the current folder and down: iliketowatch
" -  Stop watching the current folder and down:  nodontwatch 
command! -nargs=? Iliketowatch call g:WatchFolders_iliketowatch(<f-args>)
ab iliketowatch Iliketowatch

command! -nargs=? Nodontwatch call g:StopWatching_iliketowatch(<f-args>)
ab nodontwatch Nodontwatch 

"force a refresh
command! Ihavetowatch call g:RunJS_iliketowatch(<f-args>)
ab ihavetowatch Ihavetowatch

"refreshing automatically
autocmd BufWritePost,FileWritePost * call g:RunJS_iliketowatch()

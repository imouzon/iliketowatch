`iliketowatch`
================================================================

Automatically reload pages from Vim
================================================================
- [Introduction](#introduction)
- [Usage](#usage)
- [Installation and Requirements](#installation)
- [Options](#options)
- [Upcoming](#upcoming)

#Introduction 
##Don't click away your focus
<<<<<<< HEAD

=======
>>>>>>> version-0.1
One of the many benefits of working on modular documents and webpages that can be rendered in a browser is the chance to see your progress as you work.

Or, well, almost as you work. You just need to click refresh. 

Keeping track of which changes you have made and which you need to make as you alternate between different programming languages while navigating around your document structure can be an enormous hassle on its own. 
But when you have to leave the editor you are working in, move your mouse over to your browser and refresh you have just done something that took your focus off your work.
And this is assuming you can find your page right away - I usually have to search around multiple windows and tabs just to find the document I'm working on, all the time moving away from tabs that were open to books and websites I was referencing as I wrote the code. 
So now I have to find those pages again, but, um, then, so this article looks interesting... 

just gonna skim this real quick...

Wait - what was I trying to get this page to do again?

**Focus gone**

This small distraction is worse than an annoyance - it can actually prevent you from being as effective as you need to be.

##`iliketowatch` takes care of this hassle for you

And it doesn't even mind - it likes watching. 
It's the only job it has. 
Whenever a file in your current project path is saved, `iliketowatch` searches browser tabs for files that are in the same path. 
When it finds a one, it refreshes the tab and you see your results. 
It's as simple as that.
Checking your results only takes a glance, leaving your focus in Vim and on your work.

#Usage

There are three basic commands that perform all the tasks you need:

-  `iliketowatch`
-  `nodontwatch`
-  `ihavetowatch`

###`iliketowatch` to start watching

To start watching a file and all files in the same directory or child directories of the files directory, use `:iliketowatch`

For example, suppose I was testing a alternating between themes for a document, `document.html`, generated by files in the structure:

```
.
├── res 
│   ├── css
│   │   ├── main-theme.css
│   │   ├── blue-theme.css
│   │   ├── red-theme.css
│   │   ├── blue-theme
│   │   │   ├── background.png
│   │   │   └── header.png
│   │   └── red-theme
│   │       ├── background.png
│   │       └── header.png
│   ├── img
│   │   └── title.png
│   └── js
│       ├── main.js
│       ├── 
│       └── plugins.j
└── document.html
```
From the root directory `.` I can open the document in my default browser using Vim's command line:
```vim
:!open document.html
```
And start watching the entire folder using:
```vim
:iliketowatch
```
or, if Vim's current directory is not in your project's root directory, enter
```vim
:iliketowatch \path\to\project\root
```
`iliketowatch` is now watching the files in your project directory. 
If you make changes to `blue-theme.css` then when you save your changes `iliketowatch` refreshes the
tab displaying `document.js`. If you make changes to `title.png`, `iliketowatch` refreshes `document.html`
If you edit and save a file outside of the path, `iliketowatch.js` does nothing.

###`nodontwatch` to stop watching
To stop watching for changes in a given path, use
```vim
:nodontwatch \path\to\stop\watching
```
to stop watching all folders, simply use
```vim
:nodontwatch
```

###`ihavetowatch` forces a refresh for the current files project directory
Assuming we have already started watching the project structure an open file is in, using
```vim
:ihavetowatch
```
will refresh tabs displaying files from the same folder path.

##Installation
Using [Vundle](https://github.com/gmarik/Vundle.vim) from inside Vim:
```vim
:PluginInstall 'imouzon/iliketowatch'
```

#### Can I use `pathogen` or some other package manager instead?

![no_and_the_game](https://raw.githubusercontent.com/imouzon/imouzon.github.io/master/figure/no_and_the_game.gif)

**Just kidding** - you do have to set an extra option in your `.vimrc` though, see `idontliketowatch_plugindir` in the options section.


### Requirements

#### Operating system
Right now `iliketowatch` has only tested in a few situations, but you certainly need OS X Yosemite or better (OS X version > 10.10.1).
It has worked in Yosemite and El Capitan.

#### Supported Browsers
The following browsers are currently supported:

-  Google Chrome
-  Google Chrome Canary
-  Chromium
-  Firefox
-  Safari

Adding support for a new browser is not a complicated process at this point (just a switch in the JavaScript). 
If you file an issue the browser will be added quickly.

I will try to get everything more general in the future, but at the moment this specific set up is required.
At the moment, this plugin uses javascript and the Javascript for Automation tool set that comes packaged with Apple's Yosemite operating system. 
Out of the box, this means that the code must be called using `oascript`. 
It may be possible to modify the code slightly and make it work using node as in [OSA](https://www.npmjs.com/package/osa) but I haven't tested this completely yet.

The package assumes that the plugin is installed under `~/.vim/bundle/`, the default for Vundle, though this is modifiable (see the options below).

##Options
###Setting the browser
You can set the browser using
```vim
"For Google Chrome
let g:iliketowatch_browser = "chrome"

"For Firefox
let g:iliketowatch_browser = "firefox"

"For Chromium
let g:iliketowatch_browser = "chromium"

"For Google Chrome Canary
let g:iliketowatch_browser = "canary"

"For Safari
let g:iliketowatch_browser = "safari"
```

###Bundle directory
At the moment, `iliketowatch` assumes that plugins are stored under `~/.vim/bundle/`.
If that is not the case, setting the path to your plugins can be done using:
```vim
let g:iliketowatch_plugindir = "/path/to/vim/plugins/"
```

##Upcoming

I am currently (when I have the time) working on three goals:

1.  Adjusting the way the JS function is called so that using Vundle isn't required.
2.  The app does not work well in tmux because osascript and the JXA functions not work well in tmux. Since I use tmux consistently, this matters a lot to me.
3.  Working on the JavaScript so that it can be run in node using the osx package - this way the add-on can travel to other operating systems.

I will be making these (and other adjustments) in the future it in the future if time permits (keep watching).

<!--
.
├── res 
│   ├── css
│   │   ├── main-theme.css
│   │   ├── blue-theme.css
│   │   ├── red-theme.css
│   │   ├── blue-theme
│   │   │   ├── background.png
│   │   │   └── header.png
│   │   └── blue-theme
│   │       ├── background.png
│   │       └── header.png
│   ├── img
│   │   ├── title.png
│   │   ├── favicon.ico
│   │   ├── tile-wide.png
│   │   ├── tile.png
│   │   ├── avatar.png
│   │   └── posts
│   │       ├── thoughts.png
│   │       └── ...
│   │       └── ...
│   │       └── ...
│   ├── js
│   │   ├── main.js
│   │   ├── plugins.js
│   │   └── vendor
│   │       ├── jquery.min.js
│   │       └── modernizr.min.js
│   └── R
│       ├── ui.R
│       └── server.R
├── doc
│   ├── editing.md
│   └── about.md
├── .editorconfig
├── .htaccess
├── 404.html
├── browserconfig.xml
├── crossdomain.xml
├── index.html
├── humans.txt
├── robots.txt
├── favicon.ico
├── tile-wide.png
└── tile.png
-->

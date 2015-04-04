#!/usr/bin/env osascript -l JavaScript
var watchr = require('watchr');

//which browsers do we know
var chromeBrowsers = ("chrome", "google chrome");
var canaryBrowsers = ("canary", "chrome canary", "google chrome canary");
var safariBrowsers = ("safari");
var firefoxBrowsers = ("firefox", "mozilla");
var KnownBrowsers = chromeBrowsers.concat(safariBrowsers,firefoxBrowsers);

function run(argv) {
   //The first argument is the browser
   browserArg = argv.splice(0,1);

   browser = (function(browserArg,KnownBrowsers){
      switch(KnownBrowsers.indexOf(browserArg)){
         case 0:
         case 1:
         default:
            browser = "Google Chrome";
            break;
         case 2:
         case 3:
         case 4:
            browser = "Google Chrome Canary";
            break;
         case 5:
            browser = "Safari";
            break;
         case 6:
         case 7:
            browser = "Firefox";
            break;
      }
      return browser;
   }(browserArg,KnownBrowsers));

   //now we know the browser, start watching folders
   watchr.watch({
      paths: argv,
      listeners: {
         log: function(logLevel){
            console.log('a log message occurred:',arguments);
         },
         error: function(err){
            console.log('an error occurred:',err);
         },
         watching: function(err){
            if(err){
               console.log("watching the path " + watcherInstance.path + " failed with error", err);
            }else{
               console.log("watching the path " + watcherInstance.path + " completed");
            }
         },
         change: function(changeType,filePath,fileCurrentStat,filePreviousStat){
            console.log('a change has occurred:', arguments);
         }
      },
      next: function(err,watchers){
         if (err) {
            return console.log("watching everything failed with error", err);
         } else {
            console.log('watching everything completed', watchers);
         }

         setTimeout(function(){
            var i;
            console.log('Stop watching our paths');
            for (i = 0; i<watchers.length; i++) {
               watchers[i].close();
            }
         },60*1000);
      }
   });








   var fileopen = 0;
   for (var i in browser.windows){
      for (var j in browser.windows[i].tabs){
         var currURL = String(browser.windows[i].tabs[j].url());
         if(currURL.indexOf(folder) > -1){
            console.log("Reloading " + currURL);
            browser.windows[i].tabs[j].reload();
         }
         if(currURL.indexOf(file) > -1){
            fileopen = 1;
         }
      }
      if(fileopen < 1){
         browser.windows.open(file);
      }
   }

}

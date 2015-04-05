//----------------------------------------------------------------------------//
//   File Name: reportURL.js
//   Purpose:
//
//   Creation Date: 25-03-2015
//   Last Modified: Sun Apr  5 14:22:06 2015
//   Created By:
//----------------------------------------------------------------------------//

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

   var browser = Application(browser);
   var folder = argv.splice(0,1);

   var fileopen = 0;
   for (var i in browser.windows){
      for (var j in browser.windows[i].tabs){
         var currURL = String(browser.windows[i].tabs[j].url());
         if(currURL.indexOf(folder) > -1){
            console.log("Reloading " + currURL);
            browser.windows[i].tabs[j].reload();
         }
      }
   }
   
   delay(1);
}

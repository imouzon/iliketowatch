//----------------------------------------------------------------------------//
//   File Name: reportURL.js
//   Purpose:
//
//   Creation Date: 25-03-2015
//   Last Modified: Fri Sep 11 19:00:30 2015
//   Created By:
//----------------------------------------------------------------------------//
//which browsers do we know
var chromeBrowsers = ["chrome", "google chrome"];
var canaryBrowsers = ["canary", "chrome canary", "google chrome canary"];
var safariBrowsers = ["safari"];
var firefoxBrowsers = ["firefox", "mozilla"];
var chromiumBrowsers = ["chromium"];
var KnownBrowsers = chromeBrowsers.concat(canaryBrowsers,safariBrowsers,firefoxBrowsers,chromiumBrowsers);

function run(argv) {
   //The first argument is the browser
   var browser = String(argv.splice(0,1));

   //The second argument is the file location
   var folder = argv.splice(0,1);

   var browserID = (function(browserArg){

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
         case 8:
            browser = "Chromium";
      }

      return browser;
   }(browser));

   var browser = Application(browserID);

   for (var i in browser.windows){

      for (var j in browser.windows[i].tabs){

         var currURL = browser.windows[i].tabs[j].url();

         if(currURL.indexOf(folder) > -1){

            console.log("Reloading " + currURL + " (" + browserID + " window " + i + ", tab " + j + ")");

            browser.windows[i].tabs[j].reload();

            delay(.2);

         }


      }

   }

}

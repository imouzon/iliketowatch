//----------------------------------------------------------------------------//
//   File Name: iliketowatch_node.js
//   Purpose:
//
//   Creation Date: 11-09-2015
//   Last Modified: Mon Sep 21 12:26:58 2015
//   Created By:
//----------------------------------------------------------------------------//
//

getBrowserID = function(browserArg){

   //which browsers do we know
   var chromeBrowsers = ["chrome", "google chrome"];
   var canaryBrowsers = ["canary", "chrome canary", "google chrome canary"];
   var safariBrowsers = ["safari"];
   var firefoxBrowsers = ["firefox", "mozilla"];
   var chromiumBrowsers = ["chromium"];
   var KnownBrowsers = chromeBrowsers.concat(canaryBrowsers,safariBrowsers,firefoxBrowsers,chromiumBrowsers);

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

}


iliketowatch = function (browserID, folder, done) {

   var browser = Application(browserID);

   var browserURL = browser.windows[0].tabs[0].url();

//   for (var i in browser.windows){
//
//      for (var j in browser.windows[i].tabs){
//
//         var currURL = browser.windows[i].tabs[j].url();
//
//         if(currURL.indexOf(folder) > -1){
//
//            browser.windows[i].tabs[j].reload();
//
//            delay(.2);
//
//         }
//
//
//      }
//
//   }

   return(browserURL);

}

responseHandler = function(err, result, log) {
   var stringToPrint = "success";

   if (err) {
      console.error(err);
   } else {
      stringToPrint = "success" + result;
      console.log(stringToPrint);
   }
}

//process.argv contains what was entered into the command line
//process.argv[0] is "node";
//process.argv[1] is the js file name

//The first argument is the browser
//var browser = String(process.argv[2]);
var browser = "canary";
var browserID = getBrowserID(browser);

//The second is the folder
var folder = "/Users/user/js";
//var folder = String(process.argv[3]);

osa = require('osa');

osa(iliketowatch, browserID, folder, responseHandler);

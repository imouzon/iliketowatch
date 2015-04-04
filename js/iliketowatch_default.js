//----------------------------------------------------------------------------//
//   File Name: reportURL.js
//   Purpose:
//
//   Creation Date: 25-03-2015
//   Last Modified: Thu Apr  2 18:10:45 2015
//   Created By:
//----------------------------------------------------------------------------//

var folder = "~/html/";
var browser = Application(browser);

for (var i in browser.windows){
   for (var j in browser.windows[i].tabs){
      var curr_url = String(browser.windows[i].tabs[j].url());
      if(curr_url.indexOf(folder) > -1){
         console.log("Reloading " + curr_url);
         browser.windows[i].tabs[j].reload();
      }
   }
}

delay(1);

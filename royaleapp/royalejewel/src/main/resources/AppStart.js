function getCurrentScript(callback) {
    if (document.currentScript) {
      callback(document.currentScript);
      return;
    }
    var scripts = document.scripts;
    function onLoad() {
      for (var i = 0; i < scripts.length; ++i) {
        scripts[i].removeEventListener('load', onLoad, false);
      }
      callback(event.target);
    }
    for (var i = 0; i < scripts.length; ++i) {
      scripts[i].addEventListener('load', onLoad, false);
    }
  }
  
  getCurrentScript(function(currentScript) {
    window.console.log(currentScript.src);
  });
new App().start();

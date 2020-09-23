using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;

var sensArray, sensArrayInd;
var values;
const imageFont = Application.loadResource(Rez.Fonts.images);
const bigFont = Application.loadResource(Rez.Fonts.big);
const medFont = Application.loadResource(Rez.Fonts.med);
var smallFont;

class SensorHistoryWidgetApp extends Application.AppBase {


    function initialize() {
    	if (System.getSystemStats().totalMemory > 62000){
    		smallFont = Application.loadResource(Rez.Fonts.small);
    	}else{
    		smallFont = Graphics.FONT_XTINY;
    	}
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new SensorHistoryWidgetView(), new InputDelegate() ];
    }

	function onSettingsChanged() { // triggered by settings change in GCM
	    WatchUi.requestUpdate();   // update the view to reflect changes
	}
}
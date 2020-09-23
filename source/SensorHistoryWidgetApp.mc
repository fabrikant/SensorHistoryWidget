using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;

var sensArray, sensArrayInd;
var values;
var imageFont;
var bigFont;
var medFont;
var smallFont;

enum{
	CURRENT_INDEX,
	IMAGE_FONT,
	BIG_FONT,
	SMALL_FONT,
	MED_FONT
}
class SensorHistoryWidgetApp extends Application.AppBase {


    function initialize() {
    	imageFont = Application.loadResource(Rez.Fonts.images);
    	sensArrayInd = Tools.getStorage(CURRENT_INDEX, 0);
		Tools.getSenseArray();
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

	function getGlanceView() {
        return [ new HistoryGlanceView() ];
    }

	function onSettingsChanged() { // triggered by settings change in GCM
	    WatchUi.requestUpdate();   // update the view to reflect changes
	}
}
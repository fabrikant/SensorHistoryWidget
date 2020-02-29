using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

var last_key = null;
var last_behavior = null;
var buttons_pressed = null;
var buttons_expected = null;

class InputDelegate extends WatchUi.BehaviorDelegate {

    enum {
        ON_NEXT_PAGE,
        ON_PREV_PAGE,
        ON_MENU,
        ON_BACK,
        ON_NEXT_MODE,
        ON_PREV_MODE,
        ON_SELECT
    }

    function initialize() {
        BehaviorDelegate.initialize();
        buttons_pressed = 0;
        var deviceSettings = System.getDeviceSettings();
        buttons_expected = deviceSettings.inputButtons;
    }

	function onTap(clickEvent){

		var coord = clickEvent.getCoordinates();
		if (coord[0] < System.getDeviceSettings().screenWidth/3){
			onChangePage(-1);
		}else if (coord[0] > 2 * System.getDeviceSettings().screenWidth/3){
			onChangePage(1);
		}
		return false;
	}

}

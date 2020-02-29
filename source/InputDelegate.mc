//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

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

//    function onNextPage() {
//        onChangePage(1);
//        return false;
//    }
//
//    function onPreviousPage() {
//        onChangePage(-1);
//        return false;
//    }

	function onSwipe(swipeEvent){
		var direction = swipeEvent.getDirection();
		if (direction == WatchUi.SWIPE_DOWN){
			onChangePage(1);
			return true;
		}else if(direction == WatchUi.SWIPE_UP){
			onChangePage(-1);
			return true;
		}else if(direction == WatchUi.SWIPE_LEFT){
			onChangePage(-1);
			return true;
		}else if(direction == WatchUi.SWIPE_RIGHT){
			onChangePage(-1);
			return true;
		}
		return false;
	}

	function onTap(clickEvent){
		onChangePage(1);
		return false;
	}

}

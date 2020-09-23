using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Activity;

class HistoryGlanceView extends WatchUi.GlanceView {

	function initialize() {
    	GlanceView.initialize();
	}

     function onShow() {
    }

	function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.Graphics.COLOR_BLACK);
		dc.clear();
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		
		if (sensArray.size() == 0){
			return;
		}
		var iterParam = {:period => 1, :order => SensorHistory.ORDER_NEWEST_FIRST};
    	var sample = sensArray[sensArrayInd][:iterMethod].invoke(iterParam).next();
    	var value = null;
		if (sample != null){
			var data = sample.data;
			if (data != null){
				value = sensArray[sensArrayInd][:convertetMethod].invoke(data);
			}
		}
		
		var x = 10;
		var y = dc.getHeight()/2;
		dc.drawText(x, y, imageFont, sensArray[sensArrayInd][:image], Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
		
		x += dc.getTextWidthInPixels(sensArray[sensArrayInd][:image], imageFont)+10;
		dc.drawText(x, y, Graphics.FONT_GLANCE, value, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
		 
	}
}
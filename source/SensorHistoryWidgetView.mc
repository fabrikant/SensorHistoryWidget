using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.SensorHistory;
using Toybox.Application;
using Toybox.Time.Gregorian;

function onChangePage(NextPrev){
	sensArrayInd += NextPrev;
	if (sensArrayInd >= sensArray.size()){
		sensArrayInd = 0;
	}else if (sensArrayInd < 0){
		sensArrayInd = sensArray.size()-1;
	}
	values[:image] = sensArray[sensArrayInd][:image];
	WatchUi.requestUpdate();
}

class SensorHistoryWidgetView extends WatchUi.View {

	var arrowWidth;

    function initialize() {
		
    	if (System.getSystemStats().totalMemory > 62000){
    		bigFont = Application.loadResource(Rez.Fonts.big);
			medFont = Application.loadResource(Rez.Fonts.med);
    		smallFont = Application.loadResource(Rez.Fonts.small);
    	}else{
    		bigFont = Application.loadResource(Rez.Fonts.big);
			medFont = Graphics.FONT_SYSTEM_SMALL;
    		smallFont = Graphics.FONT_XTINY;
    	}

		View.initialize();
    	values = {
    		:min => 0,
    		:max => 0,
    		:last => 0,
    		:image => sensArray[sensArrayInd][:image]
    	};
    }

    // Load your resources here
    function onLayout(dc) {
		var graphLayer =  new GraphLayer(
			{
				:dc => dc,
				:id => :graph
			}
		);

		var yOffset = 5;
		var minLayer = new TextLayer(
			{
				:dc => dc,
				:id => :min,
				:maxLenght => 4,
				:x => 0,
				:y => 0,
				:font => MED_FONT,
				:color => Graphics.COLOR_BLUE

			}
		);
		var maxLayer = new TextLayer(
			{
				:dc => dc,
				:id => :max,
				:maxLenght => 4,
				:x => 0,
				:y => 0,
				:font => MED_FONT,
				:color => Graphics.COLOR_RED

			}
		);
		var lastLayer = new TextLayer(
			{
				:dc => dc,
				:id => :last,
				:maxLenght => 4,
				:x => 0,
				:y => 0,
				:font => BIG_FONT

			}
		);

		var imageLayer = new TextLayer(
			{
				:dc => dc,
				:id => :image,
				:maxLenght => 2,
				:x => 0,
				:y => 0,
				:font => IMAGE_FONT,
				:color => Graphics.COLOR_LT_GRAY
			}
		);

		minLayer.setX(graphLayer.getX());
		minLayer.setY(graphLayer.getY()-minLayer.height - yOffset);

		lastLayer.setX(minLayer.getX()+minLayer.width + yOffset);
		lastLayer.setY(graphLayer.getY()-lastLayer.height - yOffset);

		maxLayer.setX(graphLayer.getX());
		maxLayer.setY(lastLayer.getY());

		var coord = Tools.coordTop(dc, imageLayer.width, imageLayer.height);
		imageLayer.setX(coord[0]);
		imageLayer.setY(coord[1]);

		View.addLayer(imageLayer);
		View.addLayer(graphLayer);
		View.addLayer(minLayer);
		View.addLayer(lastLayer);
		View.addLayer(maxLayer);

		arrowWidth = graphLayer.getX() / 2;

    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
	    if (sensArray.size() > 0){
	   		var layers = View.getLayers();
			for (var i = 0; i < layers.size(); i++){
				layers[i].draw();
			}
			drawArrow(dc, 0, 1);
			drawArrow(dc, dc.getWidth(), -1);
		}else{
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
			dc.drawText(
				dc.getWidth()/2,
				dc.getHeight()/2,
				Graphics.FONT_LARGE,
				Application.loadResource(Rez.Strings.NotAvailable),
				Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
			);
		}
    }

	function drawArrow(dc, x, direction){
		if ( System.getDeviceSettings().isTouchScreen){
			var arrowHeight = arrowWidth * 0.75;
			var y = dc.getHeight()/2;
			var pts =
				[
					[x, y],
					[x + arrowWidth * direction, y + arrowHeight],
					[x + arrowWidth * direction, y - arrowHeight]
				];
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
			dc.fillPolygon(pts);
		}
	}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	if (sensArrayInd != null){
    		Application.Storage.setValue(CURRENT_INDEX, sensArrayInd);
    	}
    }
}

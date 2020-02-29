using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.SensorHistory;
using Toybox.Application;

var sensArray, sensArrayInd;
var values;
const imageFont = Application.loadResource(Rez.Fonts.images);

function onChangePage(NextPrev){
	sensArrayInd += NextPrev;
	if (sensArrayInd >= sensArray.size()){
		sensArrayInd = 0;
	}else if (sensArrayInd < 0){
		sensArrayInd = sensArray.size()-1;
	}
//	System.println("ind3 "+sensArrayInd);
	values[:image] = sensArray[sensArrayInd][:image];
	WatchUi.requestUpdate();
}

class SensorHistoryWidgetView extends WatchUi.View {

	//var graphLayer;


    function initialize() {

    	sensArrayInd = 0;
    	sensArray = new [0];

    	if (Toybox.SensorHistory has :getHeartRateHistory){
			sensArray.add(
				{
					:iterMethod => new Lang.Method(Toybox.SensorHistory, :getHeartRateHistory),
					:convertetMethod => new Lang.Method(Tools, :heartRate),
					:image => "h"
				}
			);
    	}

    	if (Toybox.SensorHistory has :getPressureHistory){
			sensArray.add(
				{
					:iterMethod => new Lang.Method(Toybox.SensorHistory, :getPressureHistory),
					:convertetMethod => new Lang.Method(Tools, :pressure),
					:image => "b"
				}
			);
    	}

    	if (Toybox.SensorHistory has :getTemperatureHistory){
			sensArray.add(
				{
					:iterMethod => new Lang.Method(Toybox.SensorHistory, :getTemperatureHistory),
					:convertetMethod => new Lang.Method(Tools, :temperature),
					:image => "t"
				}
			);
    	}

    	if (Toybox.SensorHistory has :getElevationHistory){
			sensArray.add(
				{
					:iterMethod => new Lang.Method(Toybox.SensorHistory, :getElevationHistory),
					:convertetMethod => new Lang.Method(Tools, :elevation),
					:image => "e"
				}
			);
    	}

    	values = {
    		:min => 0,
    		:max => 0,
    		:last => 0,
    		:minTime => null,
    		:maxTime => null,
    		:image => sensArray[sensArrayInd][:image]
    	};

        View.initialize();
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
				:font => Graphics.FONT_SYSTEM_LARGE,
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
				:font => Graphics.FONT_SYSTEM_LARGE,
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
				:font => Graphics.FONT_NUMBER_HOT

			}
		);

		var imageLayer = new TextLayer(
			{
				:dc => dc,
				:id => :image,
				:maxLenght => 2,
				:x => 0,
				:y => 0,
				:font => imageFont,
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



    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
   		var layers = View.getLayers();
		for (var i = 0; i < layers.size(); i++){
			layers[i].draw();
		}
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

	function drawPage(dc){


	}
}

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.SensorHistory;
using Toybox.Time;
using Toybox.Time.Gregorian;


class GraphLayer extends WatchUi.Layer {

	var width = 0, height = 0, color;

    function initialize(param) {

		var _hw = Tools.getGraphLayerHW();
		height = _hw[0];
		width = _hw[1];
		color = Graphics.COLOR_WHITE;
		var coord = Tools.coordBottom(param[:dc], width, height);
		coord[1] = coord[1] + height - getLocalHeight();

        Layer.initialize(
        	{
        		:locX => coord[0],
        		:locY => coord[1],
        		:width => width,
        		:height => height,
        		:visibility => true,
        		:identifier	=> param[:id]
        	}
        );
    }


    function draw(){

     	clear();
    	border();
    	var iterParam = {:period => width, :order => SensorHistory.ORDER_NEWEST_FIRST};
    	var iter = sensArray[sensArrayInd][:iterMethod].invoke(iterParam);

    	var localHeight = getLocalHeight();
		axes(localHeight);


		var min = iter.getMin();
		var max = iter.getMax();
		var sample = iter.next();
		var oldX = null;
		var oldY = null;
		var x = width;
		var y = 0;
		var data;
		var targetDc = getDc();
		var lastData = null;

		var when = null;
		var hourDur = new Time.Duration(Gregorian.SECONDS_PER_HOUR);
		var showTime = true;
		var xLabel = width;

		targetDc.setPenWidth(2);

		while (sample != null){

			data = sample.data;
			if (data != null){
				if (max-min > 0){
					y = localHeight - (data - min)*localHeight/(max-min);
				}else{
					y = 0;
				}
				if (oldX != null){
					targetDc.setColor(color, Graphics.COLOR_TRANSPARENT);
					targetDc.drawLine(x, y, oldX, oldY);
				}
				oldX = x;
				oldY = y;
				if (lastData == null){
					lastData = data;
				}
			}

			if (sample.when != null){
				if (when == null){
					when = sample.when;
				}
				if(!sample.when.add(hourDur).greaterThan(when)){
					when = sample.when;
					targetDc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
					targetDc.drawLine(x, localHeight-8, x, localHeight);

					var timeInfo = Gregorian.info(when, Time.FORMAT_SHORT);
					var time = Lang.format("$1$:$2$", [timeInfo.hour.format("%02d"), timeInfo.min.format("%02d")]);
					if (xLabel - x > targetDc.getTextWidthInPixels(time, smallFont)){
						targetDc.drawText(x, localHeight, smallFont, time, Graphics.TEXT_JUSTIFY_CENTER);
						xLabel = x;
					}
				}
			}

			x -= 1;
			sample = iter.next();
		}

		values[:min] = sensArray[sensArrayInd][:convertetMethod].invoke(min);
		values[:max] = sensArray[sensArrayInd][:convertetMethod].invoke(max);
		values[:last] = sensArray[sensArrayInd][:convertetMethod].invoke(lastData);
    }

	function axes(localHeight){
		var targetDc = getDc();
		targetDc.setColor(Graphics.COLOR_LT_GRAY,Graphics.COLOR_TRANSPARENT);
		targetDc.setPenWidth(1);
		targetDc.drawLine(0, 0, 0,  localHeight-1);
		targetDc.drawLine(width-1, 0, width-1,  localHeight-1);
		targetDc.drawLine(0, localHeight-1, width-1, localHeight-1);
	}

    function border(){
    	return;
		var targetDc = getDc();
	    targetDc.setColor(color, Graphics.COLOR_TRANSPARENT);
		targetDc.drawRectangle(0, 0, width, height);
	}

    function clear(){
		var targetDc = getDc();
	    targetDc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		targetDc.fillRectangle(0, 0, width, height);
	}

	function getLocalHeight(){
		return height
    		- Graphics.getFontHeight(smallFont)
    		-(Graphics.getFontHeight(smallFont) - Graphics.getFontAscent(smallFont));
	}
}
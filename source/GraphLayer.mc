using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.SensorHistory;


class GraphLayer extends WatchUi.Layer {

	var width = 0, height = 0, color;

    function initialize(param) {


		height = 105;
		width = 180;
		color = Graphics.COLOR_WHITE;

		var coord = Tools.coordBottom(param[:dc], width, height);
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
     	axes();
    	//border();
    	var iterParam = {:period => width, :order => SensorHistory.ORDER_OLDEST_FIRST};
    	var iter = sensArray[sensArrayInd][:iterMethod].invoke(iterParam);
		var min = iter.getMin();
		var max = iter.getMax();
		var sample = iter.next();
		var oldX = null;
		var oldY = null;
		var x = 0;
		var y = 0;
		var data;
		var targetDc = getDc();

		targetDc.setPenWidth(2);
		while (sample != null){

			data = sample.data;
			if (data != null){
				y = height - (data - min)*height/(max-min);
				if (oldX != null){
					targetDc.setColor(color, Graphics.COLOR_TRANSPARENT);
					targetDc.drawLine(x, y, oldX, oldY);
				}

				if (data.equals(min)){
					values[:minTime] = sample.when;
					targetDc.setColor(Graphics.COLOR_BLUE , Graphics.COLOR_TRANSPARENT);
					targetDc.fillCircle(x, y, 3);
				}

				if (data.equals(max)){
					values[:maxTime] = sample.when;
					targetDc.setColor(Graphics.COLOR_RED , Graphics.COLOR_TRANSPARENT);
					targetDc.fillCircle(x, y, 3);
				}

			}
			x += 1;
			oldX = x;
			oldY = y;
			sample = iter.next();
		}

		var step = x/4;
		targetDc.setColor(Graphics.COLOR_LT_GRAY,Graphics.COLOR_TRANSPARENT);
		for (var i = step; i<x; i += step){
			targetDc.drawLine(i, height-8, i, height);
		}

		values[:min] = sensArray[sensArrayInd][:convertetMethod].invoke(min);
		values[:max] = sensArray[sensArrayInd][:convertetMethod].invoke(max);
		values[:last] = sensArray[sensArrayInd][:convertetMethod].invoke(data);
    }

	function axes(){
		var targetDc = getDc();
		targetDc.setColor(Graphics.COLOR_LT_GRAY,Graphics.COLOR_TRANSPARENT);
		targetDc.setPenWidth(1);
		targetDc.drawLine(0, 0, 0, width);
		targetDc.drawLine(0, height-1, width, height-1);
	}

    function border(){
		var targetDc = getDc();
	    targetDc.setColor(color, Graphics.COLOR_TRANSPARENT);
		targetDc.drawRectangle(0, 0, width, height);
	}

    function clear(){
		var targetDc = getDc();
	    targetDc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		targetDc.fillRectangle(0, 0, width, height);
	}

}
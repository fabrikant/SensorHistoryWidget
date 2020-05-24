using Toybox.WatchUi;
using Toybox.Graphics;


class TextLayer extends WatchUi.Layer {

	var width = 0, height = 0, color, fontIdx;

    function initialize(param) {

		fontIdx = param[:font];

		//var font = getFont();
		width = param[:dc].getTextWidthInPixels("."+0.format("%0"+param[:maxLenght]+"d"),  getFont());
		height = Graphics.getFontHeight( getFont())-(Graphics.getFontHeight( getFont()) - Graphics.getFontAscent( getFont()));
		if (param[:color]==null){
			color = Graphics.COLOR_WHITE;
		}else{
			color = param[:color];
		}

		//var coord = Tools.coordTop(param[:dc], width, height);
        Layer.initialize(
        	{
        		:locX => param[:x],
        		:locY => param[:y],
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
		var targetDc = getDc();
		var text = values[getId()];
		targetDc.setColor(color,Graphics.COLOR_TRANSPARENT);

		targetDc.drawText(
			width/2 - 1,
			height/2 - 1,
			getFont(),
			text,
			Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
		);
    }

    function border(){
    	return;
		var targetDc = getDc();
	    targetDc.setColor(color, Graphics.COLOR_TRANSPARENT);
		targetDc.drawRectangle(0, 0, width, height);
	}

    function clear(){
		var targetDc = getDc();
	    targetDc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		targetDc.fillRectangle(0, 0, width, height);
	}

	function getFont(){
		if (fontIdx == MED_FONT){
			return medFont;
		} else if (fontIdx == BIG_FONT){
			return bigFont;
		} else if (fontIdx == IMAGE_FONT){
			return imageFont;
		} else {
			return smallFont;
		}
	}
}
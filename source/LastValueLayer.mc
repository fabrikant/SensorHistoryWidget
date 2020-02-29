using Toybox.WatchUi;
using Toybox.Graphics;


class LastValueLayer extends TextLayer {

    function initialize(param) {
		TextLayer.initialize(param);
    }

    function draw(){
    	clear();
    	//border();
		var targetDc = getDc();
		var text = values[getId()];
		targetDc.setColor(color,Graphics.COLOR_TRANSPARENT);

		var pos = text.find("k");
		if (pos == null){
			targetDc.drawText(
				width/2 - 1,
				height/2 - 1,
				font,
				text,
				Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
			);
		}else{

			text = text.substring(0, pos);
			targetDc.drawText(
				0,
				height/2 - 1,
				font,
				text,
				Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
			);

			var kFont = Graphics.FONT_LARGE;

			var _x = targetDc.getTextWidthInPixels(text, font)+3;
			var _y = height - Graphics.getFontHeight(kFont);
			targetDc.drawText(
				_x,
				_y,
				kFont,
				"k",
				Graphics.TEXT_JUSTIFY_LEFT
			);

		}
    }
}
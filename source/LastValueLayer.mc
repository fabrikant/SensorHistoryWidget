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
		var localFont = Tools.getLastValueFont();
		targetDc.setColor(color,Graphics.COLOR_TRANSPARENT);

		var pos = text.find("k");
		if (pos == null){
			if (text.length() > 3){

				targetDc.drawText(
					width/2 - 1,
					height/2 - 1,
					Graphics.FONT_SYSTEM_SMALL,
					text,
					Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
				);
			}else{
				targetDc.drawText(
					width/2 - 1,
					height/2 - 1,
					localFont,
					text,
					Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
				);
			}
		}else{

			text = text.substring(0, pos);
			var _y = height/2 - 1;
			var justify = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
			targetDc.drawText(
				0,
				_y,
				localFont,
				text,
				justify
			);

			var kFont = Graphics.FONT_LARGE;

			var _x = targetDc.getTextWidthInPixels(text, localFont)+3;
			if (kFont != localFont){
				_y = height - Graphics.getFontHeight(kFont);
				justify = Graphics.TEXT_JUSTIFY_LEFT;
			}
			targetDc.drawText(
				_x,
				_y,
				kFont,
				"k",
				justify
			);

		}
    }
}
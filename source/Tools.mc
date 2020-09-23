using Toybox.Application;
using Toybox.System;
using Toybox.Math;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Graphics;

module Tools {

	function Pythagoras(hypotenuse, cathet){
		return Math.round(Math.sqrt(Math.pow(hypotenuse, 2)-Math.pow(cathet, 2)));
	}

   function coordBottom(dc, width, height){
    	var res = new [2];
    	var d = dc.getWidth();
    	var r = d/2;
    	res[0] = (d - width)/2;
    	var _y = Tools.Pythagoras(r, width/2);
    	res[1] = r - height + _y;
    	return res;
    }

	function coordTop(dc, width, height){
    	var res = new [2];
    	var d = dc.getWidth();
    	var r = d/2;
    	res[0] = (d - width)/2;
    	var _y = Tools.Pythagoras(r, width/2);
    	res[1] = r - _y;
    	return res;
	}

	function coordLeft(dc, width, height){


    	var res = new [2];
    	var d = dc.getWidth();
    	var r = d/2;
    	res[1] = (d - height)/2;
    	var _x = Tools.Pythagoras(r, height/2);
    	res[0] = r - _x;
    	return res;

	}

	function min(a,b){
		if(a>b){
			return b;
		} else {
			return a;
		}
	}

	function max(a,b){
		if(a>b){
			return a;
		} else {
			return b;
		}
	}

	function stringReplace(str, find, replace){
		var res = "";
		var ind = str.find(find);
		var len = find.length();
		var first;
		while (ind != null){
			if (ind == 0) {
				first = "";
			} else {
				first = str.substring(0, ind);
			}
			res = res + first + replace;
			str = str.substring(ind + len, str.length());
			ind = str.find(find);
		}
		res = res + str;
		return res;
	}

	function pressure(rawData){
		var value = rawData; /*Pa */
		var unit  = Application.Properties.getValue("PrU");
		if (unit == 0){ /*MmHg*/
			value = Math.round(rawData/133.322).format("%d");
		}else if (unit == 1){ /*Psi*/
			value = (rawData/6894.757).format("%.1f");
		}else if (unit == 2){ /*InchHg*/
			value = (rawData/3386.389).format("%.1f");
		}else if (unit == 3){ /*bar*/
			value = (rawData/100000).format("%.2f");
		}else if (unit == 4){ /*kPa*/
			value = (rawData/1000).format("%.1f");
		}else if (unit == 5){ /*hPa miliBar*/
			value = (rawData/100).format("%d");
		}
		return value;
	}

	function temperature(rawData){
		var value = rawData;/*C*/
		var unit  = System.getDeviceSettings().temperatureUnits;
		if (unit == System.UNIT_STATUTE){ /*F*/
			value = ((rawData*9/5) + 32);
		}
		return value.format("%d")+"°";
	}

	function elevation(rawData){
		var value = rawData;//meters
		var unit =  System.getDeviceSettings().elevationUnits;
		if (unit == System.UNIT_STATUTE){ /*foot*/
			value = rawData*3.281;
		}

		if (value > 9999){
			value = (value/1000).format("%.1f")+"k";
		}else if (value > 999){
			value = (value/1000).format("%.2f")+"k";
		}else{
			value =  value.format("%d");
		}

		return value;
	}

	function heartRate(rawData){
		if (rawData == null){
			return 0;
		}else{
			return rawData.format("%d");
		}
	}

	function oxygenSaturation(rawData){
		if (rawData == null){
			return 0;
		}else{
			return rawData.format("%d")+"%";
		}
	}

	function getGraphLayerHW(){
		if (System.getDeviceSettings().screenHeight == 218){
			return [110, 160];
		}else if (System.getDeviceSettings().screenHeight == 260){
			return [140, 190];
		}else{//240
			return [125, 180];
		}
	}
}
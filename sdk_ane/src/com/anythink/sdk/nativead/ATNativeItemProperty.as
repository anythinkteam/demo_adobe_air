package com.anythink.sdk.nativead
{
	import flash.geom.Rectangle;

	public class ATNativeItemProperty
	{
		public var rect:Rectangle; //容器的位置和宽高
		public var backgroundColor:String; //容器背景颜色
		public var textColor:String; //文字颜色
		public var textSize:int; //文字大小
		
		public function toJsonObject():Object
		{
			var itemObject:Object = {};
			if(rect)
			{
				itemObject["x"] = rect.x;
				itemObject["y"] = rect.y;
				itemObject["w"] = rect.width;
				itemObject["h"] = rect.height;
			}
			
			itemObject["bgColor"] = backgroundColor;
			itemObject["textColor"] = textColor;
			itemObject["textSize"] = textSize;
			return itemObject;
		}
	}
}
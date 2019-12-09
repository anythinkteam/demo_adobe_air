package com.anythink.sdk.nativead
{
public class ATNativeAdConfig
	{
		public var parentRect:ATNativeItemProperty; //父容器属性
		public var iconRect:ATNativeItemProperty; //icon属性
		public var mainImageRect:ATNativeItemProperty; //大图属性
		public var titleRect:ATNativeItemProperty; //标题属性
		public var descRect:ATNativeItemProperty; //描述文字属性
		public var adLogoRect:ATNativeItemProperty; //广告logo属性
		public var ctaRect:ATNativeItemProperty; //点击按钮属性
		
		public function toJsonString():String
		{
			var config:Object = {};
			if(parentRect){
				config["parent"] = parentRect.toJsonObject();
			}
			
			if(iconRect){
				config["icon"] = iconRect.toJsonObject();
			}
			
			if(mainImageRect){
				config["mainImage"] = mainImageRect.toJsonObject();
			}
			
			if(titleRect){
				config["title"] = titleRect.toJsonObject();
			}
			
			if(descRect){
				config["desc"] = descRect.toJsonObject();
			}
			
			if(adLogoRect){
				config["adlogo"] = adLogoRect.toJsonObject();
			}
			
			if(ctaRect){
				config["cta"] = ctaRect.toJsonObject();
			}
			return JSON.stringify(config);
		}
	}
}
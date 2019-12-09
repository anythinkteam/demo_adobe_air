package com.anythink.sdk.nativebanner
{

	public class ATNativeBannerAdConfig
	{
		public var bgColor:String; //容器背景颜色
		public var showCloseButton:Boolean; //是否展示关闭按钮
		public var ctaBgColor:String; //cta背景颜色
		public var ctaTitleSize:int; //cta标题大小(仅iOS)
		public var ctaTitleColor:String; //cta标题颜色
		public var adTitleSize:int; //标题字体大小(仅iOS)
		public var adTitleColor:String; //标题字体颜色
		public var adDescSize:int //详细文字字体大小(仅iOS)
		public var adDescColor:String;//详细文字颜色
		public var autoRefreshTime:int;//自动刷新时间, 单位:ms
		public var adBannerSize:int; //0:Auto 1:320x50 2:640x150(仅Android)
		public var showCtaButton:Boolean; //是否展示CTA按钮
		
		public function toJsonString():String
		{
			var config:Object = {};
			config["bgColor"] = bgColor;
			config["showCloseButton"] = showCloseButton;
			config["ctaBgColor"] = ctaBgColor;
			config["ctaTitleSize"] = ctaTitleSize;
			config["ctaTitleColor"] = ctaTitleColor;
			config["adTitleSize"] = adTitleSize;
			config["adTitleColor"] = adTitleColor;
			config["adDescSize"] = adDescSize;
			config["adDescColor"] = adDescColor;
			config["autoRefreshTime"] = autoRefreshTime;
			config["adBannerSize"] = adBannerSize;
			config["showCtaButton"] = showCtaButton;
			
			return JSON.stringify(config);
		}
	}
}
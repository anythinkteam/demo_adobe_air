package com.anythink.sdk.nativebanner
{

	public interface ATNativeBannerListener
	{
		function onNativeBannerLoadSuccess(unitId:String):void;
		function onNativeBannerLoadFail(unitId:String, errorMsg:String):void;
		function onNativeBannerClick(unitId:String):void;
		function onNativeBannerShow(unitId:String):void;
		function onNativeBannerClose(unitId:String):void;
		function onNativeBannerAutoRefresh(unitId:String):void;
		function onNativeBannerAutoRefreshFail(unitId:String, errorMsg:String):void;
	}
}
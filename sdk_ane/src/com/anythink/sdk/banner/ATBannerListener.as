package com.anythink.sdk.banner
{
	public interface ATBannerListener
	{
		function onBannerLoadSuccess(unitId:String):void;
		function onBannerLoadFail(unitId:String, errorMsg:String):void;
		function onBannerClick(unitId:String):void;
		function onBannerShow(unitId:String):void;
		function onBannerClose(unitId:String):void;
		function onBannerAutoRefresh(unitId:String):void;
		function onBannerAutoRefreshFail(unitId:String, errorMsg:String):void;
	}
}
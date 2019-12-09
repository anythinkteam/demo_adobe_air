package com.anythink.sdk.interstitial
{
	public interface ATInterstitialListener
	{
		function onInterstitialLoaded(unitId:String):void;
		function onInterstitialLoadFail(unitId:String, errorMsg:String):void;
		function onInterstitialCLick(unitId:String):void;
		function onInterstitialShow(unitId:String):void;
		function onInterstitialClose(unitId:String):void;
		
	}
}
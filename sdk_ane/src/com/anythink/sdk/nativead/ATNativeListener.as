package com.anythink.sdk.nativead
{
	public interface ATNativeListener
	{
		function onNativeAdLoadSuccess(unitId:String):void;
		function onNativeAdLoadFail(unitId:String, errorMsg:String):void;
		function onNativeAdClick(unitId:String):void;
		function onNativeAdShow(unitId:String):void;
		function onNativeAdVideoStart(unitId:String):void;
		function onNativeAdVideoEnd(unitId:String):void;
	}
}
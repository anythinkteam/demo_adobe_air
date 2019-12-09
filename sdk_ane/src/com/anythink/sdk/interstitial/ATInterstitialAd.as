package com.anythink.sdk.interstitial
{
import com.anythink.sdk.ATAirConst;
import com.anythink.sdk.ATAirSDK;

import flash.events.StatusEvent;

public class ATInterstitialAd
	{
		private static var interstitialListener:ATInterstitialListener;
		
		public static function setAdListener(listener:ATInterstitialListener):void
		{
			interstitialListener = listener;
		}
	
		
		public static function loadInterstitialAd(unitId:String, customObject:Object):void
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call loadInterstitialAd, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var customString:String = "";
				if(customObject != null)
				{
					customString = JSON.stringify(customObject);
				}
				
				ATAirSDK.getInstance().extCtx.call(ATAirConst.loadInterstitalAdMethod, unitId, customString);
			}
		}
		
		public static function showInterstitialAd(unitId:String):void
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call showInterstitialAd, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.showInterstitalAdMethod,unitId);
			}
		}
		
		public static function isInsterstitialAdReady(unitId:String):Boolean
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call isInsterstitialAdReady, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var isReady:Boolean = (Boolean)(ATAirSDK.getInstance().extCtx.call(ATAirConst.isInterstitialAdReadyMethod,unitId));
				return isReady;
			}
			return false;
		}
		
		public static function handleStatusEvent(event:StatusEvent):void
		{
			var callbackObject:Object = JSON.parse(event.level);
			var placementId:String = callbackObject["placement"];
			var errorMsg:String = callbackObject["error"];
			switch(event.code)
			{
				case ATAirConst.onInterstitalLoadSuccess:
					if(interstitialListener != null)
					{
						interstitialListener.onInterstitialLoaded(placementId);
					}
					break;
				case ATAirConst.onInterstitalLoadFail:
					if(interstitialListener != null)
					{
						interstitialListener.onInterstitialLoadFail(placementId, errorMsg);
					}
					break;
				case ATAirConst.onInterstitalClicked:
					if(interstitialListener != null)
					{
						interstitialListener.onInterstitialCLick(placementId);
					}
					break;
				case ATAirConst.onInterstitalShow:
					if(interstitialListener != null)
					{
						interstitialListener.onInterstitialShow(placementId);
					}
					break;
				case ATAirConst.onInterstitalClose:
					if(interstitialListener != null)
					{
						interstitialListener.onInterstitialClose(placementId);
					}
					break;
			}
		}
		
	}
}
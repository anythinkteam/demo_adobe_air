package com.anythink.sdk.nativebanner
{
import com.anythink.sdk.ATAirConst;
import com.anythink.sdk.ATAirSDK;

import flash.events.StatusEvent;
import flash.geom.Rectangle;

public class ATNativeBannerAd
	{
		private static var bannerListener:ATNativeBannerListener;
		
		public static function setNativeBannerListener(listener:ATNativeBannerListener):void
		{
			bannerListener = listener;
		}
		
		public static function loadNativeBannerAd(unitId:String, customObject:Object):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var customString:String = "";
				if(customObject != null)
				{
					customString = JSON.stringify(customObject);
				}
				
				
				ATAirSDK.getInstance().extCtx.call(ATAirConst.loadNativeBannerAdMethod,unitId, customString);
			}
		}
		
		
		public static function showNativeBannerAd(unitId:String, rect:Rectangle, adConfig:ATNativeBannerAdConfig):void
		{
			var rectObject:Object = {};
			rectObject["x"] = rect.x;
			rectObject["y"] = rect.y;
			rectObject["w"] = rect.width;
			rectObject["h"] = rect.height;
			var adConfigStr:String = "";
			if(adConfig != null)
			{
				adConfigStr = adConfig.toJsonString();
			}
			if(ATAirSDK.getInstance().extCtx != null)
			{
				if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
					trace("call showNativeBannerAd, unit:" + unitId + ", config:" + adConfigStr);
				}
				
				ATAirSDK.getInstance().extCtx.call(ATAirConst.showNativeBannerAdMethod,unitId, JSON.stringify(rectObject), adConfigStr);
			}
		}
		
		public static function removeNativeBannerAd(unitId:String):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.removeNativeBannerAdMethod,unitId);
			}
		}
		
		public static function isNativeBannerAdReady(unitId:String):Boolean
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call isNativeAdReady, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var isReady:Boolean = (Boolean)(ATAirSDK.getInstance().extCtx.call(ATAirConst.isNativeBannerAdReadyMethod,unitId));
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
				case ATAirConst.onNativeBannerLoadSuccess:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerLoadSuccess(event.code);
					}
					break;
				case ATAirConst.onNativeBannerLoadFail:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerLoadFail(placementId, errorMsg);
					}
					break;
				case ATAirConst.onNativeBannerClicked:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerClick(placementId);
					}
					break;
				case ATAirConst.onNativeBannerShow:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerShow(placementId);
					}
					break;
				case ATAirConst.onNativeBannerClose:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerClose(placementId);
					}
					break;
				case ATAirConst.onNativeBannerAutoRefresh:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerAutoRefresh(placementId);
					}
					break;
				case ATAirConst.onNativeBannerAutoRefreshFail:
					if(bannerListener != null)
					{
						bannerListener.onNativeBannerAutoRefreshFail(placementId, errorMsg);
					}
					break;
			}
		}
	}
}
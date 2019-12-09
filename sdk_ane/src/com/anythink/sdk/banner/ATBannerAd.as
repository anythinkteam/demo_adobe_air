package com.anythink.sdk.banner
{
import com.anythink.sdk.ATAirConst;
import com.anythink.sdk.ATAirSDK;

import flash.events.StatusEvent;
import flash.geom.Rectangle;

public class ATBannerAd
	{
		private static var bannerListener:ATBannerListener;
		
		public static function setBannerListener(listener:ATBannerListener):void
		{
			bannerListener = listener;
		}
		
		public static function loadBannerAd(unitId:String, customObject:Object):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var customString:String = "";
				if(customObject != null)
				{
					customString = JSON.stringify(customObject);
				}
				ATAirSDK.getInstance().extCtx.call(ATAirConst.loadBannerAdMethod,unitId, customString);
			}
		}
		
		
		public static function showBannerAd(unitId:String, rect:Rectangle):void
		{
			var rectObject:Object = {};
			rectObject["x"] = rect.x;
			rectObject["y"] = rect.y;
			rectObject["w"] = rect.width;
			rectObject["h"] = rect.height;
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.showBannerAdMethod,unitId, JSON.stringify(rectObject));
			}
		}
		
		public static function isBannerAdReady(unitId:String):Boolean
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call isBannerAdReady, unit:" + unitId);
			}
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var isReady:Boolean = (Boolean)(ATAirSDK.getInstance().extCtx.call(ATAirConst.isBannerAdReadyMethod,unitId));
				return isReady;
			}
			return false;
		}
		
		
		public static function removeBannerAd(unitId:String):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.removeBannerAdMethod,unitId);
			}
		}
		
		public static function handleStatusEvent(event:StatusEvent):void
		{
			var callbackObject:Object = JSON.parse(event.level);
			var placementId:String = callbackObject["placement"];
			var errorMsg:String = callbackObject["error"];
			switch(event.code)
			{
				case ATAirConst.onBannerLoadSuccess:
					if(bannerListener != null)
					{
						bannerListener.onBannerLoadSuccess(event.code);
					}
					break;
				case ATAirConst.onBannerLoadFail:
					if(bannerListener != null)
					{
						bannerListener.onBannerLoadFail(placementId, errorMsg);
					}
					break;
				case ATAirConst.onBannerClicked:
					if(bannerListener != null)
					{
						bannerListener.onBannerClick(placementId);
					}
					break;
				case ATAirConst.onBannerShow:
					if(bannerListener != null)
					{
						bannerListener.onBannerShow(placementId);
					}
					break;
				case ATAirConst.onBannerClose:
					if(bannerListener != null)
					{
						bannerListener.onBannerClose(placementId);
					}
					break;
				case ATAirConst.onBannerAutoRefresh:
					if(bannerListener != null)
					{
						bannerListener.onBannerAutoRefresh(placementId);
					}
					break;
				case ATAirConst.onBannerAutoRefreshFail:
					if(bannerListener != null)
					{
						bannerListener.onBannerAutoRefreshFail(placementId, errorMsg);
					}
					break;
			}
		}
	}
}
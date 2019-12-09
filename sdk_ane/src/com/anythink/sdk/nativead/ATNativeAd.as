package com.anythink.sdk.nativead
{
	import com.anythink.sdk.ATAirConst;
	import com.anythink.sdk.ATAirSDK;
	
	import flash.events.StatusEvent;

	public class ATNativeAd
	{
		private static var nativeListener:ATNativeListener;
		
		public static function setNativeListener(listener:ATNativeListener):void
		{
			nativeListener = listener;
		}
		
		public static function loadNativeAd(unitId:String, customObject:Object, extraObject:Object):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var extraString:String = "";
				if(customObject != null)
				{
					extraString = JSON.stringify(extraObject);
				}
				
				var customString:String = "";
				if(customObject != null)
				{
					customString = JSON.stringify(customObject);
				}
				ATAirSDK.getInstance().extCtx.call(ATAirConst.loadNativeAdMethod, unitId, customString, extraString);
			}
		}
		
		
		public static function showNativeAd(unitId:String, nativeAdConfig:ATNativeAdConfig):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.showNativeAdMethod,unitId, nativeAdConfig.toJsonString());
			}
		}
		
		public static function removeNativeAd(unitId:String):void
		{
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.removeNativeAdMethod,unitId);
			}
		}
		
		public static function isNativeAdReady(unitId:String):Boolean
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call isNativeAdReady, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var isReady:Boolean = (Boolean)(ATAirSDK.getInstance().extCtx.call(ATAirConst.isNativeAdReadyMethod,unitId));
				return isReady;
			}
			return false;
		}
		
		
		public static function handleStatusEvent(event:StatusEvent):void
		{	
			try{
				var callbackObject:Object = JSON.parse(event.level);
				var placementId:String = callbackObject["placement"];
				var errorMsg:String = callbackObject["error"];
				var isRewarded:Boolean = callbackObject["isRewarded"];
				
				switch(event.code)
				{
					case ATAirConst.onNativeAdLoadSuccess:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdLoadSuccess(placementId);
						}
						break;
					case ATAirConst.onNativeAdLoadFail:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdLoadFail(placementId, errorMsg);
						}
						break;
					case ATAirConst.onNativeAdClick:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdClick(placementId);
						}
						break;
					case ATAirConst.onNativeAdShow:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdShow(placementId);
						}
						break;
					case ATAirConst.onNativeAdVideoStart:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdVideoStart(placementId);
						}
						break;
					case ATAirConst.onNativeAdVideoEnd:
						if(nativeListener != null)
						{
							nativeListener.onNativeAdVideoEnd(placementId);
						}
						break;
				}
			} catch(error:Error)
			{
				trace("error:" + error.message);
			}
			
		}
		
		
		
	}
}
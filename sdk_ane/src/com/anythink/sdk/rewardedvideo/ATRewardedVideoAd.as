package com.anythink.sdk.rewardedvideo
{
import com.anythink.sdk.ATAirConst;
import com.anythink.sdk.ATAirSDK;

import flash.events.StatusEvent;

public class ATRewardedVideoAd
	{
		private static var rewardedVideoListener:ATRewardedVideoListener;
		
		
		//注册回调监听，需要验证重复调用注册回调，是否会出现重复回调
		public static function setAdListener(listener:ATRewardedVideoListener):void
		{
			rewardedVideoListener = listener;
		}
		
		public static function loadRewardedVideoAd(unitId:String, userId:String, customObject:Object):void
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call loadRewardedVideoAd, unit:" + unitId);
			}
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var customString:String = "";
				if(customObject != null)
				{
					customString = JSON.stringify(customObject);
				}
				ATAirSDK.getInstance().extCtx.call(ATAirConst.loadRewardedVideoAdMethod,unitId, userId, customString);
			}
		}
		
		public static function showRewardedVideoAd(unitId:String):void
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call showRewardedVideoAd, unit:" + unitId);
			}
			
			if(ATAirSDK.getInstance().extCtx != null)
			{
				ATAirSDK.getInstance().extCtx.call(ATAirConst.showRewardedVideoAdMethod,unitId);
			}
		}
		
		public static function isRewardedVideoReady(unitId:String):Boolean
		{
			if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
				trace("call isRewardedVideoReady, unit:" + unitId);
			}
			if(ATAirSDK.getInstance().extCtx != null)
			{
				var isReady:Boolean = (Boolean)(ATAirSDK.getInstance().extCtx.call(ATAirConst.isRewardedVideoAdReadyMethod,unitId));
				return isReady;
			}
			return false;
		}
		
		public static function handleStatusEvent(event:StatusEvent):void
		{	
			var callbackObject:Object = JSON.parse(event.level);
			var placementId:String = callbackObject["placement"];
			var errorMsg:String = callbackObject["error"];
			var isRewarded:Boolean = callbackObject["isRewarded"];
			switch(event.code)
			{
				case ATAirConst.onRewardedVideoLoadSuccess:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoLoaded(placementId);
					}
					break;
				case ATAirConst.onRewardedVideoLoadFail:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoLoadFail(placementId, errorMsg);
					}
					break;
				case ATAirConst.onRewardedVideoClicked:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoCLick(placementId);
					}
					break;
				case ATAirConst.onRewardedVideoPlayStart:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoStart(placementId);
					}
					break;
				case ATAirConst.onRewardedVideoPlayEnd:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoEnd(placementId);
					}
					break;
				case ATAirConst.onRewardedVideoShowFail:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoPlayFail(placementId, errorMsg);
					}
					break;
				case ATAirConst.onRewardedVideoClose:
					if(rewardedVideoListener != null)
					{
						rewardedVideoListener.onRewardedVideoClose(placementId, isRewarded);
					}
					break;
                case ATAirConst.onRewardedVideoRewarded:
                    if(rewardedVideoListener != null)
                    {
                        rewardedVideoListener.onRewardedVideoRewareded(placementId);
                    }
                    break;
			}
		}
	}
}
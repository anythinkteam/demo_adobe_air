package com.anythink.sdk
{
import com.anythink.sdk.banner.ATBannerAd;
import com.anythink.sdk.interstitial.ATInterstitialAd;
import com.anythink.sdk.nativead.ATNativeAd;
import com.anythink.sdk.nativebanner.ATNativeBannerAd;
import com.anythink.sdk.rewardedvideo.ATRewardedVideoAd;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class ATAirSDK extends EventDispatcher
	{
		//DEBUG配置开关
		public static const STATUS_ON:int = 1;
		public static const STATUS_OFF:int = 0;
		
		//GDPR配置
		public static const GDPR_PERSONALIZED:int = 0;
		public static const GDPR_NONPERSONALIZED:int = 1;
		public static const GDPR_UNKNOW:int = 2;
		
		public var extCtx:ExtensionContext=null; 
		private static var instance:ATAirSDK = null;
		private static var isDebug:int = STATUS_ON;
		
		public static function getInstance():ATAirSDK
		{
			if(instance == null)
			{
				instance = new ATAirSDK();
			}
			return instance;
		}
		
		public function ATAirSDK():void
		{ 
			extCtx = ExtensionContext.createExtensionContext(ATAirConst.EXTENSION_ID, "");
			extCtx.addEventListener(StatusEvent.STATUS, onStatusEventHandle);
		}
		
		
		public function setDebugLog(status:int):void
		{
			if(isDebug == STATUS_ON){
				trace("setDebugLog call!"); // 将回调信息打印
			}
			
			isDebug = status;
			if(extCtx)
			{  
				extCtx.call(ATAirConst.setDebugLogMethod, status==1?true:false);
			}
		
		}
		
		public function getDebugLog():int
		{
			return isDebug;
		}
		
		public function initSDK(appId:String, appKey:String):void
		{
			if(isDebug == STATUS_ON){
				trace("initSDK call!"); // 将回调信息打印
			}
			if(extCtx)
			{  
				extCtx.call(ATAirConst.initMethod, appId, appKey);
			}
		
		}
		
	
		public function setGDPRLevel(level:int):void
		{
			if(isDebug == STATUS_ON){
				trace("setGDPRLevel call!"); // 将回调信息打印
			}
			
			if(extCtx)
			{  
				extCtx.call(ATAirConst.setGDPRLevelMethod, level);
			}
		}

		public function getGDPRLevel():int
		{
			if(isDebug == STATUS_ON){
				trace("getGDPRLevel call!"); // 将回调信息打印
			}

			if(extCtx)
			{
				return extCtx.call(ATAirConst.getGDPRLevel) as int;
			}
		}
		
		
		public function showGdprAuth():void
		{
			if(isDebug == STATUS_ON){
				trace("showGdprAuth call!"); // 将回调信息打印
			}
			
			if(extCtx)
			{  
				extCtx.call(ATAirConst.showGdprAuthMethod);
			}
		}
		
		public function isEUTraffic():Boolean
		{
			if(isDebug == STATUS_ON){
				trace("isEUTraffic call!"); // 将回调信息打印
			}
			
			if(extCtx)
			{  
				return extCtx.call(ATAirConst.isEUTrafficMethod) as Boolean;
			}
			return false;
		}
		
		public function getScreenWidth():int
		{
			if(isDebug == STATUS_ON){
				trace("getScreenWidth call!"); // 将回调信息打印
			}
			
			if(extCtx)
			{  
				return extCtx.call(ATAirConst.getScreenWidthMethod) as int;
			}
			return -1;
		}
		
		public function getScreenHeight():int
		{
			if(isDebug == STATUS_ON){
				trace("getScreenHeight call!"); // 将回调信息打印
			}
			
			if(extCtx)
			{  
				return extCtx.call(ATAirConst.getScreenHeightMethod) as int;
			}
			return -1;
		}
		private function onStatusEventHandle(event:StatusEvent):void
		{
			try
			{
				if(ATAirSDK.getInstance().getDebugLog() == ATAirSDK.STATUS_ON){
					trace("onStatusEventHandle，code:" + event.code + " level:" + event.level);
				}
				
				ATNativeAd.handleStatusEvent(event);
				ATBannerAd.handleStatusEvent(event);
				ATInterstitialAd.handleStatusEvent(event);
				ATRewardedVideoAd.handleStatusEvent(event);
				ATNativeBannerAd.handleStatusEvent(event);
			}catch(error:Error)
			{
				trace("onStatusEventHandle error:" + error.message);
			}
		
		}
	
	}
}
package com.anythink.demo
{
	import com.anythink.sdk.interstitial.ATInterstitialListener;

	public class InterstitialListenerImpl implements ATInterstitialListener
	{
		public function InterstitialListenerImpl()
		{
			
		}
		
		
		public function onInterstitialLoaded(unitId:String):void
		{
			trace("onInterstitialLoaded:" + unitId);
		}
		public function onInterstitialLoadFail(unitId:String, errorMsg:String):void
		{
			trace("onInterstitialLoadFail:" + unitId + ";;error:" + errorMsg);
		}
		public function onInterstitialCLick(unitId:String):void
		{
			trace("onInterstitialCLick:" + unitId);
		}
		public function onInterstitialShow(unitId:String):void
		{
			trace("onInterstitialShow:" + unitId);
		}
		public function onInterstitialClose(unitId:String):void
		{
			trace("onInterstitialClose:" + unitId);
		}
		
		
	}
}
package com.uparpu.demo
{
	import com.uparpu.sdk.nativead.UpArpuNativeListener;
	
	public class NativeListenerImpl implements UpArpuNativeListener
	{
		public function NativeListenerImpl()
		{
		}
		
		
		public function onNativeAdLoadSuccess(unitId:String):void
		{
			trace("onNativeAdLoadSuccess:" + unitId);
		}
		
		public function onNativeAdLoadFail(unitId:String, errorMsg:String):void
		{
			trace("onNativeAdLoadFail:" + unitId + " errorMsg:" + errorMsg);
		}
		
		public function onNativeAdClick(unitId:String):void
		{
			trace("onNativeAdClick:" + unitId);
		}
		
		public function onNativeAdShow(unitId:String):void
		{
			trace("onNativeAdShow:" + unitId);
		}
		public function onNativeAdVideoStart(unitId:String):void
		{
			trace("onNativeAdVideoStart:" + unitId);
		}
		
		public function onNativeAdVideoEnd(unitId:String):void
		{
			trace("onNativeAdVideoEnd:" + unitId);
		}
	}
}
package com.uparpu.demo
{
	import com.uparpu.sdk.nativebanner.UpArpuNativeBannerListener;
	
	public class NativeBannerListenerImpl implements UpArpuNativeBannerListener
	{
		public function NativeBannerListenerImpl()
		{
		}
		
		public function onNativeBannerLoadSuccess(unitId:String):void
		{
			trace("onNativeBannerLoadSuccess:" + unitId);
		}
		
		public function onNativeBannerLoadFail(unitId:String, errorMsg:String):void
		{
			trace("onNativeBannerLoadFail:" + unitId + " error:" + errorMsg);
		}
		
		public function onNativeBannerClick(unitId:String):void
		{
			trace("onNativeBannerClick:" + unitId);
		}
		
		public function onNativeBannerShow(unitId:String):void
		{
			trace("onNativeBannerShow:" + unitId);
		}
		public function onNativeBannerClose(unitId:String):void
		{
			trace("onNativeBannerClose:" + unitId);
		}
		public function onNativeBannerAutoRefresh(unitId:String):void
		{
			trace("onNativeBannerAutoRefresh:" + unitId);
		}
		public function onNativeBannerAutoRefreshFail(unitId:String, errorMsg:String):void
		{
			trace("onNativeBannerAutoRefreshFail:" + unitId + " error:" + errorMsg);
		}
	}
}
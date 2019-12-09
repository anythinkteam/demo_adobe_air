package com.anythink.demo
{
	import com.anythink.sdk.banner.ATBannerListener;
	
	public class BannerListenerImpl implements ATBannerListener
	{
		public function BannerListenerImpl()
		{
		}
		
		public function onBannerLoadSuccess(unitId:String):void
		{
			trace("onBannerLoadSuccess:" + unitId);
		}
		
		public function onBannerLoadFail(unitId:String, errorMsg:String):void
		{
			trace("onBannerLoadFail:" + unitId + " error:" + errorMsg);
		}
		
		public function onBannerClick(unitId:String):void
		{
			trace("onBannerClick:" + unitId);
		}
		
		public function onBannerShow(unitId:String):void
		{
			trace("onBannerShow:" + unitId);
		}
		public function onBannerClose(unitId:String):void
		{
			trace("onBannerClose:" + unitId);
		}
		public function onBannerAutoRefresh(unitId:String):void
		{
			trace("onBannerAutoRefresh:" + unitId);
		}
		public function onBannerAutoRefreshFail(unitId:String, errorMsg:String):void
		{
			trace("onBannerAutoRefreshFail:" + unitId + " error:" + errorMsg);
		}
	}
}
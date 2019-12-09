package com.anythink.demo
{
	import com.anythink.sdk.rewardedvideo.ATRewardedVideoListener;

	public class RewardedVideoListenerImpl implements ATRewardedVideoListener
	{
		public function RewardedVideoListenerImpl()
		{
			
		}
		
		public function onRewardedVideoLoaded(unitId:String):void
		{
			trace("onRewardedVideoLoaded:" + unitId);
		}
		public function onRewardedVideoLoadFail(unitId:String, errorMsg:String):void
		{
			trace("onRewardedVideoLoadFail:" + unitId + ";;error:" + errorMsg);
		}
		public function onRewardedVideoCLick(unitId:String):void
		{
			trace("onRewardedVideoCLick:" + unitId);
		}
		public function onRewardedVideoStart(unitId:String):void
		{
			trace("onRewardedVideoStart:" + unitId);
		}
		public function onRewardedVideoEnd(unitId:String):void
		{
			trace("onRewardedVideoEnd:" + unitId);
		}
		public function onRewardedVideoPlayFail(unitId:String, errorMsg:String):void
		{
			trace("onRewardedVideoShowFail:" + unitId + ";;error:" + errorMsg);
		}
		public function onRewardedVideoClose(unitId:String, isReward:Boolean):void
		{
			trace("onRewardedVideoClose:" + unitId + ";;isReward:" + isReward);
		}

        public function onRewardedVideoRewareded(unitId:String):void {
            trace("onRewardedVideoRewareded:" + unitId);
        }
		
	}
}
package com.anythink.sdk.rewardedvideo
{
	public interface ATRewardedVideoListener
	{
		function onRewardedVideoLoaded(unitId:String):void;
		function onRewardedVideoLoadFail(unitId:String, errorMsg:String):void;
		function onRewardedVideoCLick(unitId:String):void;
		function onRewardedVideoStart(unitId:String):void;
		function onRewardedVideoEnd(unitId:String):void;
		function onRewardedVideoPlayFail(unitId:String, errorMsg:String):void;
		function onRewardedVideoClose(unitId:String, isReward:Boolean):void;
        function onRewardedVideoRewareded(unitId:String):void;
	}
}
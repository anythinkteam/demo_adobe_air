package com.anythink.demo
{
	import flash.system.Capabilities;

	public class CommonConfig
	{
		public static var platform:int = 1;//1为android，2为ios
		public static const android_appid:String = "a5aa1f9deda26d";
		public static const android_appkey:String = "4f7b9ac17decb9babec83aac078742c7";
		public static const android_rv_placement:String = "b5b449eefcab50";
		public static const android_inter_placement:String = "b5bbdc69a21187";
		public static const android_banner_placement:String = "b5bbdc51a35e29";
		public static const android_native_placement:String = "b5aa1fa4165ea3";
		public static const android_nativebanner_placement:String = "b5aa1fa4165ea3";
		
		
		public static const ios_appid:String = "a5b0e8491845b3";
		public static const ios_appkey:String = "7eae0567827cfe2b22874061763f30c9";
		public static const ios_rv_placement:String = "b5c0f7cd196a4c";
		public static const ios_inter_placement:String = "b5bacad8ea3036";
		public static const ios_banner_placement:String = "b5bacad0803fd1";//b5bacacef17717
		public static const ios_native_placement:String = "b5bacac780e03b";
		public static const ios_nativebanner_placement:String = "b5c2c6d50e7f44";
		
		public static function setPlatform():void
		{
			var nativeOperationSystem:String=flash.system.Capabilities.os;
			nativeOperationSystem=nativeOperationSystem.toUpperCase();
			if(nativeOperationSystem.indexOf("IPHONE")>=0)
			{
				platform = 2;
			} else 
			{
				platform = 1;
			}
		}
		public static function getAppId():String 
		{
			if(platform == 2)
			{
			return ios_appid;
			}else{
			return android_appid;
			}
		}
		public static function getAppKey():String 
		{
			if(platform == 2)
			{
				return ios_appkey;
			}else{
				return android_appkey;
			}
		}
		
		public static function getRewardedVideoPlacement():String
		{
			if(platform == 2)
			{
				return ios_rv_placement;
			}else{
				return android_rv_placement;
			}
		}
		
		public static function getInterstitialPlacement():String
		{
			if(platform == 2)
			{
				return ios_inter_placement;
			}else{
				return android_inter_placement;
			}
		}
		
		public static function getBannerPlacement():String
		{
			if(platform == 2)
			{
				return ios_banner_placement;
			}else
			{
				return android_banner_placement;
			}
		}
		
		public static function getNativePlacement():String
		{
			if(platform == 2)
			{
				return ios_native_placement;
			}else
			{
				return android_native_placement;
			}
		}
		
		public static function getNativeBannerPlacement():String
		{
			if(platform == 2)
			{
				return ios_nativebanner_placement;
			}else
			{
				return android_nativebanner_placement;
			}
		}
	}
	
}
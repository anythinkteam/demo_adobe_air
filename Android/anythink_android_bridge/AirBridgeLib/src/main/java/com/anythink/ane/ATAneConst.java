package com.anythink.ane;

public class ATAneConst {

    public class Method {
        public static final String initMethod = "initSDK";
        public static final String setGDPRLevelMethod = "setGDPRLevel";
        public static final String showGdprAuthMethod = "showGdprAuth";
        public static final String isEUTrafficMethod = "isEUTraffic";
        public static final String setDebugLogMethod = "setDebugLog";
        public static final String getScreenWidthMethod = "getScreenWidth";
        public static final String getScreenHeightMethod = "getScreenHeight";

        //banner方法定义
        public static final String loadBannerAdMethod = "loadBannerAd";
        public static final String showBannerAdMethod = "showBannerAd";
        public static final String removeBannerAdMethod = "removeBannerAd";
        public static final String isBannerAdReadyMethod = "isBannerAdReady";

        //native方法定义
        public static final String loadNativeAdMethod = "loadNativeAd";
        public static final String showNativeAdMethod = "showNativeAd";
        public static final String removeNativeAdMethod = "removeNativeAd";
        public static final String isNativeAdReadyMethod = "isNativeAdReady";

        //interstital方法定义
        public static final String loadInterstitalAdMethod = "loadInterstitialAd";
        public static final String showInterstitalAdMethod = "showInterstitialAd";
        public static final String isInterstitialAdReadyMethod = "isInterstitialAdReady";

        //rewardedvideo方法定义
        public static final String loadRewardedVideoAdMethod = "loadRewardedVideoAd";
        public static final String showRewardedVideoAdMethod = "showRewardedVideoAd";
        public static final String isRewardedVideoAdReadyMethod = "isRewardedVideoAdReady";

        //nativebanner方法定义
        public static final String loadNativeBannerAdMethod = "loadNativeBannerAd";
        public static final String showNativeBannerAdMethod = "showNativeBannerAd";
        public static final String removeNativeBannerAdMethod = "removeNativeBannerAd";
        public static final String isNativeBannerAdReadyMethod = "isNativeBannerAdReady";
    }

    public class Callback {
        public static final String onBannerLoadSuccess = "onBannerLoadSuccess";
        public static final String onBannerLoadFail = "onBannerLoadFail";
        public static final String onBannerClicked = "onBannerClicked";
        public static final String onBannerShow = "onBannerShow";
        public static final String onBannerClose = "onBannerClose";
        public static final String onBannerAutoRefresh = "onBannerAutoRefresh";
        public static final String onBannerAutoRefreshFail = "onBannerAutoRefreshFail";

        public static final String onNativeAdLoadSuccess = "onNativeAdLoadSuccess";
        public static final String onNativeAdLoadFail = "onNativeAdLoadFail";
        public static final String onNativeAdClick = "onNativeAdClick";
        public static final String onNativeAdShow = "onNativeAdShow";
        public static final String onNativeAdVideoStart = "onNativeAdVideoStart";
        public static final String onNativeAdVideoEnd = "onNativeAdVideoEnd";

        public static final String onInterstitalLoadSuccess = "onInterstitalLoadSuccess";
        public static final String onInterstitalLoadFail = "onInterstitalLoadFail";
        public static final String onInterstitalClicked = "onInterstitalClicked";
        public static final String onInterstitalShow = "onInterstitalShow";
        public static final String onInterstitalClose = "onInterstitalClose";


        public static final String onRewardedVideoLoadSuccess = "onRewardedVideoLoadSuccess";
        public static final String onRewardedVideoLoadFail = "onRewardedVideoLoadFail";
        public static final String onRewardedVideoClicked = "onRewardedVideoClicked";
        public static final String onRewardedVideoPlayStart = "onRewardedVideoPlayStart";
        public static final String onRewardedVideoPlayEnd = "onRewardedVideoPlayEnd";
        public static final String onRewardedVideoShowFail = "onRewardedVideoShowFail";
        public static final String onRewardedVideoClose = "onRewardedVideoClose";
        public static final String onRewardedVideoRewarded = "onRewardedVideoRewarded";

        public static final String onNativeBannerLoadSuccess = "onNativeBannerLoadSuccess";
        public static final String onNativeBannerLoadFail = "onNativeBannerLoadFail";
        public static final String onNativeBannerClicked = "onNativeBannerClicked";
        public static final String onNativeBannerShow = "onNativeBannerShow";
        public static final String onNativeBannerClose = "onNativeBannerClose";
        public static final String onNativeBannerAutoRefresh = "onNativeBannerAutoRefresh";
        public static final String onNativeBannerAutoRefreshFail = "onNativeBannerAutoRefreshFail";
    }

    public class CallbackJSONKey {
        public static final String PLACEMENT = "placement";
        public static final String ERROR = "error";
        public static final String ISREWARDED = "isRewarded";
    }
}

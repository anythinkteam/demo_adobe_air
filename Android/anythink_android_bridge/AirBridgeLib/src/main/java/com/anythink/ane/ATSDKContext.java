package com.anythink.ane;

import android.graphics.Rect;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.anythink.ane.interstitial.ATInterstitialManager;
import com.anythink.ane.nativebanner.ATNativeBannerManager;
import com.anythink.ane.rewardedvideo.ATRewardedVideoManager;
import com.anythink.ane.banner.ATBannerManager;
import com.anythink.ane.nativead.ATNativeAdManager;
import com.anythink.ane.utils.Logger;
import com.anythink.core.api.ATSDK;

import java.util.HashMap;
import java.util.Map;

public class ATSDKContext extends FREContext {

    public static boolean isDebug = false;
    public static String TAG = "ATANELog";

    public ATSDKContext() {
        super();
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        HashMap<String, FREFunction> functionMap = new HashMap<>();
/** -------------------------------------------------------- sdk初始化 ------------------------------------------------------------**/
        //SDK初始化
        functionMap.put(ATAneConst.Method.initMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    String appid = freObjects[0].getAsString();
                    String appKey = freObjects[1].getAsString();
                    ATSDK.init(getActivity().getApplicationContext(), appid, appKey);
                    Logger.log("Anythink SDK init.......");
                } catch (Exception e) {
                    e.printStackTrace();
                }

                return null;
            }
        });

        functionMap.put(ATAneConst.Method.setDebugLogMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    isDebug = freObjects[0].getAsBool();
                    ATSDK.setNetworkLogDebug(isDebug);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //SDK设置GDPR
        functionMap.put(ATAneConst.Method.setGDPRLevelMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    int level = freObjects[0].getAsInt();
                    ATSDK.setGDPRUploadDataLevel(getActivity().getApplicationContext(), level);
                    Logger.log("Anythink SDK setGDPR:" + level);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //SDK展示GDPR授权页
        functionMap.put(ATAneConst.Method.showGdprAuthMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                ATSDK.showGdprAuth(getActivity());
                Logger.log("Anythink SDK show GDPR.......");
                return null;
            }
        });

        //是否欧盟国家
        functionMap.put(ATAneConst.Method.isEUTrafficMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject returnValue = null;

                try {
                    boolean isStatus = ATSDK.isEUTraffic(getActivity());
                    returnValue = FREObject.newObject(isStatus);
                    Logger.log("Anythink SDK check isEuTraffic:" + returnValue);
                } catch (Exception var5) {
                    var5.printStackTrace();
                }


                return returnValue;
            }
        });

        //获取屏幕宽度
        functionMap.put(ATAneConst.Method.getScreenWidthMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject returnValue = null;

                try {
                    Rect rectangle= new Rect();
                    getActivity().getWindow().getDecorView().getWindowVisibleDisplayFrame(rectangle);
                    int width = rectangle.width();
//                    int width = getActivity().getResources().getDisplayMetrics().widthPixels;
                    returnValue = FREObject.newObject(width);
                    Logger.log("Anythink SDK getScreenWidth:" + returnValue);
                } catch (Exception var5) {
                    var5.printStackTrace();
                }

                return returnValue;
            }
        });

        //获取屏幕高度
        functionMap.put(ATAneConst.Method.getScreenHeightMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject returnValue = null;

                try {
                    Rect rectangle= new Rect();
                    getActivity().getWindow().getDecorView().getWindowVisibleDisplayFrame(rectangle);
//                    ViewGroup root = (ViewGroup) getActivity().getWindow().getDecorView(); // DecorView
//                    ViewGroup group = (ViewGroup) root.getChildAt(0);// FrameLayout
                    int height = rectangle.height();
                    returnValue = FREObject.newObject(height);
                    Logger.log("Anythink SDK getScreenHeight:" + returnValue);
                } catch (Exception var5) {
                    var5.printStackTrace();
                }

                return returnValue;
            }
        });
/** -------------------------------------------------------- native ------------------------------------------------------------**/

        //native广告加载
        functionMap.put(ATAneConst.Method.loadNativeAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATNativeAdManager.getInstance().loadAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString(), freObjects[1].getAsString());

                    Logger.log("Anythink SDK load NativeAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }

                return null;
            }
        });

        //native广告展示
        functionMap.put(ATAneConst.Method.showNativeAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATNativeAdManager.getInstance().showAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK show NativeAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //native广告是否ready
        functionMap.put(ATAneConst.Method.isNativeAdReadyMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    boolean isAdReady = ATNativeAdManager.getInstance().isAdReady(freObjects[0].getAsString());
                    Logger.log("Anythink SDK is NativeAdReady:" + freObjects[0].getAsString() + "---:" + isAdReady);
                    freObject = FREObject.newObject(isAdReady);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });

        //native广告移除
        functionMap.put(ATAneConst.Method.removeNativeAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATNativeAdManager.getInstance().removeAd(ATSDKContext.this, freObjects[0].getAsString());
                    Logger.log("Anythink SDK remove NativeAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });


/** -------------------------------------------------------- banner ------------------------------------------------------------**/

        //banner广告加载
        functionMap.put(ATAneConst.Method.loadBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATBannerManager.getInstance().loadAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK load BannerAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //banner广告展示
        functionMap.put(ATAneConst.Method.showBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATBannerManager.getInstance().showAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK show BannerAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //banner广告移除
        functionMap.put(ATAneConst.Method.removeBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATBannerManager.getInstance().removeAd(ATSDKContext.this, freObjects[0].getAsString());
                    Logger.log("Anythink SDK remove BannerAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //banner的isAdReady
        functionMap.put(ATAneConst.Method.isBannerAdReadyMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    boolean isAdReady = ATBannerManager.getInstance().isAdReady(freObjects[0].getAsString());
                    Logger.log("Anythink SDK is bannerAdReady:" + freObjects[0].getAsString() + "---:" + isAdReady);
                    freObject = FREObject.newObject(isAdReady);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });


/** -------------------------------------------------------- interstitial ------------------------------------------------------------**/
        //interstitial广告加载
        functionMap.put(ATAneConst.Method.loadInterstitalAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATInterstitialManager.getInstance().loadAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK load InterstitialAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //interstitial广告isReady
        functionMap.put(ATAneConst.Method.isInterstitialAdReadyMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    boolean isAdReady = ATInterstitialManager.getInstance().isAdReady(freObjects[0].getAsString());
                    Logger.log("Anythink SDK is InterstitalAdReady:" + freObjects[0].getAsString() + "---:" + isAdReady);
                    freObject = FREObject.newObject(isAdReady);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });

        //interstitial广告展示
        functionMap.put(ATAneConst.Method.showInterstitalAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATInterstitialManager.getInstance().showAd(freObjects[0].getAsString());
                    Logger.log("Anythink SDK show InterstitalAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

/** -------------------------------------------------------- rewardVideo ------------------------------------------------------------**/
        //rewardedvideo广告加载
        functionMap.put(ATAneConst.Method.loadRewardedVideoAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATRewardedVideoManager.getInstance().loadAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK load RewardedVideo:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //rewardedvideo广告isReady
        functionMap.put(ATAneConst.Method.isRewardedVideoAdReadyMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    boolean isAdReady = ATRewardedVideoManager.getInstance().isAdReady(freObjects[0].getAsString());
                    Logger.log("Anythink SDK is RewardedVideo Ready:" + freObjects[0].getAsString() + "---:" + isAdReady);
                    freObject = FREObject.newObject(isAdReady);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });

        //rewardedvideo广告展示
        functionMap.put(ATAneConst.Method.showRewardedVideoAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATRewardedVideoManager.getInstance().showAd(freObjects[0].getAsString());
                    Logger.log("Anythink SDK show RewardedVideo:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

/** -------------------------------------------------------- nativeBanner ------------------------------------------------------------**/
        //inativeBanner广告加载
        functionMap.put(ATAneConst.Method.loadNativeBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATNativeBannerManager.getInstance().loadAd(ATSDKContext.this, freObjects[0].getAsString(), freObjects[1].getAsString());
                    Logger.log("Anythink SDK load nativeBannerAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //nativeBanner广告isReady
        functionMap.put(ATAneConst.Method.isNativeBannerAdReadyMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    boolean isAdReady = ATNativeBannerManager.getInstance().isAdReady(freObjects[0].getAsString());
                    Logger.log("Anythink SDK is nativeBannerAdReady:" + freObjects[0].getAsString() + "---:" + isAdReady);
                    freObject = FREObject.newObject(isAdReady);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });

        //nativeBanner广告展示
        functionMap.put(ATAneConst.Method.showNativeBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                try {
                    ATNativeBannerManager.getInstance().showAd(ATSDKContext.this, freObjects[0].getAsString()
                            , freObjects[1].getAsString()
                            , freObjects[2] != null ? freObjects[2].getAsString() : "");
                    Logger.log("Anythink SDK show nativeBannerAd:" + freObjects[0].getAsString() + "\n" + "rect:" + freObjects[1].getAsString() + "\n showConfig:" + (freObjects[2] != null ? freObjects[2].getAsString() : ""));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return null;
            }
        });

        //nativeBanner广告remove
        functionMap.put(ATAneConst.Method.removeNativeBannerAdMethod, new FREFunction() {
            @Override
            public FREObject call(FREContext freContext, FREObject[] freObjects) {
                FREObject freObject = null;
                try {
                    ATNativeBannerManager.getInstance().removeAd(ATSDKContext.this, freObjects[0].getAsString());
                    Logger.log("Anythink SDK remove nativeBannerAd:" + freObjects[0].getAsString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return freObject;
            }
        });

        return functionMap;
    }

    @Override
    public void dispose() {

    }
}

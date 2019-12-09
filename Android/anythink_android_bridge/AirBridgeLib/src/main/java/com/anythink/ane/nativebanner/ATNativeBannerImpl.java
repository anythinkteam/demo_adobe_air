package com.anythink.ane.nativebanner;

import android.app.Activity;
import android.graphics.Color;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.FrameLayout;

import com.adobe.fre.FREContext;
import com.anythink.ane.ATAneConst;
import com.anythink.ane.utils.Logger;
import com.anythink.core.api.ATAdInfo;
import com.anythink.nativead.banner.api.ATNaitveBannerListener;
import com.anythink.nativead.banner.api.ATNaitveBannerSize;
import com.anythink.nativead.banner.api.ATNativeBannerConfig;
import com.anythink.nativead.banner.api.ATNativeBannerView;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

public class ATNativeBannerImpl {
    ATNativeBannerView mNativeBannerView;
    String mUnitId;

    boolean mIsAdReady;

    public ATNativeBannerImpl(String unitId) {
        mUnitId = unitId;
    }

    public void loadAd(final FREContext context, final String customJson) {
        if (context.getActivity() == null) {
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, "Activity has been null.");
            } catch (Exception e) {
                e.printStackTrace();
            }
            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerLoadFail, jsonObject.toString());
            return;
        }

        final Activity activity = context.getActivity();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                synchronized (ATNativeBannerImpl.this) {
                    HashMap<String, String> customMap = new HashMap<>();
                    try {
                        JSONObject customJSON = new JSONObject(customJson);
                        Iterator<String> stringIterator = customJSON.keys();
                        while (stringIterator.hasNext()) {
                            String key = stringIterator.next();
                            customMap.put(key, customJSON.optString(key));
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                    if (mNativeBannerView == null) {
                        mNativeBannerView = new ATNativeBannerView(activity);
                    }
                    mNativeBannerView.setUnitId(mUnitId);
                    mNativeBannerView.setAdListener(new ATNaitveBannerListener() {
                        @Override
                        public void onAdLoaded() {
                            mIsAdReady = true;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerLoadSuccess, jsonObject.toString());
                        }

                        @Override
                        public void onAdError(String adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerLoadFail, jsonObject.toString());
                        }

                        @Override
                        public void onAdClick(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerClicked, jsonObject.toString());
                        }

                        @Override
                        public void onAdClose() {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerClose, jsonObject.toString());
                        }

                        @Override
                        public void onAdShow(ATAdInfo atAdInfo) {
                            mIsAdReady = false;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerShow, jsonObject.toString());
                        }

                        @Override
                        public void onAutoRefresh(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerAutoRefresh, jsonObject.toString());
                        }

                        @Override
                        public void onAutoRefreshFail(String s) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, s);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeBannerAutoRefreshFail, jsonObject.toString());

                        }

//                        @Override
//                        public void onBannerAutoRefreshFail(AdError adError) {
//                            JSONObject jsonObject = new JSONObject();
//                            try {
//                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
//                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
//                            } catch (Exception e) {
//                                e.printStackTrace();
//                            }
//                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerAutoRefreshFail, jsonObject.toString());
//                        }
                    });
                    mNativeBannerView.loadAd(customMap);
                }
            }
        });
    }

    public boolean isAdReady() {
        return mIsAdReady;
    }


    public void showAd(FREContext context, final String configMap, final String bannerAdConfig) {
        final Activity activity = context.getActivity();
        Logger.log("Banner config:" + configMap);
        Logger.log("Banner extra config:" + bannerAdConfig);
        if (activity != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    synchronized (ATNativeBannerImpl.this) {
                        JSONObject jsonConfig = null;
                        int backgroundColor = -1;
                        int titleColor = -1;
                        int descColor = -1;
                        int ctaBgColor = -1;
                        int ctaTitleColor = -1;
                        long autoRefreshTime = 0;
                        int bannerSize = 0;
                        boolean isShowCloseBtn = false;
                        boolean isShowCtaBtn = true;

                        try {
                            jsonConfig = new JSONObject(bannerAdConfig);
                            String bgColor = jsonConfig.optString("bgColor");
                            isShowCloseBtn = jsonConfig.optBoolean("showCloseButton");
                            String ctaBgColorStr = jsonConfig.optString("ctaBgColor");
//                            int ctaTitleSize = jsonConfig.optInt("ctaTitleSize");
                            String ctaTitleColorStr = jsonConfig.optString("ctaTitleColor");
//                            int adTitleSize = jsonConfig.optInt("adTitleSize");
                            String adTitleColor = jsonConfig.optString("adTitleColor");
//                            int adDescSize = jsonConfig.optInt("adDescSize");
                            String adDescColor = jsonConfig.optString("adDescColor");
//                            int advertiserTextSize = jsonConfig.optInt("advertiserTextSize");
//                            String advertiserTextColor = jsonConfig.optString("advertiserTextColor");
                            autoRefreshTime = jsonConfig.optLong("autoRefreshTime");
                            bannerSize = jsonConfig.optInt("adBannerSize");
                            isShowCtaBtn = jsonConfig.optBoolean("showCtaButton");

                            backgroundColor = Color.parseColor(bgColor);
                            titleColor = Color.parseColor(adTitleColor);
                            descColor = Color.parseColor(adDescColor);
                            ctaBgColor = Color.parseColor(ctaBgColorStr);
                            ctaTitleColor = Color.parseColor(ctaTitleColorStr);

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        try {
                            JSONObject jsonObject = new JSONObject(configMap);
                            int x = jsonObject.optInt("x");
                            int y = jsonObject.optInt("y");
                            int w = jsonObject.optInt("w");
                            int h = jsonObject.optInt("h");


                            if (mNativeBannerView != null) {
                                FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(w, h);
                                layoutParams.leftMargin = x;
                                layoutParams.topMargin = y;

                                if (jsonConfig.has("bgColor")) {
                                    Logger.log("set Native banner bg color:" + backgroundColor);
                                    mNativeBannerView.setBackgroundColor(backgroundColor);
                                }
                                ATNativeBannerConfig config = new ATNativeBannerConfig();
                                if (jsonConfig.has("adTitleColor")) {
                                    Logger.log("set Native banner titleColor : " + titleColor);
                                    config.titleColor = titleColor;
                                }

                                if (jsonConfig.has("adDescColor")) {
                                    Logger.log("set Native banner descColor:" + descColor);
                                    config.descColor = descColor;
                                }

                                if (jsonConfig.has("ctaBgColor")) {
                                    Logger.log("set Native banner ctaBgColor:" + ctaBgColor);
                                    config.ctaBgColor = ctaBgColor;
                                }

                                if (jsonConfig.has("ctaTitleColor")) {
                                    Logger.log("set Native banner ctaTitleColor:" + ctaTitleColor);
                                    config.ctaColor = ctaTitleColor;
                                }

                                if (autoRefreshTime > 0) {
                                    Logger.log("set Native banner autoRefreshTime:" + autoRefreshTime);
                                    config.refreshTime = autoRefreshTime;
                                }

                                Logger.log("set Native banner isCloseBtnShow:" + isShowCloseBtn);
                                config.isCloseBtnShow = isShowCloseBtn;

                                if (bannerSize == 1) {
                                    config.bannerSize = ATNaitveBannerSize.BANNER_SIZE_320x50;
                                } else if (bannerSize == 2) {
                                    config.bannerSize = ATNaitveBannerSize.BANNER_SIZE_640x150;
                                } else {
                                    config.bannerSize = ATNaitveBannerSize.BANNER_SIZE_AUTO;
                                }

                                Logger.log("set Native banner isCtaBtnShow:" + isShowCtaBtn);
                                config.isCtaBtnShow = isShowCtaBtn;


                                mNativeBannerView.setBannerConfig(config);
                                if (mNativeBannerView.getParent() != null) {
                                    ((ViewGroup) mNativeBannerView.getParent()).removeView(mNativeBannerView);
                                }
                                activity.addContentView(mNativeBannerView, layoutParams);
                            } else {
                                Logger.log("show error  ..you must call initBanner first " + this);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                }
            });
        }

    }

    public void removeAd(FREContext context) {
        final Activity activity = context.getActivity();
        if (activity != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    synchronized (ATNativeBannerImpl.this) {
                        if (mNativeBannerView != null && mNativeBannerView.getParent() != null) {
                            ViewParent viewParent = mNativeBannerView.getParent();
                            ((ViewGroup) viewParent).removeView(mNativeBannerView);
                            mNativeBannerView = null;
                        }
                    }
                }
            });
        }
    }
}

package com.anythink.ane.nativead;

import android.app.Activity;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.FrameLayout;

import com.adobe.fre.FREContext;
import com.anythink.ane.ATAneConst;
import com.anythink.ane.utils.Logger;
import com.anythink.core.api.ATAdInfo;
import com.anythink.core.api.AdError;
import com.anythink.nativead.api.NativeAd;
import com.anythink.nativead.api.ATNative;
import com.anythink.nativead.api.ATNativeAdView;
import com.anythink.nativead.api.ATNativeEventListener;
import com.anythink.nativead.api.ATNativeNetworkListener;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;


public class ATNativeAdImpl {
    ATNative mATNative;
    String mUnitId;

    ATNativeAdView mATNativeView;

    public ATNativeAdImpl(String unitId) {
        mUnitId = unitId;
    }

    public void loadAd(final FREContext context, final String customJSONMap, final String configJSONMap) {
        if (context.getActivity() == null) {
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, "Activity has been null.");
            } catch (Exception e) {
                e.printStackTrace();
            }
            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdLoadFail, jsonObject.toString());
            return;
        }

        context.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mATNative == null) {
                    mATNative = new ATNative(context.getActivity().getApplicationContext(), mUnitId, new ATNativeNetworkListener() {
                        @Override
                        public void onNativeAdLoaded() {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdLoadSuccess, jsonObject.toString());
                        }

                        @Override
                        public void onNativeAdLoadFail(AdError adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdLoadFail, jsonObject.toString());
                        }
                    });
                }


                HashMap<String, Object> configMap = new HashMap<>();
                try {
                    JSONObject configJSON = new JSONObject(configJSONMap);
                    Iterator<String> stringIterator = configJSON.keys();
                    while (stringIterator.hasNext()) {
                        String key = stringIterator.next();
                        configMap.put(key, configJSON.optString(key));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                HashMap<String, String> customMap = new HashMap<>();
                try {
                    JSONObject customJSON = new JSONObject(customJSONMap);
                    Iterator<String> stringIterator = customJSON.keys();
                    while (stringIterator.hasNext()) {
                        String key = stringIterator.next();
                        customMap.put(key, customJSON.optString(key));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                mATNative.setLocalExtra(configMap);

                mATNative.makeAdRequest(customMap);
            }
        });
    }


    public boolean isAdReady() {
        if (mATNative != null) {
            return mATNative.getNativeAd() != null;
        }
        return false;
    }

    public void showAd(final FREContext context, final String jsonConfig) {
        final Activity activity = context.getActivity();
        if (activity == null) {
            return;
        }

        Logger.log("NativeAdConfig:" + jsonConfig);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mATNative != null) {
                    NativeAd nativeAd = mATNative.getNativeAd();
                    if (nativeAd != null) {
                        if (mATNativeView != null && mATNativeView.getParent() != null) {
                            ((ViewGroup) mATNativeView.getParent()).removeView(mATNativeView);
                            mATNativeView = null;
                        }
                        mATNativeView = new ATNativeAdView(activity);
                        nativeAd.setNativeEventListener(new ATNativeEventListener() {

                            @Override
                            public void onAdImpressed(ATNativeAdView atNativeAdView, ATAdInfo atAdInfo) {
                                JSONObject jsonObject = new JSONObject();
                                try {
                                    jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdShow, jsonObject.toString());
                            }

                            @Override
                            public void onAdClicked(ATNativeAdView atNativeAdView, ATAdInfo atAdInfo) {
                                JSONObject jsonObject = new JSONObject();
                                try {
                                    jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdClick, jsonObject.toString());
                            }

                            @Override
                            public void onAdVideoStart(ATNativeAdView upArpuNativeAdView) {
                                JSONObject jsonObject = new JSONObject();
                                try {
                                    jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdVideoStart, jsonObject.toString());
                            }

                            @Override
                            public void onAdVideoEnd(ATNativeAdView upArpuNativeAdView) {
                                JSONObject jsonObject = new JSONObject();
                                try {
                                    jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                context.dispatchStatusEventAsync(ATAneConst.Callback.onNativeAdVideoEnd, jsonObject.toString());
                            }

                            @Override
                            public void onAdVideoProgress(ATNativeAdView upArpuNativeAdView, int i) {
                            }
                        });
                    }


                    try {
                        JSONObject configJson = new JSONObject(jsonConfig);

                        JSONObject parentObject = configJson.optJSONObject("parent");
                        JSONObject iconObject = configJson.optJSONObject("icon");
                        JSONObject mainImageObject = configJson.optJSONObject("mainImage");
                        JSONObject titleObject = configJson.optJSONObject("title");
                        JSONObject descObject = configJson.optJSONObject("desc");
                        JSONObject adlogoObject = configJson.optJSONObject("adlogo");
                        JSONObject ctaObject = configJson.optJSONObject("cta");

                        ATNativeItem parentItem = ATNativeItem.parseConfig(parentObject);
                        ATNativeItem iconItem = ATNativeItem.parseConfig(iconObject);
                        ATNativeItem mainImageItem = ATNativeItem.parseConfig(mainImageObject);
                        ATNativeItem titleItem = ATNativeItem.parseConfig(titleObject);
                        ATNativeItem descItem = ATNativeItem.parseConfig(descObject);
                        ATNativeItem adlogoItem = ATNativeItem.parseConfig(adlogoObject);
                        ATNativeItem ctaItem = ATNativeItem.parseConfig(ctaObject);


                        ATNativeRender render = new ATNativeRender(activity);
                        render.setItemProperty(iconItem, mainImageItem, titleItem, descItem, adlogoItem, ctaItem);

                        nativeAd.renderAdView(mATNativeView, render);
                        nativeAd.prepare(mATNativeView);

                        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(parentItem.width, parentItem.height);
                        layoutParams.leftMargin = parentItem.x;
                        layoutParams.topMargin = parentItem.y;
                        mATNativeView.setBackgroundColor(parentItem.backgroupColor);

                        activity.addContentView(mATNativeView, layoutParams);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
            }
        });
    }

    public void removeAd(FREContext context) {
        final Activity activity = context.getActivity();
        if (activity != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if (mATNativeView != null && mATNativeView.getParent() != null) {
                        ViewParent viewParent = mATNativeView.getParent();
                        ((ViewGroup) viewParent).removeView(mATNativeView);
                    }

                }
            });
        }
    }


}

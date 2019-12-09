package com.anythink.ane.nativead;

import com.adobe.fre.FREContext;

import java.util.concurrent.ConcurrentHashMap;

public class ATNativeAdManager {

    private static ATNativeAdManager sInstance;

    ConcurrentHashMap<String, ATNativeAdImpl> mNativeAdManager;

    private ATNativeAdManager() {
        mNativeAdManager = new ConcurrentHashMap<String, ATNativeAdImpl>();
    }

    public static ATNativeAdManager getInstance() {
        if (sInstance == null) {
            sInstance = new ATNativeAdManager();
        }
        return sInstance;
    }

    public void loadAd(FREContext context, String unitId, String customJSONMap, String configJSONMap) {
        ATNativeAdImpl uparpuNativeAdImpl = mNativeAdManager.get(unitId);
        if (uparpuNativeAdImpl == null) {
            uparpuNativeAdImpl = new ATNativeAdImpl(unitId);
            mNativeAdManager.put(unitId, uparpuNativeAdImpl);
        }

        uparpuNativeAdImpl.loadAd(context, customJSONMap, configJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATNativeAdImpl uparpuNativeAdImpl = mNativeAdManager.get(unitId);
        if (uparpuNativeAdImpl != null) {
            return uparpuNativeAdImpl.isAdReady();
        }
        return false;
    }

    public void showAd(FREContext freContext, String unitId, String jsonConfig) {
        ATNativeAdImpl uparpuNativeAdImpl = mNativeAdManager.get(unitId);
        if (uparpuNativeAdImpl != null) {
            uparpuNativeAdImpl.showAd(freContext, jsonConfig);
        }
    }

    public void removeAd(FREContext context, String unitId) {
        ATNativeAdImpl uparpuNativeAdImpl = mNativeAdManager.get(unitId);
        if (uparpuNativeAdImpl != null) {
            uparpuNativeAdImpl.removeAd(context);
        }
    }
}

package com.anythink.ane.interstitial;

import com.adobe.fre.FREContext;

import java.util.concurrent.ConcurrentHashMap;

public class ATInterstitialManager {
    private static ATInterstitialManager sInstance;

    ConcurrentHashMap<String, ATInterstitialImpl> mInterstitialManager;

    private ATInterstitialManager() {
        mInterstitialManager = new ConcurrentHashMap<String, ATInterstitialImpl>();
    }

    public static ATInterstitialManager getInstance() {
        if (sInstance == null) {
            sInstance = new ATInterstitialManager();
        }
        return sInstance;
    }

    public void loadAd(FREContext context, String unitId, String customJSONMap) {
        ATInterstitialImpl uparpuInterstitialImpl = mInterstitialManager.get(unitId);
        if (uparpuInterstitialImpl == null) {
            uparpuInterstitialImpl = new ATInterstitialImpl(unitId);
            mInterstitialManager.put(unitId, uparpuInterstitialImpl);
        }

        uparpuInterstitialImpl.loadAd(context, customJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATInterstitialImpl uparpuInterstitialImpl = mInterstitialManager.get(unitId);
        if (uparpuInterstitialImpl != null) {
            return uparpuInterstitialImpl.isAdReady();
        }
        return false;
    }

    public void showAd(String unitId) {
        ATInterstitialImpl uparpuInterstitialImpl = mInterstitialManager.get(unitId);
        if (uparpuInterstitialImpl != null) {
            uparpuInterstitialImpl.showAd();
        }

    }
}

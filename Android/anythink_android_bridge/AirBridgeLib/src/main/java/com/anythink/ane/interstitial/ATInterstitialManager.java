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
        ATInterstitialImpl anythinkInterstitialImpl = mInterstitialManager.get(unitId);
        if (anythinkInterstitialImpl == null) {
            anythinkInterstitialImpl = new ATInterstitialImpl(unitId);
            mInterstitialManager.put(unitId, anythinkInterstitialImpl);
        }

        anythinkInterstitialImpl.loadAd(context, customJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATInterstitialImpl anythinkInterstitialImpl = mInterstitialManager.get(unitId);
        if (anythinkInterstitialImpl != null) {
            return anythinkInterstitialImpl.isAdReady();
        }
        return false;
    }

    public void showAd(String unitId) {
        ATInterstitialImpl anythinkInterstitialImpl = mInterstitialManager.get(unitId);
        if (anythinkInterstitialImpl != null) {
            anythinkInterstitialImpl.showAd();
        }

    }
}

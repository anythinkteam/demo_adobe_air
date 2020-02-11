package com.anythink.ane.nativebanner;

import com.adobe.fre.FREContext;

import java.util.concurrent.ConcurrentHashMap;

public class ATNativeBannerManager {
    private static ATNativeBannerManager sInstance;

    ConcurrentHashMap<String, ATNativeBannerImpl> mBannerManager;

    private ATNativeBannerManager() {
        mBannerManager = new ConcurrentHashMap<String, ATNativeBannerImpl>();
    }

    public static ATNativeBannerManager getInstance() {
        if (sInstance == null) {
            sInstance = new ATNativeBannerManager();
        }
        return sInstance;
    }

    public void loadAd(FREContext context, String unitId, String customJSONMap) {
        ATNativeBannerImpl anythinkNativeBannerImpl = mBannerManager.get(unitId);
        if (anythinkNativeBannerImpl == null) {
            anythinkNativeBannerImpl = new ATNativeBannerImpl(unitId);
            mBannerManager.put(unitId, anythinkNativeBannerImpl);
        }

        anythinkNativeBannerImpl.loadAd(context, customJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATNativeBannerImpl anythinkNativeBannerImpl = mBannerManager.get(unitId);
        if (anythinkNativeBannerImpl != null) {
            return anythinkNativeBannerImpl.isAdReady();
        }
        return false;
    }


    public void showAd(FREContext context, String unitId, String configJson, String bannerAdConfig) {
        ATNativeBannerImpl anythinkNativeBannerImpl = mBannerManager.get(unitId);
        if (anythinkNativeBannerImpl != null) {
            anythinkNativeBannerImpl.showAd(context, configJson, bannerAdConfig);
        }
    }

    public void removeAd(FREContext context, String unitId) {
        ATNativeBannerImpl anythinkNativeBannerImpl = mBannerManager.get(unitId);
        if (anythinkNativeBannerImpl != null) {
            anythinkNativeBannerImpl.removeAd(context);
        }
    }
}

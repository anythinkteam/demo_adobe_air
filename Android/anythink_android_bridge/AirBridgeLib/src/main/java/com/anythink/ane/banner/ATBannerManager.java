package com.anythink.ane.banner;

import com.adobe.fre.FREContext;

import java.util.concurrent.ConcurrentHashMap;

public class ATBannerManager {
    private static ATBannerManager sInstance;

    ConcurrentHashMap<String, ATBannerImpl> mBannerManager;

    private ATBannerManager() {
        mBannerManager = new ConcurrentHashMap<String, ATBannerImpl>();
    }

    public static ATBannerManager getInstance() {
        if (sInstance == null) {
            sInstance = new ATBannerManager();
        }
        return sInstance;
    }

    public void loadAd(FREContext context, String unitId, String customJSONMap) {
        ATBannerImpl anythinkBannerImpl = mBannerManager.get(unitId);
        if (anythinkBannerImpl == null) {
            anythinkBannerImpl = new ATBannerImpl(unitId);
            mBannerManager.put(unitId, anythinkBannerImpl);
        }

        anythinkBannerImpl.loadAd(context, customJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATBannerImpl anythinkBannerImpl = mBannerManager.get(unitId);
        if (anythinkBannerImpl == null) {
            anythinkBannerImpl = new ATBannerImpl(unitId);
            mBannerManager.put(unitId, anythinkBannerImpl);
        }

        return anythinkBannerImpl.isAdReady();
    }


    public void showAd(FREContext context, String unitId, String configJson) {
        ATBannerImpl anythinkBannerImpl = mBannerManager.get(unitId);
        if (anythinkBannerImpl != null) {
            anythinkBannerImpl.showAd(context, configJson);
        }
    }

    public void removeAd(FREContext context, String unitId) {
        ATBannerImpl anythinkBannerImpl = mBannerManager.get(unitId);
        if (anythinkBannerImpl != null) {
            anythinkBannerImpl.removeAd(context);
        }
    }
}

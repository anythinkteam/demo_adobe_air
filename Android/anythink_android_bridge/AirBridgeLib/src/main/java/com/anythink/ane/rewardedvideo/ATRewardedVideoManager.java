package com.anythink.ane.rewardedvideo;

import com.adobe.fre.FREContext;

import java.util.concurrent.ConcurrentHashMap;

public class ATRewardedVideoManager {
    private static ATRewardedVideoManager sInstance;

    ConcurrentHashMap<String, ATRewardedVideoImpl> mRewardedVideoMap;

    private ATRewardedVideoManager() {
        mRewardedVideoMap = new ConcurrentHashMap<String, ATRewardedVideoImpl>();
    }

    public static ATRewardedVideoManager getInstance() {
        if (sInstance == null) {
            sInstance = new ATRewardedVideoManager();
        }
        return sInstance;
    }

    public void loadAd(FREContext context, String unitId, String customJSONMap) {
        ATRewardedVideoImpl anythinkRewardedVideoImpl = mRewardedVideoMap.get(unitId);
        if (anythinkRewardedVideoImpl == null) {
            anythinkRewardedVideoImpl = new ATRewardedVideoImpl(unitId);
            mRewardedVideoMap.put(unitId, anythinkRewardedVideoImpl);
        }

        anythinkRewardedVideoImpl.loadAd(context, customJSONMap);
    }

    public boolean isAdReady(String unitId) {
        ATRewardedVideoImpl anythinkRewardedVideoImpl = mRewardedVideoMap.get(unitId);
        if (anythinkRewardedVideoImpl != null) {
            return anythinkRewardedVideoImpl.isAdReady();
        }
        return false;
    }

    public void showAd(String unitId) {
        ATRewardedVideoImpl anythinkRewardedVideoImpl = mRewardedVideoMap.get(unitId);
        if (anythinkRewardedVideoImpl != null) {
            anythinkRewardedVideoImpl.showAd();
        }

    }
}

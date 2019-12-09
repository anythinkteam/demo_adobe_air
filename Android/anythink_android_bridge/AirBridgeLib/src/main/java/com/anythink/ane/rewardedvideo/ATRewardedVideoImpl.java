package com.anythink.ane.rewardedvideo;

import com.adobe.fre.FREContext;
import com.anythink.ane.ATAneConst;
import com.anythink.ane.utils.Logger;
import com.anythink.core.api.ATAdInfo;
import com.anythink.core.api.AdError;
import com.anythink.rewardvideo.api.ATRewardVideoAd;
import com.anythink.rewardvideo.api.ATRewardVideoListener;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

public class ATRewardedVideoImpl {
    String mUnitId;
    ATRewardVideoAd mRewardedAd;
    boolean isRewarded;

    public ATRewardedVideoImpl(String unitId) {
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
            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoLoadFail, jsonObject.toString());
            return;
        }

        context.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
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

                if (mRewardedAd == null) {
                    mRewardedAd = new ATRewardVideoAd(context.getActivity(), mUnitId);
                    mRewardedAd.setAdListener(new ATRewardVideoListener() {
                        @Override
                        public void onRewardedVideoAdLoaded() {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdLoaded");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoLoadSuccess, jsonObject.toString());
                        }

                        @Override
                        public void onRewardedVideoAdFailed(AdError adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdFailed");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoLoadFail, jsonObject.toString());
                        }

                        @Override
                        public void onRewardedVideoAdPlayStart(ATAdInfo atAdInfo) {
                            isRewarded = false;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdPlayStart");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoPlayStart, jsonObject.toString());
                        }

                        @Override
                        public void onRewardedVideoAdPlayEnd(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdPlayEnd");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoPlayEnd, jsonObject.toString());
                        }

                        @Override
                        public void onRewardedVideoAdPlayFailed(AdError adError, ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdPlayFailed");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoShowFail, jsonObject.toString());
                        }

                        @Override
                        public void onRewardedVideoAdClosed(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ISREWARDED, isRewarded);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdClosed");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoClose, jsonObject.toString());
                            isRewarded = false;
                        }

                        @Override
                        public void onRewardedVideoAdPlayClicked(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdPlayClicked");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoClicked, jsonObject.toString());
                        }

                        @Override
                        public void onReward(ATAdInfo atAdInfo) {
                            isRewarded = true;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            Logger.log("ATRewardVideoAd android callback to flash: onRewardedVideoAdClosed");
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onRewardedVideoRewarded, jsonObject.toString());
                        }

                    });
                }

                mRewardedAd.setCustomExtra(customMap);
                mRewardedAd.load();
            }
        });
    }

    public boolean isAdReady() {
        if (mRewardedAd != null) {
            return mRewardedAd.isAdReady();
        }
        return false;
    }

    public void showAd() {
        if (mRewardedAd != null) {
            mRewardedAd.show();
        }
    }
}

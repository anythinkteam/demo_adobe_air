package com.anythink.ane.interstitial;

import com.adobe.fre.FREContext;
import com.anythink.ane.ATAneConst;
import com.anythink.core.api.ATAdInfo;
import com.anythink.core.api.AdError;
import com.anythink.interstitial.api.ATInterstitial;
import com.anythink.interstitial.api.ATInterstitialListener;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

public class ATInterstitialImpl {
    String mUnitId;
    ATInterstitial mInterstitial;

    public ATInterstitialImpl(String unitId) {
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
            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalLoadFail, jsonObject.toString());
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

                if (mInterstitial == null) {
                    mInterstitial = new ATInterstitial(context.getActivity(), mUnitId);
                    mInterstitial.setAdListener(new ATInterstitialListener() {
                        @Override
                        public void onInterstitialAdLoaded() {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalLoadSuccess, jsonObject.toString());
                        }

                        @Override
                        public void onInterstitialAdLoadFail(AdError adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalLoadFail, jsonObject.toString());
                        }

                        @Override
                        public void onInterstitialAdClicked(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalClicked, jsonObject.toString());
                        }

                        @Override
                        public void onInterstitialAdShow(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalShow, jsonObject.toString());
                        }

                        @Override
                        public void onInterstitialAdClose(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onInterstitalClose, jsonObject.toString());
                        }

                        @Override
                        public void onInterstitialAdVideoStart() {
                        }

                        @Override
                        public void onInterstitialAdVideoEnd() {

                        }

                        @Override
                        public void onInterstitialAdVideoError(AdError adError) {

                        }
                    });
                }
                mInterstitial.setCustomExtra(customMap);
                mInterstitial.load();
            }
        });
    }

    public boolean isAdReady() {
        if (mInterstitial != null) {
            return mInterstitial.isAdReady();
        }
        return false;
    }

    public void showAd() {
        if (mInterstitial != null) {
            mInterstitial.show();
        }
    }
}

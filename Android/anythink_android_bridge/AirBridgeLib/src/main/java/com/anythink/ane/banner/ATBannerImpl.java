package com.anythink.ane.banner;

import android.app.Activity;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.FrameLayout;

import com.adobe.fre.FREContext;
import com.anythink.ane.ATAneConst;
import com.anythink.ane.utils.Logger;
import com.anythink.core.api.ATAdInfo;
import com.anythink.core.api.AdError;
import com.anythink.banner.api.ATBannerListener;
import com.anythink.banner.api.ATBannerView;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

public class ATBannerImpl {

    ATBannerView mBannerView;
    String mUnitId;
    boolean mIsAdReady;

    public ATBannerImpl(String unitId) {
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
            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerLoadFail, jsonObject.toString());
            return;
        }

        Activity activity = context.getActivity();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                synchronized (ATBannerImpl.this) {
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

                    if (mBannerView == null) {
                        mBannerView = new ATBannerView(context.getActivity());
                    }
                    mBannerView.setUnitId(mUnitId);
                    mBannerView.setCustomMap(customMap);
                    mBannerView.setBannerAdListener(new ATBannerListener() {
                        @Override
                        public void onBannerLoaded() {
                            mIsAdReady = true;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerLoadSuccess, jsonObject.toString());
                        }

                        @Override
                        public void onBannerFailed(AdError adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerLoadFail, jsonObject.toString());
                        }

                        @Override
                        public void onBannerClicked(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerClicked, jsonObject.toString());
                        }

                        @Override
                        public void onBannerShow(ATAdInfo atAdInfo) {
                            mIsAdReady = false;
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerShow, jsonObject.toString());
                        }

                        @Override
                        public void onBannerClose() {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerClose, jsonObject.toString());
                        }

                        @Override
                        public void onBannerAutoRefreshed(ATAdInfo atAdInfo) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerAutoRefresh, jsonObject.toString());
                        }


                        @Override
                        public void onBannerAutoRefreshFail(AdError adError) {
                            JSONObject jsonObject = new JSONObject();
                            try {
                                jsonObject.put(ATAneConst.CallbackJSONKey.PLACEMENT, mUnitId);
                                jsonObject.put(ATAneConst.CallbackJSONKey.ERROR, adError.printStackTrace());
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            context.dispatchStatusEventAsync(ATAneConst.Callback.onBannerAutoRefreshFail, jsonObject.toString());
                        }
                    });
                    mBannerView.loadAd();
                }
            }
        });

    }

    public boolean isAdReady() {
        return mIsAdReady;
    }

    public void showAd(FREContext context, final String configMap) {
        final Activity activity = context.getActivity();
        Logger.log("Banner config:" + configMap);
        if (activity != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    synchronized (ATBannerImpl.this) {
                        try {
                            JSONObject jsonObject = new JSONObject(configMap);
                            int x = jsonObject.optInt("x");
                            int y = jsonObject.optInt("y");
                            int w = jsonObject.optInt("w");
                            int h = jsonObject.optInt("h");
                            if (mBannerView != null) {
                                FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(w, h);
                                layoutParams.leftMargin = x;
                                layoutParams.topMargin = y;
                                if (mBannerView.getParent() != null) {
                                    ((ViewGroup) mBannerView.getParent()).removeView(mBannerView);
                                }
                                activity.addContentView(mBannerView, layoutParams);
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
                    synchronized (ATBannerImpl.this) {
                        if (mBannerView != null && mBannerView.getParent() != null) {
                            ViewParent viewParent = mBannerView.getParent();
                            ((ViewGroup) viewParent).removeView(mBannerView);
                            mBannerView = null;
                        }
                    }
                }
            });
        }
    }


}

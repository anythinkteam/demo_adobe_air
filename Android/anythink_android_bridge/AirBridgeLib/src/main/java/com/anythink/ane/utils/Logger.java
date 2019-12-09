package com.anythink.ane.utils;

import android.util.Log;

import com.anythink.ane.ATSDKContext;

public class Logger {
    public static void log(String msg) {
        if (ATSDKContext.isDebug) {
            Log.e(ATSDKContext.TAG, msg);
        }
    }
}

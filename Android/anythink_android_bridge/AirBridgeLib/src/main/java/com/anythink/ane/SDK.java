package com.anythink.ane;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class SDK implements FREExtension {

    private static FREContext context;
    private String TOAST_FUNC_KEY = "toast";

    @Override
    public void initialize() {
        Log.i("FREContext", "initialize:");
    }

    @Override
    public FREContext createContext(String s) {
        Log.i("FREContext", "createContenxt:" + s);
        context = new ATSDKContext();
        return context;
    }

    @Override
    public void dispose() {
        Log.i("FREContext", "dispose:");
    }
}

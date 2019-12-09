package com.anythink.ane.nativead;

import android.graphics.Color;
import android.text.TextUtils;

import org.json.JSONObject;

public class ATNativeItem {
    int x;
    int y;
    int width;
    int height;

    int textColor;
    int backgroupColor;
    int textSize;


    protected static ATNativeItem parseConfig(JSONObject jsonObject) {
        ATNativeItem nativeItem = new ATNativeItem();
        try {
            nativeItem.x = jsonObject.optInt("x");
            nativeItem.y = jsonObject.optInt("y");
            nativeItem.width = jsonObject.optInt("w");
            nativeItem.height = jsonObject.optInt("h");

            nativeItem.textSize = jsonObject.optInt("textSize");

            String textColorStr = jsonObject.optString("textColor");
            String bgColorStr = jsonObject.optString("bgColor");
            if (!TextUtils.isEmpty(textColorStr)) {
                nativeItem.textColor = Color.parseColor(textColorStr);
            }

            if (!TextUtils.isEmpty(bgColorStr)) {
                nativeItem.backgroupColor = Color.parseColor(bgColorStr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return nativeItem;
    }
}

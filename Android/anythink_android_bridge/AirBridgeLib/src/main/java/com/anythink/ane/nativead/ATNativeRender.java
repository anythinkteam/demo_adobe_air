package com.anythink.ane.nativead;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.text.TextUtils;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.anythink.ane.utils.image.CommonBitmapUtil;
import com.anythink.ane.utils.image.CommonImageLoader;
import com.anythink.nativead.api.ATNativeAdRenderer;
import com.anythink.nativead.unitgroup.api.CustomNativeAd;


/**
 * Copyright (C) 2018 {XX} Science and Technology Co., Ltd.
 *
 * @version V{XX_XX}
 */
public class ATNativeRender implements ATNativeAdRenderer<CustomNativeAd> {

    Activity mActivity;

    public ATNativeRender(Activity pActivity) {
        mActivity = pActivity;
    }


    @Override
    public View createView(Context context, int networkType) {
        return new FrameLayout(context);
    }


    ATNativeItem iconItem;
    ATNativeItem mainImageItem;
    ATNativeItem titleItem;
    ATNativeItem descItem;
    ATNativeItem adlogoItem;
    ATNativeItem ctaItem;

    public void setItemProperty(ATNativeItem iconItem,
                                ATNativeItem mainImageItem,
                                ATNativeItem titleItem,
                                ATNativeItem descItem,
                                ATNativeItem adlogoItem,
                                ATNativeItem ctaItem) {
        this.iconItem = iconItem;
        this.mainImageItem = mainImageItem;
        this.titleItem = titleItem;
        this.descItem = descItem;
        this.adlogoItem = adlogoItem;
        this.ctaItem = ctaItem;
    }

    @Override
    public void renderAdView(View view, CustomNativeAd ad) {

        FrameLayout.LayoutParams titleParam = new FrameLayout.LayoutParams(titleItem.width, titleItem.height);
        titleParam.leftMargin = titleItem.x;
        titleParam.topMargin = titleItem.y;
        TextView titleView = new TextView(mActivity);
        titleView.setLayoutParams(titleParam);
        titleView.setTextSize(TypedValue.COMPLEX_UNIT_PX, titleItem.textSize);
        titleView.setTextColor(titleItem.textColor);
        titleView.setText(ad.getTitle());


        FrameLayout.LayoutParams descParam = new FrameLayout.LayoutParams(descItem.width, descItem.height);
        descParam.leftMargin = descItem.x;
        descParam.topMargin = descItem.y;
        TextView descView = new TextView(mActivity);
        descView.setLayoutParams(descParam);
        descView.setTextSize(TypedValue.COMPLEX_UNIT_PX, descItem.textSize);
        descView.setTextColor(descItem.textColor);
        descView.setText(ad.getDescriptionText());

        FrameLayout.LayoutParams ctaParam = new FrameLayout.LayoutParams(ctaItem.width, ctaItem.height);
        ctaParam.leftMargin = ctaItem.x;
        ctaParam.topMargin = ctaItem.y;
        TextView ctaView = new TextView(mActivity);
        ctaView.setLayoutParams(ctaParam);
        ctaView.setGravity(Gravity.CENTER);
        ctaView.setTextSize(TypedValue.COMPLEX_UNIT_PX, ctaItem.textSize);
        ctaView.setBackgroundColor(ctaItem.backgroupColor);
        ctaView.setTextColor(ctaItem.textColor);
        ctaView.setText(ad.getCallToActionText());

//        ImageView logoView = (ImageView) mViewInfo.adLogView.mView;
//        ImageView iconView = (ImageView) mViewInfo.IconView.mView;


        FrameLayout.LayoutParams mainImageParam = new FrameLayout.LayoutParams(mainImageItem.width, mainImageItem.height);
        mainImageParam.leftMargin = mainImageItem.x;
        mainImageParam.topMargin = mainImageItem.y;
        View mediaView = ad.getAdMediaView((ViewGroup) view, mainImageItem.width);
        if (mediaView == null) {
            final RecycleImageView mainImageView = new RecycleImageView(mActivity);
            mainImageView.setLayoutParams(mainImageParam);
            mediaView = mainImageView;

            CommonImageLoader.getInstance().startLoadImage(ad.getMainImageUrl(), mainImageItem.width, new CommonImageLoader.ImageCallback() {
                @Override
                public void onSuccess(Bitmap bitmap, String url) {
                    mainImageView.setImageBitmap(bitmap);
                }

                @Override
                public void onFail() {

                }
            });
        } else {
            mediaView.setLayoutParams(mainImageParam);
        }


        FrameLayout.LayoutParams iconImageParam = new FrameLayout.LayoutParams(iconItem.width, iconItem.height);
        iconImageParam.leftMargin = iconItem.x;
        iconImageParam.topMargin = iconItem.y;
        View iconView = null;
        try {
            iconView = ad.getAdIconView();
        } catch (Exception e) {

        }
        if (iconView == null) {
            final RecycleImageView iconSelfView = new RecycleImageView(mActivity);
            CommonImageLoader.getInstance().startLoadImage(ad.getIconImageUrl(), iconItem.width, new CommonImageLoader.ImageCallback() {
                @Override
                public void onSuccess(Bitmap bitmap, String url) {
                    iconSelfView.setImageBitmap(bitmap);
                }

                @Override
                public void onFail() {

                }
            });
            iconView = iconSelfView;
            iconView.setLayoutParams(iconImageParam);
        }


        FrameLayout.LayoutParams adlogoParam = new FrameLayout.LayoutParams(adlogoItem.width, adlogoItem.height);
        adlogoParam.leftMargin = adlogoItem.x;
        adlogoParam.topMargin = adlogoItem.y;
        final RecycleImageView adlogView = new RecycleImageView(mActivity);
        adlogView.setLayoutParams(adlogoParam);
        CommonImageLoader.getInstance().startLoadImage(ad.getAdChoiceIconUrl(), adlogoParam.width, new CommonImageLoader.ImageCallback() {
            @Override
            public void onSuccess(Bitmap bitmap, String url) {
                adlogView.setImageBitmap(bitmap);
            }

            @Override
            public void onFail() {

            }
        });

        ((ViewGroup) view).addView(titleView);
        ((ViewGroup) view).addView(descView);
        ((ViewGroup) view).addView(ctaView);
        ((ViewGroup) view).addView(mediaView);
        ((ViewGroup) view).addView(iconView);
        ((ViewGroup) view).addView(adlogView);

        if (!TextUtils.isEmpty(ad.getAdFrom())) {
            FrameLayout.LayoutParams adFromParam = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
            adFromParam.leftMargin = CommonBitmapUtil.dip2px(mActivity, 3);
            adFromParam.topMargin = CommonBitmapUtil.dip2px(mActivity, 3);
            TextView adFromTextView = new TextView(mActivity);
            adFromTextView.setTextSize(TypedValue.COMPLEX_UNIT_DIP, 6);
            adFromTextView.setPadding(CommonBitmapUtil.dip2px(mActivity, 5), CommonBitmapUtil.dip2px(mActivity, 2), CommonBitmapUtil.dip2px(mActivity, 5), CommonBitmapUtil.dip2px(mActivity, 2));
            adFromTextView.setBackgroundColor(0xff888888);
            adFromTextView.setTextColor(0xffffffff);
            adFromTextView.setText(ad.getAdFrom());

            ((ViewGroup) view).addView(adFromTextView, adFromParam);
        }

    }
}

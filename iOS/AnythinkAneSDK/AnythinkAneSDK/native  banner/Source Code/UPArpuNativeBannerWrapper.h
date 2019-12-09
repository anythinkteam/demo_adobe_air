//
//  UPArpuNativeBannerWrapper.h
//  UpArpuSDKDemo
//
//  Created by Martin Lau on 2019/4/10.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UpArpuNative/UpArpuNative.h>

@class UPArpuNativeBannerView;
@protocol UPArpuNativeBannerDelegate<NSObject>
-(void) didFinishLoadingNativeBannerAdWithPlacementID:(NSString *)placementID;
-(void) didFailToLoadNativeBannerAdWithPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) didShowNativeBannerAdInView:(UPArpuNativeBannerView*)bannerView placementID:(NSString*)placementID;
-(void) didClickNativeBannerAdInView:(UPArpuNativeBannerView*)bannerView placementID:(NSString*)placementID;
-(void) didClickCloseButtonInNativeBannerAdView:(UPArpuNativeBannerView*)bannerView placementID:(NSString*)placementID;
-(void) didAutorefreshNativeBannerAdInView:(UPArpuNativeBannerView*)bannerView placementID:(NSString*)placementID;
-(void) didFailToAutorefreshNativeBannerAdInView:(UPArpuNativeBannerView*)bannerView placementID:(NSString*)placementID error:(NSError*)error;
@end

@interface UPArpuNativeBannerView:UIView
@property(nonatomic, weak) id<UPArpuNativeBannerDelegate> delegate;
@end

extern NSString *const kUPArpuNativeBannerAdShowingExtraBackgroundColorKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraAdSizeKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraHideCloseButtonFlagKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonBackgroundColorKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonTitleFontKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonTitleColorKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraTitleFontKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraTitleColorKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraTextFontKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraTextColorKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraAdvertiserTextFontKey;
extern NSString *const kUPArpuNativeBannerAdShowingExtraAdvertiserTextColorKey;
@interface UPArpuNativeBannerWrapper:NSObject
+(instancetype) sharedWrapper;
+(void) loadNativeBannerAdWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<UPArpuNativeBannerDelegate>)delegate;
+(UPArpuNativeBannerView*) retrieveNativeBannerAdViewWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra delegate:(id<UPArpuNativeBannerDelegate>)delegate;
+(BOOL) nativeBannerAdReadyForPlacementID:(NSString*)placementID;
@end

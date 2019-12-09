//
//  ATAneNativeBannerAd.m
//  ATAneSDK
//
//  Created by stephen on 2019/5/6.
//  Copyright © 2019 anythink. All rights reserved.
//

#import "ATAneSDK.h"
#import "ATAneNativeBannerAd.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTAutolayoutCategories.h"
#import "ATAneUtilities.h"

@import AnyThinkSDK;
@import AnyThinkNative;

@interface ATAneNativeBannerAd ()<ATNativeBannerDelegate>
@property(nonatomic, readonly) NSMutableDictionary<NSString*, ATNativeBannerView*> *bannerViewStorage;
@property(nonatomic, readonly) BOOL interstitialOrRVBeingShown;
@end


@implementation ATAneNativeBannerAd


+(instancetype)sharedInstance {
    static ATAneNativeBannerAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneNativeBannerAd alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        _bannerViewStorage = [NSMutableDictionary<NSString*, ATNativeBannerView*> dictionary];
    }
    return self;
}


DEFINE_ANE_FUNCTION(loadNativeBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"loadNativeBannerAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSDictionary *dict = nil;
        if(argv[1] != nil){
            NSString *customString = [FREConversionUtil toString:argv[1]];
            dict = [FREUtils dictionaryWithJsonString:customString];
        }
//        NSDictionary *extraDict = nil;
//        if(argv[2] != nil){
//            NSString *extraString = [FREConversionUtil toString:argv[2]];
//
//            extraDict = [FREUtils dictionaryWithJsonString:extraString];
//        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [ATNativeBannerWrapper loadNativeBannerAdWithPlacementID:placementId extra:nil customData:dict delegate:[ATAneNativeBannerAd sharedInstance]];
        });
        
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    return result;
  
}

DEFINE_ANE_FUNCTION(showNativeBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"showNativeBannerAd call!");
        
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSString *customString = [FREConversionUtil toString:argv[1]];
        NSString *configString = [FREConversionUtil toString:argv[2]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dict = [FREUtils dictionaryWithJsonString:customString];
            double x = [dict[@"x"] doubleValue];
            double y = [dict[@"y"] doubleValue];
            double w = [dict[@"w"] doubleValue];
            double h = [dict[@"h"] doubleValue];
            
            NSDictionary *extraDict = nil;
            if(configString != nil && [configString length] > 0){
                
                NSDictionary *configDict = [FREUtils dictionaryWithJsonString:configString];
                int refreshTime = [configDict[@"autoRefreshTime"] intValue];
                refreshTime = refreshTime/1000.0f;
                BOOL closeButton = [configDict[@"showCloseButton"] boolValue];
                //                NSString* bgColor = configDict[@"bgColor"];
                //                NSString* ctaBgColor = configDict[@"ctaBgColor"];
                int ctaTitleSize = [configDict[@"ctaTitleSize"] intValue];
                //                NSString* ctaTitleColor = configDict[@"ctaTitleColor"];
                int adTitleSize = [configDict[@"adTitleSize"] intValue];
                //                NSString* adTitleColor = configDict[@"adTitleColor"];
                int adDescSize = [configDict[@"adDescSize"] intValue];
                //                NSString* adDescColor = configDict[@"adDescColor"];
//                int advertiserTextSize = [configDict[@"advertiserTextSize"] intValue];
                //                NSString* advertiserTextColor = configDict[@"advertiserTextColor"];
                
                extraDict = @{kATNativeBannerAdShowingExtraAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(w, h)], kATNativeBannerAdShowingExtraAutorefreshIntervalKey:[NSNumber numberWithInteger:refreshTime], kATNativeBannerAdShowingExtraHideCloseButtonFlagKey:closeButton?@NO:@YES, kATNativeBannerAdShowingExtraCTAButtonBackgroundColorKey:[UIColor colorWithHexString:configDict[@"ctaBgColor"]], kATNativeBannerAdShowingExtraCTAButtonTitleColorKey:[UIColor colorWithHexString:configDict[@"ctaTitleColor"]], kATNativeBannerAdShowingExtraCTAButtonTitleFontKey:[UIFont systemFontOfSize:ctaTitleSize], kATNativeBannerAdShowingExtraTitleColorKey:[UIColor colorWithHexString:configDict[@"adTitleColor"]], kATNativeBannerAdShowingExtraTitleFontKey:[UIFont systemFontOfSize:adTitleSize], kATNativeBannerAdShowingExtraTextColorKey:[UIColor colorWithHexString:configDict[@"adDescColor"]], kATNativeBannerAdShowingExtraTextFontKey:[UIFont systemFontOfSize:adDescSize], kATNativeBannerAdShowingExtraBackgroundColorKey:[UIColor colorWithHexString:configDict[@"bgColor"]]};
            }
            
            
//            [UIColor colorWithHexString:metrics[key][@"background_color"]]
            
            ATNativeBannerView *bannerView = [ATNativeBannerWrapper retrieveNativeBannerAdViewWithPlacementID:placementId extra:extraDict delegate:[ATAneNativeBannerAd sharedInstance]];
            bannerView.tag = 3333;
            bannerView.frame = CGRectMake(x, y, CGRectGetWidth(bannerView.bounds), CGRectGetHeight(bannerView.bounds));
//            bannerView.layer.borderColor = [UIColor blueColor].CGColor;
//            bannerView.layer.borderWidth = .5f;
            bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

//            UIButton *bannerCointainer = [UIButton buttonWithType:UIButtonTypeCustom];
//            [bannerCointainer addTarget:[ATAneNativeBannerAd sharedInstance] action:@selector(noop) forControlEvents:UIControlEventTouchUpInside];
//            bannerCointainer.frame = CGRectMake(x, y, w, h);
//            bannerView.frame = bannerCointainer.bounds;
//            [bannerCointainer addSubview:bannerView];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:bannerView];
            [ATAneNativeBannerAd sharedInstance]->_bannerViewStorage[placementId] = bannerView;
        });
        
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
DEFINE_ANE_FUNCTION(removeNativeBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"removeNativeBannerAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ATAneNativeBannerAd sharedInstance]->_bannerViewStorage[placementId] removeFromSuperview];
            [[ATAneNativeBannerAd sharedInstance]->_bannerViewStorage removeObjectForKey:placementId];
        });
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(isNativeBannerAdReady){
    FREObject result = NULL;
    
    @try {
        NSLog(@"isNativeBannerAdReady call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        BOOL isReady = [ATNativeBannerWrapper nativeBannerAdReadyForPlacementID:placementId];
        result = [FREConversionUtil fromBoolean:isReady];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}


//回调json内容：{"placement":"xxxx","error":"error msg", "isRewarded":boolean}

#pragma mark - delegate method(s)
-(void) didFinishLoadingNativeBannerAdWithPlacementID:(NSString *)placementID {
   NSLog(@"ATNativeBannerViewController::didFinishLoadingNativeBannerAdWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeBannerLoadSuccess" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFailToLoadNativeBannerAdWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"ATNativeBannerViewController::didFailToLoadNativeBannerAdWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onNativeBannerLoadFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didShowNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATNativeBannerViewController::didShowNativeBannerAdInView:%@ placementID:%@", bannerView, placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeBannerShow" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didClickNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATNativeBannerViewController::didClickNativeBannerAdInView:%@ placementID:%@", bannerView, placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeBannerClicked" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didClickCloseButtonInNativeBannerAdView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATNativeBannerViewController::didClickCloseButtonInNativeBannerAdView:%@ placementID:%@", bannerView, placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeBannerClose" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATNativeBannerViewController::didAutorefreshNativeBannerAdInView:%@ placementID:%@", bannerView, placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeBannerAutoRefresh" withMessage:[FREUtils jsonString_anythink:dict]];
}


-(void) didFailToAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra error:(NSError*)error {
    NSLog(@"ATNativeBannerViewController::didFailToAutorefreshNativeBannerAdInView:%@ placementID:%@ error:%@", bannerView, placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onNativeBannerAutoRefreshFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

@end

//
//  ATBannerAd.m
//  ATAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAneSDK.h"
#import "ATAneBannerAd.h"

@import AnyThinkSDK;
@import AnyThinkBanner;



@interface ATAneBannerAd ()<ATBannerDelegate>
@property(nonatomic, readonly) NSMutableDictionary<NSString*, ATBannerView*> *bannerViewStorage;
@property(nonatomic, readonly) BOOL interstitialOrRVBeingShown;
@end


@implementation ATAneBannerAd


+(instancetype)sharedInstance {
    static ATAneBannerAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneBannerAd alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        _bannerViewStorage = [NSMutableDictionary<NSString*, ATBannerView*> dictionary];
    }
    return self;
}


DEFINE_ANE_FUNCTION(loadBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"loadBannerAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSDictionary *dict = nil;
        if(argv[1] != nil){
            NSString *customString = [FREConversionUtil toString:argv[1]];
            dict = [FREUtils dictionaryWithJsonString:customString];
        }
        
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:nil  delegate:[ATAneBannerAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    return result;
}

DEFINE_ANE_FUNCTION(showBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"showBannerAd call!");
        
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSString *customString = [FREConversionUtil toString:argv[1]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dict = [FREUtils dictionaryWithJsonString:customString];
            double x = [dict[@"x"] doubleValue];
            double y = [dict[@"y"] doubleValue];
            double w = [dict[@"w"] doubleValue];
            double h = [dict[@"h"] doubleValue];
            
            ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:placementId];
            //            bannerView.frame = CGRectMake([rectDict[@"x"] doubleValue], [rectDict[@"y"] doubleValue], 320.0f, 50.0f);
            bannerView.delegate = [ATAneBannerAd sharedInstance];
            //            [[UIApplication sharedApplication].keyWindow addSubview:bannerView];
            //            self->_bannerViewStorage[placementID] = bannerView;
            UIButton *bannerCointainer = [UIButton buttonWithType:UIButtonTypeCustom];
            [bannerCointainer addTarget:[ATAneBannerAd sharedInstance] action:@selector(noop) forControlEvents:UIControlEventTouchUpInside];
            bannerCointainer.frame = CGRectMake(x, y, w, h);
            bannerView.frame = bannerCointainer.bounds;
            [bannerCointainer addSubview:bannerView];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:bannerCointainer];
            [ATAneBannerAd sharedInstance]->_bannerViewStorage[placementId] = bannerView;
        });
        
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
DEFINE_ANE_FUNCTION(removeBannerAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"removeBannerAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ATAneBannerAd sharedInstance]->_bannerViewStorage[placementId] removeFromSuperview];
            [[ATAneBannerAd sharedInstance]->_bannerViewStorage removeObjectForKey:placementId];
        });
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

DEFINE_ANE_FUNCTION(isBannerAdReady){
    FREObject result = NULL;
    
    @try {
        NSLog(@"isBannerAdReady call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        
        BOOL isReady =[[ATAdManager sharedManager] bannerAdReadyForPlacementID:placementId];
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
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"ATBannerViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onBannerLoadSuccess" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"ATBannerViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onBannerLoadFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) bannerView:(ATBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATBannerViewController::bannerView:didShowAdWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onBannerShow" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) bannerView:(ATBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATBannerViewController::bannerView:didClickWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onBannerClicked" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) bannerView:(ATBannerView*)bannerView didCloseWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATBannerViewController::bannerView:didCloseWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onBannerClose" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) bannerView:(ATBannerView*)bannerView didAutoRefreshWithPlacement:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"ATBannerViewController::bannerView:didAutoRefreshWithPlacement:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onBannerAutoRefresh" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) bannerView:(ATBannerView*)bannerView failedToAutoRefreshWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra error:(NSError*)error {
    NSLog(@"ATBannerViewController::bannerView:failedToAutoRefreshWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onBannerAutoRefreshFail" withMessage:[FREUtils jsonString_anythink:dict]];
}


@end


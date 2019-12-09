//
//  AnythinkAneLib.m
//  AnythinkAneLib
//
//  Created by stephen on 2019/4/2.
//  Copyright © 2019 anythink. All rights reserved.
//

#import "ATAneSDK.h"

FREContext upAirContext = nil;
static ATAneSDK* sharedInstance = nil;

@implementation ATAneSDK

+(instancetype)sharedInstance {
    static ATAneSDK *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneSDK alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

+ (void)dispatchEvent:(NSString*)event withMessage:(NSString*)message {
    
    if (upAirContext != nil) {
        
        NSString* eventName = event ? event : @"LOGGING";
        NSString* messageText = message ? message : @"";
        FREDispatchStatusEventAsync(upAirContext, (const uint8_t*)[eventName UTF8String], (const uint8_t*)[messageText UTF8String]);
    }
}


@end

void ATContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
   
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION(initSDK, NULL),
        MAP_FUNCTION(setDebugLog, NULL),
        MAP_FUNCTION(setGDPRLevel, NULL),
        MAP_FUNCTION(showGdprAuth, NULL),
        MAP_FUNCTION(isEUTraffic, NULL),
        MAP_FUNCTION(getScreenWidth, NULL),
        MAP_FUNCTION(getScreenHeight, NULL),
        
        MAP_FUNCTION(loadRewardedVideoAd, NULL),
        MAP_FUNCTION(showRewardedVideoAd, NULL),
        MAP_FUNCTION(isRewardedVideoAdReady, NULL),
        
        MAP_FUNCTION(loadInterstitialAd, NULL),
        MAP_FUNCTION(showInterstitialAd, NULL),
        MAP_FUNCTION(isInterstitialAdReady, NULL),
        
        MAP_FUNCTION(loadBannerAd, NULL),
        MAP_FUNCTION(showBannerAd, NULL),
        MAP_FUNCTION(removeBannerAd, NULL),
        MAP_FUNCTION(isBannerAdReady, NULL),
        
        MAP_FUNCTION(loadNativeAd, NULL),
        MAP_FUNCTION(showNativeAd, NULL),
        MAP_FUNCTION(removeNativeAd, NULL),
        MAP_FUNCTION(isNativeAdReady, NULL),
        
        MAP_FUNCTION(loadNativeBannerAd, NULL),
        MAP_FUNCTION(showNativeBannerAd, NULL),
        MAP_FUNCTION(removeNativeBannerAd, NULL),
        MAP_FUNCTION(isNativeBannerAdReady, NULL),

    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    

    upAirContext = ctx;
}

void ATContextFinalizer(FREContext ctx) {
    return;
}

void ATExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATContextInitializer;
    *ctxFinalizerToSet = &ATContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

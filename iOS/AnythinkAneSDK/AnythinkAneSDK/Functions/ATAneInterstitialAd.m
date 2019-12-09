//
//  ATInterstitialAd.m
//  ATAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAneSDK.h"
#import "ATAneInterstitialAd.h"

@import AnyThinkSDK;
@import AnyThinkInterstitial;



@interface ATAneInterstitialAd ()<ATInterstitialDelegate>
@end


@implementation ATAneInterstitialAd

+(instancetype)sharedInstance {
    static ATAneInterstitialAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneInterstitialAd alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}



DEFINE_ANE_FUNCTION(loadInterstitialAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"loadInterstitialAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSDictionary *dict = nil;
        if(argv[1] != nil){
            NSString *customString = [FREConversionUtil toString:argv[1]];
            dict = [FREUtils dictionaryWithJsonString:customString];
        }
      
        
//        NSDictionary *extra = [NSDictionary dictionaryWithObject:userId forKey:kATAdLoadingExtraUserIDKey];
        
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:nil customData:dict delegate:[ATAneInterstitialAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    return result;
}

DEFINE_ANE_FUNCTION(showInterstitialAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"showInterstitialAd call!");
        
        UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementId inViewController:rootViewController delegate:[ATAneInterstitialAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
DEFINE_ANE_FUNCTION(isInterstitialAdReady){
    FREObject result = NULL;
    
    @try {
        NSLog(@"isInterstitialAdReady call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        BOOL isReady =[[ATAdManager sharedManager] interstitialReadyForPlacementID:placementId];
        result = [FREConversionUtil fromBoolean:isReady];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}

//回调json内容：{"placement":"xxxx","error":"error msg", "isRewarded":boolean}
#pragma mark - loading delegate
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"inter Demo: didFinishLoadingADWithPlacementID");
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onInterstitalLoadSuccess" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"inter Demo: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onInterstitalLoadFail" withMessage:[FREUtils jsonString_anythink:dict]];
}
#pragma mark - showing delegate
-(void) interstitialDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialDidShowForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onInterstitalShow" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) interstitialDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialDidCloseForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onInterstitalClose" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) interstitialDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialDidClickForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onInterstitalClicked" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void)interstitialFailedToShowForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialFailedToShowForPlacementID:%@ error:%@", placementID, error);
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
//    [ATAneSDK dispatchEvent:@"onRewardedVideoShowFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) interstitialDidStartPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialDidStartPlayingVideoForPlacementID:%@", placementID);
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID,@"placement"];
//    [ATAneSDK dispatchEvent:@"onRewardedVideoClose" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) interstitialDidEndPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"inter Demo: interstitialDidEndPlayingVideoForPlacementID:%@", placementID);
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
//    [ATAneSDK dispatchEvent:@"onRewardedVideoClicked" withMessage:[FREUtils jsonString_anythink:dict]];
}

- (void)interstitialDidFailToPlayVideoForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"ATInterstitialViewController::interstitialDidFailToPlayForPlacementID:%@", placementID);
}




@end

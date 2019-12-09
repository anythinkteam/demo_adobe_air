//
//  ATRewardVideoAd.m
//  ATAneSDK
//
//  Created by stephen on 2019/4/16.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAneRewardedVideoAd.h"
#import "ATAneSDK.h"

//#import <AnythinkSDK/ATAPI.h>
//#import <AnythinkRewardedVideo/ATRewardedVideoDelegate.h>
//#import <AnythinkRewardedVideo/ATAdManager+RewardedVideo.h>
@import AnyThinkSDK;
@import AnyThinkRewardedVideo;

@interface ATAneRewardedVideoAd ()<ATRewardedVideoDelegate>
@end

@implementation ATAneRewardedVideoAd

+(instancetype)sharedInstance {
    static ATAneRewardedVideoAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneRewardedVideoAd alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}


DEFINE_ANE_FUNCTION(loadRewardedVideoAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"loadRewardedVideoAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSString *userId = [FREConversionUtil toString:argv[1]];
        NSString *customString = [FREConversionUtil toString:argv[2]];
        NSDictionary *dict = [FREUtils dictionaryWithJsonString:customString];
        
        NSDictionary *extra = [NSDictionary dictionaryWithObject:userId forKey:kATAdLoadingExtraUserIDKey];
        
        
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:extra customData:dict delegate:[ATAneRewardedVideoAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    return result;
}
DEFINE_ANE_FUNCTION(showRewardedVideoAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"showRewardedVideoAd call!");
        
        UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:placementId inViewController:rootViewController delegate:[ATAneRewardedVideoAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
DEFINE_ANE_FUNCTION(isRewardedVideoAdReady){
    FREObject result = NULL;
    
    @try {
        NSLog(@"isRewardedVideoAdReady call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        BOOL isReady =[[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:placementId];
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
    NSLog(@"RV Demo: didFinishLoadingADWithPlacementID");
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onRewardedVideoLoadSuccess" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"RV Demo: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onRewardedVideoLoadFail" withMessage:[FREUtils jsonString_anythink:dict]];
}
#pragma mark - showing delegate
-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidStartPlayingForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
     [ATAneSDK dispatchEvent:@"onRewardedVideoPlayStart" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidEndPlayingForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
     [ATAneSDK dispatchEvent:@"onRewardedVideoPlayEnd" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidFailToPlayForPlacementID:%@ error:%@", placementID, error);
     NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
     [ATAneSDK dispatchEvent:@"onRewardedVideoShowFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidCloseForPlacementID:%@, rewarded:%@", placementID, rewarded ? @"yes" : @"no");
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",rewarded?@YES:@NO,@"isRewarded", nil];
     [ATAneSDK dispatchEvent:@"onRewardedVideoClose" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidClickForPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
     [ATAneSDK dispatchEvent:@"onRewardedVideoClicked" withMessage:[FREUtils jsonString_anythink:dict]];
}


-(void) rewardedVideoDidRewardSuccessForPlacemenID:(NSString*)placementID extra:(NSDictionary*)extra {
    NSLog(@"RV Demo: rewardedVideoDidRewardSuccessForPlacemenID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
     [ATAneSDK dispatchEvent:@"onRewardedVideoRewarded" withMessage:[FREUtils jsonString_anythink:dict]];
}
@end


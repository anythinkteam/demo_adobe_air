//
//  ATRewardVideoAd.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/16.
//  Copyright © 2019 anythink. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneRewardedVideoAd: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(loadRewardedVideoAd);
DEFINE_ANE_FUNCTION(showRewardedVideoAd);
DEFINE_ANE_FUNCTION(isRewardedVideoAdReady);

@end

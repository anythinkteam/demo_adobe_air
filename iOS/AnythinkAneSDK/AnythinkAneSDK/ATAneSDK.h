//
//  AnythinkAneLib.h
//  AnythinkAneLib
//
//  Created by stephen on 2019/4/2.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "FREConversionUtil.h"

#import "Functions/ATAneBase.h"
#import "Functions/ATAneRewardedVideoAd.h"
#import "Functions/ATAneInterstitialAd.h"
#import "Functions/ATAneBannerAd.h"
#import "Functions/ATAneNativeAd.h"
#import "Functions/ATAneNativeBannerAd.h"


@interface ATAneSDK : NSObject

+ (instancetype)sharedInstance;

+ (void)dispatchEvent:(NSString *)event withMessage:(NSString*)message;

@end

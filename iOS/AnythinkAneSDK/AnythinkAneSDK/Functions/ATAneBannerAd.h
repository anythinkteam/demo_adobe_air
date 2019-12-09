//
//  ATBannerAd.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneBannerAd: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(loadBannerAd);
DEFINE_ANE_FUNCTION(showBannerAd);
DEFINE_ANE_FUNCTION(removeBannerAd);
DEFINE_ANE_FUNCTION(isBannerAdReady);

@end


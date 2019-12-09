//
//  ATAneNativeBannerAd.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/5/6.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneNativeBannerAd: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(loadNativeBannerAd);
DEFINE_ANE_FUNCTION(showNativeBannerAd);
DEFINE_ANE_FUNCTION(removeNativeBannerAd);
DEFINE_ANE_FUNCTION(isNativeBannerAdReady);

@end

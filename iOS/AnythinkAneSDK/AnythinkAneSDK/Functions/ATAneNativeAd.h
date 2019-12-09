//
//  ATNativeAd.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneNativeAd: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(loadNativeAd);
DEFINE_ANE_FUNCTION(showNativeAd);
DEFINE_ANE_FUNCTION(removeNativeAd);
DEFINE_ANE_FUNCTION(isNativeAdReady);

@end

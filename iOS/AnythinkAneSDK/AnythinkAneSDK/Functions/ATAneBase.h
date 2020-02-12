//
//  ATAneBase.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/11.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneBase: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(initSDK);
DEFINE_ANE_FUNCTION(setDebugLog);
DEFINE_ANE_FUNCTION(setGDPRLevel);
DEFINE_ANE_FUNCTION(showGdprAuth);
DEFINE_ANE_FUNCTION(isEUTraffic);
DEFINE_ANE_FUNCTION(getScreenWidth);
DEFINE_ANE_FUNCTION(getScreenHeight);
DEFINE_ANE_FUNCTION(getGDPRLevel);


@end

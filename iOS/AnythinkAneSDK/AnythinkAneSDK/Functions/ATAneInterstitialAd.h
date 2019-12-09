//
//  ATInterstitialAd.h
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FREConversionUtil.h"
#import "FREUtils.h"

@interface ATAneInterstitialAd: NSObject

+ (instancetype)sharedInstance;

DEFINE_ANE_FUNCTION(loadInterstitialAd);
DEFINE_ANE_FUNCTION(showInterstitialAd);
DEFINE_ANE_FUNCTION(isInterstitialAdReady);

@end

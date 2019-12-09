//
//  MPNativeManager.h
//  MobPowerSDK
//
//  Created by Martin Lau on 2018/11/1.
//  Copyright © 2018 AutoMediation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobPowerSDK/MPSDK.h>
#import "MPNativeDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MPNativeManager : NSObject
+(instancetype)sharedManager;
/*
 Count has to be less than/equal to ten
 */
-(void) loadNativeAdsWithPlacementID:(NSString*)placementID count:(NSInteger)count category:(MPAdCategory)category delegate:(id<MPNativeDelegate>)delegate;
-(void) preloadNativeAdsWithPlacementID:(NSString*)placementID count:(NSInteger)count category:(MPAdCategory)category delegate:(id<MPNativeDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END

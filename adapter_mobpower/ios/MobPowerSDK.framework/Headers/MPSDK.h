//
//  MPSDK.h
//  MobPowerSDK
//
//  Created by Martin Lau on 2018/10/30.
//  Copyright © 2018 AutoMediation. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MPAdCategory) {
    MPAdCategoryNone = -1,
    MPAdCategoryAll = 0,
    MPAdCategoryGame = 1,
    MPAdCategoryApplication = 2,
};

extern NSString *const kMPSDKInitializationErrorDomain;
extern NSInteger const kMPSDKErrorCodeInitializationInvalidAppIDOrInvalidAppKeyErrorCode;
extern NSInteger const kMPSDKErrorCodeInitializationSDKAlreadyInitializedErrorCode;

extern NSString *const kMPSDKAdLoadingErrorDomain;
extern NSInteger const kMPSDKAdLoadingNetworkFailureErrorCode;
extern NSInteger const kMPSDKAdLoadingPlacementSettingErrorCode;
extern NSInteger const kMPSDKAdLoadingInvalidInputErrorCode;
@interface MPSDK : NSObject
+(NSString*)sdkVersion;
+(instancetype)sharedSDK;
-(BOOL) startWithAppID:(NSString*)appID appKey:(NSString*)appKey error:(NSError**)error;
@property(nonatomic, readonly) NSString *appKey;
@property(nonatomic, readonly) NSString *appID;
@end

NS_ASSUME_NONNULL_END

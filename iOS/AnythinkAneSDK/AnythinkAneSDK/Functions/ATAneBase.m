//
//  ATAneBase.m
//  AnythinkAneSDK
//
//  Created by stephen on 2019/4/11.
//  Copyright © 2019 anythink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAneBase.h"
@import AnyThinkSDK;


@implementation ATAneBase

+(instancetype)sharedInstance {
    static ATAneBase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneBase alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}


DEFINE_ANE_FUNCTION(initSDK) {
    FREObject result = NULL;
    
//    @try {
//       
//    }
//    @catch (NSException *exception) {
//        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
//        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
//    }
    
    NSString *appId = [FREConversionUtil toString:argv[0]];
    NSString *appKey = [FREConversionUtil toString:argv[1]];
    
    BOOL initResult = [[ATAPI sharedInstance] startWithAppID:appId appKey:appKey error:nil];
    
    result = [FREConversionUtil fromBoolean:initResult];
    
    return result;
}

DEFINE_ANE_FUNCTION(setDebugLog) {
    FREObject result = NULL;
    
    @try {
        NSLog(@"setDebug log call!");
        BOOL status = [FREConversionUtil toBoolean:argv[0]];
        
        [ATAPI setLogEnabled:status];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
   
    
    return result;
}

DEFINE_ANE_FUNCTION(setGDPRLevel) {
    FREObject result = NULL;
//
//    @try {
//
//
//    }
//    @catch (NSException *exception) {
//        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
//        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
//    }

    int level = [FREConversionUtil toInt:argv[0]];
    level = level + 1;
    [[ATAPI sharedInstance] setDataConsentSet:level consentString:nil];
    
    return result;
}

DEFINE_ANE_FUNCTION(showGdprAuth) {
    FREObject result = NULL;
    
//    @try {
//
//
//    }
//    @catch (NSException *exception) {
//        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
//        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
//    }

    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [[ATAPI sharedInstance] presentDataConsentDialogInViewController:rootViewController dismissalCallback:^{
        
    }];
    
    return result;
}

DEFINE_ANE_FUNCTION(isEUTraffic) {
    FREObject result = NULL;
    
//    @try {
//
//    }
//    @catch (NSException *exception) {
//        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
//        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
//    }

    BOOL euResult = [[ATAPI sharedInstance] inDataProtectionArea];
    
    result = [FREConversionUtil fromBoolean:euResult];
    
    return result;
}

DEFINE_ANE_FUNCTION(getScreenWidth) {
    FREObject result = NULL;
    
    //    @try {
    //
    //    }
    //    @catch (NSException *exception) {
    //        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
    //        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    //    }
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
    
    result = [FREConversionUtil fromInt:((int)floor(width))];
    
    return result;
}

DEFINE_ANE_FUNCTION(getScreenHeight) {
    FREObject result = NULL;
    
    //    @try {
    //
    //    }
    //    @catch (NSException *exception) {
    //        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
    //        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    //    }
    
    CGFloat height = [UIScreen mainScreen].applicationFrame.size.height;

    result = [FREConversionUtil fromInt:((int)floor(height))];
    
    return result;
}

@end

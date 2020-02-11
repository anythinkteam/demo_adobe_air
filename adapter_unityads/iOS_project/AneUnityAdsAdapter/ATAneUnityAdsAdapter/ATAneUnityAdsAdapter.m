//
//  ATUnityAdsAdapter.m
//  ATUnityAdsAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneUnityAdsAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneUnityAdsAdapter

@end

void ATUnityAdsContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATUnityAdsContextFinalizer(FREContext ctx) {
    return;
}

void ATUnityAdsExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATUnityAdsContextInitializer;
    *ctxFinalizerToSet = &ATUnityAdsContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATUnityAdsExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

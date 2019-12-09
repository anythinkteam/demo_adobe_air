//
//  UpArpuUnityAdsAdapter.m
//  UpArpuUnityAdsAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneUnityAdsAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneUnityAdsAdapter

@end

void UPArpuUnityAdsContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuUnityAdsContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuUnityAdsExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuUnityAdsContextInitializer;
    *ctxFinalizerToSet = &UPArpuUnityAdsContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuUnityAdsExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

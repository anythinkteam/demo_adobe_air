//
//  UpArpuMobpowerAdapter.m
//  UpArpuMobpowerAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneMobpowerAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneMobpowerAdapter

@end

void UPArpuMobpowerContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuMobpowerContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuMobpowerExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuMobpowerContextInitializer;
    *ctxFinalizerToSet = &UPArpuMobpowerContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuMobpowerExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

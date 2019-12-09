//
//  UpArpuOnewayAdapter.m
//  UpArpuOnewayAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneOnewayAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneOnewayAdapter

@end

void UPArpuOnewayContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuOnewayContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuOnewayExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuOnewayContextInitializer;
    *ctxFinalizerToSet = &UPArpuOnewayContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuOnewayExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

//
//  UpArpuFlurryAdapter.m
//  UpArpuFlurryAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneFlurryAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneFlurryAdapter

@end

void UPArpuFlurryContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuFlurryContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuFlurryExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuFlurryContextInitializer;
    *ctxFinalizerToSet = &UPArpuFlurryContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuFlurryExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

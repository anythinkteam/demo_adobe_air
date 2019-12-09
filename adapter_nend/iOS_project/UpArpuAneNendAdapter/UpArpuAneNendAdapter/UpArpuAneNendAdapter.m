//
//  UpArpuNendAdapter.m
//  UpArpuNendAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneNendAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneNendAdapter

@end

void UPArpuNendContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuNendContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuNendExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuNendContextInitializer;
    *ctxFinalizerToSet = &UPArpuNendContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuNendExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

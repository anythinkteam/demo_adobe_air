//
//  UpArpuTTAdapter.m
//  UpArpuTTAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneTTAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneTTAdapter

@end

void UPArpuTTContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuTTContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuTTExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuTTContextInitializer;
    *ctxFinalizerToSet = &UPArpuTTContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuTTExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

//
//  UpArpuInmobiAdapter.m
//  UpArpuInmobiAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneInmobiAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneInmobiAdapter

@end

void UPArpuInmobiContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuInmobiContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuInmobiExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuInmobiContextInitializer;
    *ctxFinalizerToSet = &UPArpuInmobiContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuInmobiExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

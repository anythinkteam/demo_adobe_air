//
//  UpArpuIronsourceAdapter.m
//  UpArpuIronsourceAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneIronsourceAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneIronsourceAdapter

@end

void UPArpuIronsourceContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuIronsourceContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuIronsourceExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuIronsourceContextInitializer;
    *ctxFinalizerToSet = &UPArpuIronsourceContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuIronsourceExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

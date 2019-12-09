//
//  UpArpuVungleAdapter.m
//  UpArpuVungleAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneVungleAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneVungleAdapter

@end

void UPArpuVungleContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuVungleContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuVungleExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuVungleContextInitializer;
    *ctxFinalizerToSet = &UPArpuVungleContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuVungleExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

//
//  UpArpuMaioAdapter.m
//  UpArpuMaioAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneMaioAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneMaioAdapter

@end

void UPArpuMaioContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuMaioContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuMaioExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuMaioContextInitializer;
    *ctxFinalizerToSet = &UPArpuMaioContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuMaioExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

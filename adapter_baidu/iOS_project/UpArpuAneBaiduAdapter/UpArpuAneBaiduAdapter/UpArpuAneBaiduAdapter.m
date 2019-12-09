//
//  UpArpuBaiduAdapter.m
//  UpArpuBaiduAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneBaiduAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneBaiduAdapter

@end

void UPArpuBaiduContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuBaiduContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuBaiduExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuBaiduContextInitializer;
    *ctxFinalizerToSet = &UPArpuBaiduContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuBaiduExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

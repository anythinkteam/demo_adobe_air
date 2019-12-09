//
//  UpArpuMintegralAdapter.m
//  UpArpuMintegralAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneMintegralAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneMintegralAdapter

@end

void UPArpuMintegralContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuMintegralContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuMintegralExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuMintegralContextInitializer;
    *ctxFinalizerToSet = &UPArpuMintegralContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuMintegralExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

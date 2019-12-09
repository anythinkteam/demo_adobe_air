//
//  UpArpuAneAdmobAdapter.m
//  UpArpuAneAdmobAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneAdmobAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneAdmobAdapter

@end

void UPArpuAdmobContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuAdmobContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuAdmobExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuAdmobContextInitializer;
    *ctxFinalizerToSet = &UPArpuAdmobContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuAdmobExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

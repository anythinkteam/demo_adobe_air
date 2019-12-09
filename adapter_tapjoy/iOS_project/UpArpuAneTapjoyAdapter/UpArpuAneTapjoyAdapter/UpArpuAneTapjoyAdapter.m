//
//  UpArpuTapjoyAdapter.m
//  UpArpuTapjoyAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneTapjoyAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneTapjoyAdapter

@end

void UPArpuTapjoyContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuTapjoyContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuTapjoyExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuTapjoyContextInitializer;
    *ctxFinalizerToSet = &UPArpuTapjoyContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuTapjoyExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

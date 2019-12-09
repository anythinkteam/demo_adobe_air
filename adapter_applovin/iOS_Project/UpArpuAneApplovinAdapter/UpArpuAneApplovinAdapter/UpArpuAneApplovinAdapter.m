//
//  UpArpuApplovinAdapter.m
//  UpArpuApplovinAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneApplovinAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneApplovinAdapter

@end

void UPArpuApplovinContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuApplovinContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuApplovinExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuApplovinContextInitializer;
    *ctxFinalizerToSet = &UPArpuApplovinContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuApplovinExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

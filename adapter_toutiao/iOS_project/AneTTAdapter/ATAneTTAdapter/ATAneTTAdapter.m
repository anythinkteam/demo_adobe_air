//
//  ATTTAdapter.m
//  ATTTAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneTTAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneTTAdapter

@end

void ATTTContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATTTContextFinalizer(FREContext ctx) {
    return;
}

void ATTTExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATTTContextInitializer;
    *ctxFinalizerToSet = &ATTTContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATTTExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

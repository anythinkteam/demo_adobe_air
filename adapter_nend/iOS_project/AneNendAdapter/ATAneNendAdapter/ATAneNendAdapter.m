//
//  ATNendAdapter.m
//  ATNendAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneNendAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneNendAdapter

@end

void ATNendContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATNendContextFinalizer(FREContext ctx) {
    return;
}

void ATNendExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATNendContextInitializer;
    *ctxFinalizerToSet = &ATNendContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATNendExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

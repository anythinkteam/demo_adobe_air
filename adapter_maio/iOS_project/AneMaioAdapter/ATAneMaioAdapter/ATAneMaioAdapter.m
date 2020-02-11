//
//  ATMaioAdapter.m
//  ATMaioAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneMaioAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneMaioAdapter

@end

void ATMaioContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATMaioContextFinalizer(FREContext ctx) {
    return;
}

void ATMaioExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATMaioContextInitializer;
    *ctxFinalizerToSet = &ATMaioContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATMaioExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

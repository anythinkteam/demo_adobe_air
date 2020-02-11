//
//  ATMintegralAdapter.m
//  ATMintegralAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneMintegralAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneMintegralAdapter

@end

void ATMintegralContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATMintegralContextFinalizer(FREContext ctx) {
    return;
}

void ATMintegralExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATMintegralContextInitializer;
    *ctxFinalizerToSet = &ATMintegralContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATMintegralExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

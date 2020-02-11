//
//  ATAneFacebookAdapter.m
//  ATAneFacebookAdapter
//
//  Created by stephen on 2019/4/21.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneFacebookAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneFacebookAdapter

@end

void ATFacebookContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
      
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;

}

void ATFacebookContextFinalizer(FREContext ctx) {
    return;
}

void ATFacebookExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATFacebookContextInitializer;
    *ctxFinalizerToSet = &ATFacebookContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATFacebookExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

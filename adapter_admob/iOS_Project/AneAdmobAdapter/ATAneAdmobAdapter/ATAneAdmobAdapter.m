//
//  ATAneAdmobAdapter.m
//  ATAneAdmobAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "ATAneAdmobAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation ATAneAdmobAdapter

@end

void ATAdmobContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void ATAdmobContextFinalizer(FREContext ctx) {
    return;
}

void ATAdmobExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &ATAdmobContextInitializer;
    *ctxFinalizerToSet = &ATAdmobContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void ATAdmobExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

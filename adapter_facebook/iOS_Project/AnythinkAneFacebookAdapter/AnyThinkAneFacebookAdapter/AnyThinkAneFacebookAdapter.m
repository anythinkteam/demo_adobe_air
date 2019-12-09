//
//  AnyThinkAneFacebookAdapter.m
//  AnyThinkAneFacebookAdapter
//
//  Created by stephen on 2019/4/21.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "AnyThinkAneFacebookAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation AnyThinkAneFacebookAdapter

@end

void UPArpuFacebookContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
      
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;

}

void UPArpuFacebookContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuFacebookExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuFacebookContextInitializer;
    *ctxFinalizerToSet = &UPArpuFacebookContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuFacebookExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

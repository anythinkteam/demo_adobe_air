//
//  UpArpuAneGDTAdapter.m
//  UpArpuAneGDTAdapter
//
//  Created by stephen on 2019/4/21.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneGDTAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneGDTAdapter

@end

void UPArpuGDTContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
      
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;

}

void UPArpuGDTContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuGDTExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuGDTContextInitializer;
    *ctxFinalizerToSet = &UPArpuGDTContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuGDTExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

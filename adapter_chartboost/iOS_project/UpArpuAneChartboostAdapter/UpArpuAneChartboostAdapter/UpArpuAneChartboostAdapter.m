//
//  UpArpuChartboostAdapter.m
//  UpArpuChartboostAdapter
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 uparpu. All rights reserved.
//

#import "UpArpuAneChartboostAdapter.h"
#import "FlashRuntimeExtensions.h"

@implementation UpArpuAneChartboostAdapter

@end

void UPArpuChartboostContextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
}

void UPArpuChartboostContextFinalizer(FREContext ctx) {
    return;
}

void UPArpuChartboostExtensionInitializer(void **extDataToSet, FREContextInitializer *ctxInitializerToSet, FREContextFinalizer *ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtensionInitializer()");
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &UPArpuChartboostContextInitializer;
    *ctxFinalizerToSet = &UPArpuChartboostContextFinalizer;
    
    NSLog(@"Exiting ExtensionInitializer()");
}

void UPArpuChartboostExtensionFinalizer() {
    
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
    
    return;
}

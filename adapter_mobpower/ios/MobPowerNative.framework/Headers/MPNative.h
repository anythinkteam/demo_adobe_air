//
//  MPNative.h
//  MobPowerNative
//
//  Created by Martin Lau on 2018/10/29.
//  Copyright © 2018 AutoMediation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MPNativeDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@interface MPNative : NSObject
/*
 Before calling this method to register for the click event, you have to set the delegate.
 */
- (void)registerViewForInteraction:(UIView *)view withViewController:(nullable UIViewController *)viewController withClickableViews:(NSArray<UIView*>*)clickableViews;
@property(nonatomic, readonly) NSString *placementID;
@property(nonatomic, readonly) NSString *titile;
@property(nonatomic, readonly) NSString *body;
@property(nonatomic, readonly) double star;
@property(nonatomic, readonly) NSString *ctaText;
@property(nonatomic, readonly) NSString *packageName;
@property(nonatomic, readonly) NSURL *iconURL;
@property(nonatomic, readonly) NSURL *imageURL;
@property(nonatomic, weak) id<MPNativeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

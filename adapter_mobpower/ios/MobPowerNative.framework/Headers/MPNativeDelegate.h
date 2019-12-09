//
//  MPNativeDelegate.h
//  MobPowerNative
//
//  Created by Martin Lau on 2018/10/29.
//  Copyright © 2018 AutoMediation. All rights reserved.
//

#ifndef MPNativeDelegate_h
#define MPNativeDelegate_h
@class MPNative;
@protocol MPNativeDelegate<NSObject>
@optional;
-(void) didPreloadNativeAdsForPlacementID:(NSString*)placementID;
-(void) didLoadNativeAds:(NSArray<MPNative*>*)ads forPlacementID:(NSString*)placementID;
-(void) failToLoadNativeAdsForPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) didShowNativeAd:(MPNative*)nativeAd;
-(void) didClickNativeAd:(MPNative*)nativeAd;
-(void) startClickNativeAd:(MPNative*)nativeAd;
-(void) endClickNativeAd:(MPNative*)nativeAd;
@end
#endif /* MPNativeDelegate_h */

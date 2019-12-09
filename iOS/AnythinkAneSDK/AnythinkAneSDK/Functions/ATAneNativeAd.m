//
//  ATNativeAd.m
//  ATAneSDK
//
//  Created by stephen on 2019/4/18.
//  Copyright © 2019 anythink. All rights reserved.
//

#import "ATAneSDK.h"
#import "ATAneNativeAd.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTAutolayoutCategories.h"
#import "ATAneUtilities.h"

@import AnyThinkSDK;
@import AnyThinkNative;


static NSString *const kParsedPropertiesFrameKey = @"frame";
static NSString *const kParsedPropertiesBackgroundColorKey = @"background_color";
static NSString *const kParsedPropertiesTextColorKey = @"text_color";
static NSString *const kParsedPropertiesTextSizeKey = @"text_size";

static NSString *const kNativeAssetAdvertiser = @"advertiser_label";
static NSString *const kNativeAssetText = @"text";
static NSString *const kNativeAssetTitle = @"title";
static NSString *const kNativeAssetCta = @"cta";
static NSString *const kNativeAssetRating = @"rating";
static NSString *const kNativeAssetIcon = @"icon";
static NSString *const kNativeAssetMainImage = @"main_image";
static NSString *const kNativeAssetSponsorImage = @"sponsor_image";
static NSString *const kNativeAssetMedia = @"media";

NSDictionary* parseAneProperties(NSDictionary *properties) {
    NSMutableDictionary *result = NSMutableDictionary.dictionary;
    result[kParsedPropertiesFrameKey] = [NSString stringWithFormat:@"{{%@, %@}, {%@, %@}}", properties[@"x"], properties[@"y"], properties[@"w"], properties[@"h"]];
    result[kParsedPropertiesBackgroundColorKey] = properties[@"bgColor"];
    result[kParsedPropertiesTextColorKey] = properties[@"textColor"];
    result[kParsedPropertiesTextSizeKey] = properties[@"textSize"];
    
    return result;
}

NSDictionary* parseAneMetrics(NSDictionary* metrics) {
    NSMutableDictionary *result = NSMutableDictionary.dictionary;
    NSDictionary *keysMap = @{@"icon":kNativeAssetIcon, @"mainImage":kNativeAssetMainImage, @"title":kNativeAssetTitle, @"desc":kNativeAssetText, @"adLogo":kNativeAssetSponsorImage, @"cta":kNativeAssetCta};
    [keysMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) { result[keysMap[key]] = parseAneProperties(metrics[key]); }];
    return result;
}


@interface ATAneNativeAdView:ATNativeADView
@property(nonatomic, readonly) UILabel *advertiserLabel;
@property(nonatomic, readonly) UILabel *textLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *ctaLabel;
@property(nonatomic, readonly) UILabel *ratingLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;
@property(nonatomic, readonly) UIImageView *mainImageView;
@property(nonatomic, readonly) UIImageView *sponsorImageView;
-(void) configureMetrics:(NSDictionary<NSString*, NSString*>*)metrics;
@end

@implementation ATAneNativeAdView
-(void) initSubviews {
    [super initSubviews];
    _advertiserLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:15.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_advertiserLabel];
    
    _titleLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:18.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    
    _textLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor blackColor]];
    _textLabel.numberOfLines = 2;
    [self addSubview:_textLabel];
    
    _ctaLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ctaLabel];
    
    _ratingLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ratingLabel];
    
    _iconImageView = [UIImageView autolayoutView];
    _iconImageView.layer.cornerRadius = 4.0f;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImageView];
    
    _mainImageView = [UIImageView autolayoutView];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mainImageView];
    
    _sponsorImageView = [UIImageView autolayoutView];
    _sponsorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_sponsorImageView];
}

-(NSArray<UIView*>*)clickableViews {
    NSMutableArray *clickableViews = [NSMutableArray arrayWithObjects:_iconImageView, _ctaLabel, nil];
    if (self.mediaView != nil) { [clickableViews addObject:self.mediaView]; }
    return clickableViews;
}

-(void) configureMetrics:(NSDictionary *)metrics {
    NSDictionary<NSString*, UIView*> *views = @{kNativeAssetTitle:_titleLabel, kNativeAssetText:_textLabel, kNativeAssetCta:_ctaLabel, kNativeAssetRating:_ratingLabel, kNativeAssetAdvertiser:_advertiserLabel, kNativeAssetIcon:_iconImageView, kNativeAssetMainImage:_mainImageView, kNativeAssetSponsorImage:_sponsorImageView};
    [views enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        CGRect frame = CGRectFromString(metrics[key][kParsedPropertiesFrameKey]);
        [self addConstraintsWithVisualFormat:[NSString stringWithFormat:@"|-x-[%@(w)]", key] options:0 metrics:@{@"x":@(frame.origin.x), @"w":@(frame.size.width)} views:views];
        [self addConstraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-y-[%@(h)]", key] options:0 metrics:@{@"y":@(frame.origin.y), @"h":@(frame.size.height)} views:views];
        if ([obj respondsToSelector:@selector(setBackgroundColor:)] && [metrics[key] containsObjectForKey:@"background_color"]) [obj setBackgroundColor:[UIColor colorWithHexString:metrics[key][@"background_color"]]];
        if ([obj respondsToSelector:@selector(setTextColor:)] && [metrics[key] containsObjectForKey:@"text_color"]) [obj setTextColor:[UIColor colorWithHexString:metrics[key][@"text_color"]]];
    }];
    if ([metrics containsObjectForKey:kNativeAssetMedia]) self.mediaView.frame = CGRectFromString(metrics[kNativeAssetMedia][kParsedPropertiesFrameKey]);
    else self.mediaView.frame = CGRectFromString(metrics[kNativeAssetMainImage][kParsedPropertiesFrameKey]);
}
@end

@interface ATAneNativeAd ()<ATNativeADDelegate>
@property(nonatomic, readonly) NSMutableDictionary<NSString*, UIView*> *viewsStorage;
@end


@implementation ATAneNativeAd

+(instancetype)sharedInstance {
    static ATAneNativeAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ATAneNativeAd alloc] init];
    });
    return sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self != nil){
      _viewsStorage = [NSMutableDictionary<NSString*, UIView*> dictionary];
    }
    return self;
}


DEFINE_ANE_FUNCTION(loadNativeAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"loadNativeAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSDictionary *dict = nil;
        if(argv[1] != nil){
            NSString *customString = [FREConversionUtil toString:argv[1]];
            dict = [FREUtils dictionaryWithJsonString:customString];
        }
        NSDictionary *extraDict = nil;
        if(argv[2] != nil){
            NSString *extraString = [FREConversionUtil toString:argv[2]];
            
            extraDict = [FREUtils dictionaryWithJsonString:extraString];
        }
        
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:extraDict customData:dict delegate:[ATAneNativeAd sharedInstance]];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    return result;
}

DEFINE_ANE_FUNCTION(showNativeAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"showNativeAd call!");
        
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        NSString *metricsJSONString = [FREConversionUtil toString:argv[1]];

        if ([[ATAdManager sharedManager] nativeAdReadyForPlacementID:placementId]) {
            NSDictionary *metrics = [NSJSONSerialization JSONObjectWithData:[metricsJSONString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *parsedMetrics = parseAneMetrics(metrics);

//            logEvent(context, kFatal, @"showNativeAd metrics:%@", parsedMetrics, __FUNCTION__);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:[ATAneNativeAd sharedInstance] action:@selector(noop) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectFromString(parseAneProperties(metrics[@"parent"])[kParsedPropertiesFrameKey]);
            [ATAneNativeAd sharedInstance]->_viewsStorage[placementId] = button;
            
            ATNativeADConfiguration *configuration = [ATNativeADConfiguration new];
            configuration.ADFrame = button.bounds;//CGRectFromString(parseUnityProperties(metrics[@"parent"])[kParsedPropertiesFrameKey]);
            configuration.renderingViewClass = [ATAneNativeAdView class];
            configuration.delegate = [ATAneNativeAd sharedInstance];
            configuration.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            ATAneNativeAdView *adview = [[ATAdManager sharedManager] retriveAdViewWithPlacementID:placementId configuration:configuration];
            if (adview != nil) {
                //        if (adview != nil) _viewsStorage[placementID] = adview;
                if ([adview respondsToSelector:@selector(configureMetrics:)]) {
                    [adview configureMetrics:parsedMetrics];
                    adview.backgroundColor = [UIColor whiteColor];
                } else {
                    [adview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[ATAneNativeAdView class]]) {
                            [(ATAneNativeAdView*)obj configureMetrics:parsedMetrics];
                            *stop = YES;
                        }
                    }];
                }
                [button addSubview:adview];
                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:button];
            }
            
        }
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
    

DEFINE_ANE_FUNCTION(removeNativeAd){
    FREObject result = NULL;
    
    @try {
        NSLog(@"removeNativeAd call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[ATAneNativeAd sharedInstance]->_viewsStorage[placementId] removeFromSuperview];
                [[ATAneNativeAd sharedInstance]->_viewsStorage removeObjectForKey:placementId];
            });
        });
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
    
    return result;
}
    
DEFINE_ANE_FUNCTION(isNativeAdReady){
    FREObject result = NULL;
        
    @try {
        NSLog(@"isNativeAdReady call!");
        NSString *placementId = [FREConversionUtil toString:argv[0]];
            BOOL isReady =[[ATAdManager sharedManager] nativeAdReadyForPlacementID:placementId];
            result = [FREConversionUtil fromBoolean:isReady];
    }
    @catch (NSException *exception) {
        logEvent(context, kFatal, @"Unable to create the return value. [Exception:(type:%@, method:%s)].", [exception name], __FUNCTION__);
        return createRuntimeException(@"ArgumentError", 0, @"Unable to create the return value on method '%s'.", __FUNCTION__);
    }
        
    return result;
}
    


//回调json内容：{"placement":"xxxx","error":"error msg", "isRewarded":boolean}
#pragma mark - loading delegate
-(void) didStartPlayingVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"UPADShowViewController:: didStartPlayingVideoInAdView:placementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeAdVideoStart" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didEndPlayingVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"UPADShowViewController:: didEndPlayingVideoInAdView:placementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeAdVideoEnd" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didClickNativeAdInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"UPADShowViewController:: didClickNativeAdInAdView:placementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeAdClick" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didShowNativeAdInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
    NSLog(@"UPADShowViewController:: didShowNativeAdInAdView:placementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeAdShow" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"UPADShowViewController:: didFinishLoadingADWithPlacementID:%@", placementID);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:placementID forKey:@"placement"];
    [ATAneSDK dispatchEvent:@"onNativeAdLoadSuccess" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"UPADShowViewController:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:placementID,@"placement",[NSString stringWithFormat:@"%@", error],@"error", nil];
    [ATAneSDK dispatchEvent:@"onNativeAdLoadFail" withMessage:[FREUtils jsonString_anythink:dict]];
}

-(void) didEnterFullScreenVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
}

-(void) didExitFullScreenVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra {
}

@end

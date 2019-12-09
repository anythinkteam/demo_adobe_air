//
//  UPArpuNativeBannerWrapper.m
//  UpArpuSDKDemo
//
//  Created by Martin Lau on 2019/4/10.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import "UPArpuNativeBannerWrapper.h"
#import <objc/runtime.h>
#import "MTAutoLayoutCategories.h"
@import UpArpuSDK;
@import UpArpuNative;


NSString *const kUPArpuNativeBannerAdShowingExtraBackgroundColorKey = @"bckground_color";
NSString *const kUPArpuNativeBannerAdShowingExtraAdSizeKey = @"ad_size";
NSString *const kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey = @"autorefresh_interval";
NSString *const kUPArpuNativeBannerAdShowingExtraHideCloseButtonFlagKey = @"hide_close_button_flag";
NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonBackgroundColorKey = @"cta_button_background_color";
NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonTitleFontKey = @"cta_button_title_font";
NSString *const kUPArpuNativeBannerAdShowingExtraCTAButtonTitleColorKey = @"cta_button_title_color";
NSString *const kUPArpuNativeBannerAdShowingExtraTitleFontKey = @"title_font";
NSString *const kUPArpuNativeBannerAdShowingExtraTitleColorKey = @"title_color";
NSString *const kUPArpuNativeBannerAdShowingExtraTextFontKey = @"text_font";
NSString *const kUPArpuNativeBannerAdShowingExtraTextColorKey = @"text_color";
NSString *const kUPArpuNativeBannerAdShowingExtraAdvertiserTextFontKey = @"sponsor_text_font";
NSString *const kUPArpuNativeBannerAdShowingExtraAdvertiserTextColorKey = @"spnosor_text_color";

@interface UPArpuNativeBannerWrapper(SemiInternal)
-(NSDictionary*)loadingExtraForPlacementID:(NSString*)placementID;
-(void) setNativeBannerView:(UPArpuNativeBannerView*)bannerView forPlacementID:(NSString*)placementID;
-(void) removeNativeBannerViewWithPlacementID:(NSString*)placementID;
-(void) setShowingExtra:(NSDictionary*)extra forPlacementID:(NSString*)placementID;
-(void) removeShowingExtraForPlacementID:(NSString*)placementID;
-(NSDictionary*)showingExtraForPlacementID:(NSString*)placementID;
@end

#pragma mark - rating view
@interface UPArpuStarRatingView:UIView
@property(nonatomic, readonly) UIImageView *star0;
@property(nonatomic, readonly) UIImageView *star1;
@property(nonatomic, readonly) UIImageView *star2;
@property(nonatomic, readonly) UIImageView *star3;
@property(nonatomic, readonly) UIImageView *star4;
@end
static CGFloat kStarDimension = 12.0f;
@implementation UPArpuStarRatingView
-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initSubviews];
        [self makeConstraintsForSubviews];
    }
    return self;
}

-(void) initSubviews {
    _star0 = [UIImageView autolayoutView];
    [self addSubview:_star0];
    
    _star1 = [UIImageView autolayoutView];
    [self addSubview:_star1];
    
    _star2 = [UIImageView autolayoutView];
    [self addSubview:_star2];
    
    _star3 = [UIImageView autolayoutView];
    [self addSubview:_star3];
    
    _star4 = [UIImageView autolayoutView];
    [self addSubview:_star4];
}

-(void) makeConstraintsForSubviews {
    [self addConstraintsWithVisualFormat:@"|[_star0(width)]-10-[_star1(width)]-10-[_star2(width)]-10-[_star3(width)]-10-[_star4(width)]" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:@{@"width":@(kStarDimension)} views:NSDictionaryOfVariableBindings(_star0, _star1, _star2, _star3, _star4)];
    [self addConstraintsWithVisualFormat:@"V:|[_star0(width)]|" options:0 metrics:@{@"width":@(kStarDimension)} views:NSDictionaryOfVariableBindings(_star0, _star1, _star2, _star3, _star4)];
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake(kStarDimension * 5.0f + 10.0f * 4.0f, kStarDimension);
}

+(void) configureStarView:(UPArpuStarRatingView*)starView star:(CGFloat)star {
    NSArray<UIImageView*>* stars = @[starView.star0, starView.star1, starView.star2, starView.star3, starView.star4];
    NSInteger consumedStar = 0;
    CGFloat remainStar = star;
    while (consumedStar < 5) {
        stars[consumedStar++].image = [UIImage imageNamed:remainStar >= 1.0f ? @"UpArpuSDK.bundle/native_banner_star_on" : remainStar > .0f ? @"UpArpuSDK.bundle/native_banner_semi_star" : @"UpArpuSDK.bundle/native_banner_star_off"];
        remainStar -= remainStar > 1.0f ? 1.0f : remainStar > .0f ? remainStar : .0f;
    }
}
@end

@interface UPArpuNativeBannerInternalNativeView:UPArpuNativeADView
@property(nonatomic, readonly) UPArpuStarRatingView *starRatingView;
@property(nonatomic, readonly) UILabel *advertiserLabel;
@property(nonatomic, readonly) UILabel *textLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *ctaLabel;
@property(nonatomic, readonly) UILabel *ratingLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;
@property(nonatomic, readonly) UIImageView *mainImageView;
@property(nonatomic, readonly) UIImageView *sponsorImageView;
@end
@implementation UPArpuNativeBannerInternalNativeView
-(void) initSubviews {
    [super initSubviews];
    _iconImageView = [UIImageView autolayoutView];
    _iconImageView.layer.cornerRadius = 4.0f;
    _iconImageView.layer.masksToBounds = YES;
    [self addSubview:_iconImageView];
    
    _titleLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:13.0f] textColor:[UIColor blackColor]];
    [self addSubview:_titleLabel];
    
    _textLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor blackColor]];
    [self addSubview:_textLabel];
    
    _starRatingView = [UPArpuStarRatingView autolayoutView];
    [self addSubview:_starRatingView];
    _starRatingView.hidden = YES;
    
    _ctaLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    _ctaLabel.backgroundColor = [UIColor colorWithRed:234.0f / 255.0f green:64.0f / 255.0f blue:72.0f / 255.0f alpha:1.0f];
    _ctaLabel.layer.masksToBounds = YES;
    [self addSubview:_ctaLabel];
    
    _advertiserLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:8.0f] textColor:[UIColor blackColor]];
    _advertiserLabel.text = @"Sponsored";
    [self addSubview:_advertiserLabel];
    
    _mainImageView = [UIImageView autolayoutView];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mainImageView];
}

-(NSArray<UIView*>*)clickableViews {
    NSMutableArray<UIView*> *clickableViews = [NSMutableArray<UIView*> arrayWithObjects:_iconImageView, _titleLabel, _textLabel, _ctaLabel, _advertiserLabel, _mainImageView, nil];
    if (self.mediaView != nil) { [clickableViews addObject:self.mediaView]; }
    return clickableViews;
}

-(void) makeConstraintsForSubviews {
    [super makeConstraintsForSubviews];
    UIView *hAnchoringView = self.nativeAd.mainImage != nil ? _mainImageView : _iconImageView;
    _iconImageView.hidden = self.nativeAd.mainImage != nil;
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(hAnchoringView, _iconImageView, _mainImageView, _titleLabel, _textLabel, _ctaLabel, _starRatingView, _advertiserLabel);
    [self addConstraintsWithVisualFormat:@"|[_mainImageView(width)]" options:0 metrics:@{@"width":@(CGRectGetHeight(self.bounds) * 8.0f / 5.0f)} views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:|[_mainImageView]|" options:0 metrics:nil views:viewsDict];
    [self addConstraintWithItem:_mainImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
    [self addConstraintsWithVisualFormat:@"|-15-[_iconImageView]" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:|-5-[_iconImageView]-5-|" options:0 metrics:nil views:viewsDict];
    [self addConstraintWithItem:_iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_iconImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:.0f];
    
    [self addConstraintsWithVisualFormat:@"[_titleLabel]->=5-[_ctaLabel(76)]-22-|" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:[_ctaLabel(28)]" options:0 metrics:nil views:viewsDict];
    [self addConstraintWithItem:_ctaLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
    _ctaLabel.layer.cornerRadius = 14.0f;
    _ctaLabel.hidden = [self.nativeAd.ctaText length] == 0;
    [self addConstraintsWithVisualFormat:@"[hAnchoringView]-15-[_textLabel]" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:|-10-[_titleLabel]" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:[NSString stringWithFormat:@"[_textLabel]-spacing-%@", [self.nativeAd.ctaText length] > 0 ? @"[_ctaLabel]" : @"|"] options:0 metrics:@{@"spacing":@([self.nativeAd.ctaText length] > 0 ? 5.0f : 22.0f)} views:viewsDict];
    [self addConstraintsWithVisualFormat:@"[_advertiserLabel]->=5-[_ctaLabel]" options:0 metrics:nil views:viewsDict];
    
    NSMutableArray<UIView*> *vViews = [NSMutableArray arrayWithObjects:_textLabel, nil];
    if ([self.nativeAd.advertiser length] > 0) { [vViews addObject:_advertiserLabel]; }
    __block UIView *anchoringView = _titleLabel;
    [vViews enumerateObjectsUsingBlock:^(UIView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addConstraintsWithVisualFormat:@"V:[anchoringView]-5-[obj]" options:NSLayoutFormatAlignAllLeading metrics:0 views:NSDictionaryOfVariableBindings(anchoringView, obj)];
        anchoringView = obj;
    }];
}

-(void) layoutMediaView {
    if (self.mediaView != nil && self.mainImageView != nil) {
        self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.mainImageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:.0f];
        [self addConstraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.mainImageView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
        [self addConstraintWithItem:self.mediaView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.mainImageView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:.0f];
        [self addConstraintWithItem:self.mediaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.mainImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:.0f];
    }
}

+(void) configureAdView:(UPArpuNativeBannerInternalNativeView*)adView withExtra:(NSDictionary*)extra {
    if ([extra isKindOfClass:[NSDictionary class]]) {
        if ([extra[kUPArpuNativeBannerAdShowingExtraCTAButtonBackgroundColorKey] isKindOfClass:[UIColor class]]) {
            adView.ctaLabel.backgroundColor = extra[kUPArpuNativeBannerAdShowingExtraCTAButtonBackgroundColorKey];
        }
        if ([extra[kUPArpuNativeBannerAdShowingExtraCTAButtonTitleColorKey] isKindOfClass:[UIColor class]]) {
            adView.ctaLabel.textColor = extra[kUPArpuNativeBannerAdShowingExtraCTAButtonTitleColorKey];
        }
        if ([extra[kUPArpuNativeBannerAdShowingExtraCTAButtonTitleFontKey] isKindOfClass:[UIFont class]]) {
            adView.ctaLabel.font = extra[kUPArpuNativeBannerAdShowingExtraCTAButtonTitleFontKey];
        }
        
        if ([extra[kUPArpuNativeBannerAdShowingExtraTitleFontKey] isKindOfClass:[UIFont class]]) {
            adView.titleLabel.font = extra[kUPArpuNativeBannerAdShowingExtraTitleFontKey];
        }
        if ([extra[kUPArpuNativeBannerAdShowingExtraTitleColorKey] isKindOfClass:[UIColor class]]) {
            adView.titleLabel.textColor = extra[kUPArpuNativeBannerAdShowingExtraTitleColorKey];
        }
        
        if ([extra[kUPArpuNativeBannerAdShowingExtraTextFontKey] isKindOfClass:[UIFont class]]) {
            adView.textLabel.font = extra[kUPArpuNativeBannerAdShowingExtraTextFontKey];
        }
        if ([extra[kUPArpuNativeBannerAdShowingExtraTextColorKey] isKindOfClass:[UIColor class]]) {
            adView.textLabel.textColor = extra[kUPArpuNativeBannerAdShowingExtraTextColorKey];
        }
        
        if ([extra[kUPArpuNativeBannerAdShowingExtraAdvertiserTextFontKey] isKindOfClass:[UIFont class]]) {
            adView.advertiserLabel.font = extra[kUPArpuNativeBannerAdShowingExtraAdvertiserTextFontKey];
        }
        if ([extra[kUPArpuNativeBannerAdShowingExtraAdvertiserTextColorKey] isKindOfClass:[UIColor class]]) {
            adView.advertiserLabel.textColor = extra[kUPArpuNativeBannerAdShowingExtraAdvertiserTextColorKey];
        }
    }
}
@end

@interface UPArpuNativeBannerView()<UPArpuNativeADDelegate>
@property(nonatomic, readonly) NSString *placementID;
@property(nonatomic) UPArpuNativeBannerInternalNativeView *internalNativeAdView;
@property(nonatomic) NSTimeInterval autoRefreshInterval;
@property(atomic) BOOL shouldNotifyShow;
@end
@implementation UPArpuNativeBannerView
-(NSString*)description {
    return [NSString stringWithFormat:@"UPArpuNativeBannerView:: placement_%@", _placementID];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) removeFromSuperview {
    [self cancelScheduledLoad];
    [[UPArpuNativeBannerWrapper sharedWrapper] removeNativeBannerViewWithPlacementID:_placementID];
    [super removeFromSuperview];
}

-(void) willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow != nil) {
        [[UPArpuNativeBannerWrapper sharedWrapper] setNativeBannerView:self forPlacementID:_placementID];
        if (self.superview != nil) {
            [self scheduleNextLoad];
        }
    } else {
        [[UPArpuNativeBannerWrapper sharedWrapper] removeNativeBannerViewWithPlacementID:_placementID];
        [self cancelScheduledLoad];
    }
}

-(void) handleApplicationDidBecomeActiveNotification:(NSNotification*)notification {
    NSLog(@"UPArpuNativeBannerView::handleApplicationDidBecomeActiveNotification:");
    [self scheduleNextLoad];
}

-(void) handleApplicationWillResignActiveNotification:(NSNotification*)notification {
    NSLog(@"UPArpuNativeBannerView::handleApplicationWillResignActiveNotification:");
    [self cancelScheduledLoad];
}

-(instancetype) initWithFrame:(CGRect)frame delegate:(id<UPArpuNativeBannerDelegate>)delegate placementID:(NSString*)placementID {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.clipsToBounds = YES;
        _delegate = delegate;
        _placementID = placementID;
        _shouldNotifyShow = YES;
        [self configureAccessoryViews];
        [self attachNewInternalNativeAdView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        NSDictionary *extra = [[UPArpuNativeBannerWrapper sharedWrapper] showingExtraForPlacementID:_placementID];
        if ([extra[kUPArpuNativeBannerAdShowingExtraBackgroundColorKey] isKindOfClass:[UIColor class]]) { self.backgroundColor = extra[kUPArpuNativeBannerAdShowingExtraBackgroundColorKey]; }
    }
    return self;
}

-(void) configureAccessoryViews {
    if (![[[UPArpuNativeBannerWrapper sharedWrapper] showingExtraForPlacementID:_placementID][kUPArpuNativeBannerAdShowingExtraHideCloseButtonFlagKey] boolValue]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        button.frame = CGRectMake(CGRectGetWidth(self.bounds) - 17.0f, 3.0f, 14.0f, 14.0f);
        [button setImage:[UIImage imageNamed:@"UpArpuSDK.bundle/native_banner_close"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, 24.0f, 11.0f)];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    label.text = @"AD";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:8];
    label.layer.cornerRadius = 2.0f;
    [self addSubview:label];
}

-(void) closeButtonTapped {
    if ([_delegate respondsToSelector:@selector(didClickCloseButtonInNativeBannerAdView:placementID:)]) { [_delegate didClickCloseButtonInNativeBannerAdView:self placementID:_placementID]; }
}

-(void) attachNewInternalNativeAdView {
    NSLog(@"UPArpuNativeBannerView::attachNewInternalNativeAdView");
    UPArpuNativeADConfiguration *config = [[UPArpuNativeADConfiguration alloc] init];
    config.ADFrame = self.bounds;
    config.delegate = self;
    config.renderingViewClass = [UPArpuNativeBannerInternalNativeView class];
    UPArpuNativeBannerInternalNativeView *nativeAdView = [[UPArpuAdManager sharedManager] retriveAdViewWithPlacementID:_placementID configuration:config];
    if (nativeAdView != nil) {
        NSLog(@"UPArpuNativeBannerView::native ad view retrieved, will attach");
        [UPArpuStarRatingView configureStarView:((UPArpuNativeBannerInternalNativeView*)[nativeAdView embededAdView]).starRatingView star:[nativeAdView.nativeAd.rating doubleValue]];
        [UPArpuNativeBannerInternalNativeView configureAdView:nativeAdView withExtra:[[UPArpuNativeBannerWrapper sharedWrapper] showingExtraForPlacementID:_placementID]];
        self.internalNativeAdView = nativeAdView;
    } else {
        NSLog(@"UPArpuNativeBannerView::failed to retrieve native ad view");
    }
}

-(void) setInternalNativeAdView:(UPArpuNativeBannerInternalNativeView *)internalNativeAdView {
    NSLog(@"UPArpuNativeBannerView::setInternalNativeAdView:%@, previous internal native ad view:%@", internalNativeAdView, _internalNativeAdView);
    dispatch_async(dispatch_get_main_queue(), ^{
        [_internalNativeAdView removeFromSuperview];
        _internalNativeAdView = internalNativeAdView;
        [self insertSubview:_internalNativeAdView atIndex:0];
        [self scheduleNextLoad];
    });
}

-(void) cancelScheduledLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"UPArpuNativeBannerView::cancelScheduledLoad");
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadNext) object:nil];
    });
}

-(void) scheduleNextLoad {
    if (_autoRefreshInterval > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"UPArpuNativeBannerView::scheduleNextLoad, will fire next in %lf seconds", _autoRefreshInterval);
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadNext) object:nil];
            [self performSelector:@selector(loadNext) withObject:nil afterDelay:_autoRefreshInterval];
        });
    }
}

-(void) loadNext {
    NSLog(@"UPArpuNativeBannerView::loadNext");
    [[UPArpuAdManager sharedManager] loadADWithPlacementID:_placementID extra:[[UPArpuNativeBannerWrapper sharedWrapper] loadingExtraForPlacementID:_placementID] customData:nil delegate:self];
}

#pragma mark - ad loading delegate
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"UPArpuNativeBannerView:: didFinishLoadingADWithPlacementID:%@", placementID);
    if (self.superview != nil) { [self attachNewInternalNativeAdView]; }
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"UPArpuNativeBannerView:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    if ([_delegate respondsToSelector:@selector(didFailToAutorefreshNativeBannerAdInView:placementID:error:)]) { [_delegate didFailToAutorefreshNativeBannerAdInView:self placementID:placementID error:error]; }
    [self scheduleNextLoad];
}

-(void) didStartPlayingVideoInAdView:(UPArpuNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"UPArpuNativeBannerView:: didStartPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didEndPlayingVideoInAdView:(UPArpuNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"UPArpuNativeBannerView:: didEndPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didClickNativeAdInAdView:(UPArpuNativeADView*)adView placementID:(NSString*)placementID {
    if ([_delegate respondsToSelector:@selector(didClickNativeBannerAdInView:placementID:)]) { [_delegate didClickNativeBannerAdInView:self placementID:placementID]; }
}

-(void) didShowNativeAdInAdView:(UPArpuNativeADView*)adView placementID:(NSString*)placementID {
    adView.mainImageView.image = adView.nativeAd.mainImage;
    if (self.shouldNotifyShow) {
        NSLog(@"should notify show");
        self.shouldNotifyShow = NO;
        if ([_delegate respondsToSelector:@selector(didShowNativeBannerAdInView:placementID:)]) { [_delegate didShowNativeBannerAdInView:self placementID:placementID]; }
    } else {
        NSLog(@"should notify refresh");
        if ([_delegate respondsToSelector:@selector(didAutorefreshNativeBannerAdInView:placementID:)]) { [_delegate didAutorefreshNativeBannerAdInView:self placementID:placementID]; }
    }
}
@end

@interface UPArpuNativeBannerWrapper()<UPArpuAdLoadingDelegate>
@property(nonatomic, readonly) NSMutableDictionary *delegates;
@property(nonatomic, readonly) dispatch_queue_t delegates_accessing_queue;
@property(nonatomic, readonly) NSMutableDictionary *banners;
@property(nonatomic, readonly) dispatch_queue_t banners_accessing_queue;
@property(nonatomic, readonly) NSMutableDictionary *loadingExtras;
@property(nonatomic, readonly) dispatch_queue_t loadingExtras_accessing_control_queue;
@property(nonatomic, readonly) NSMutableDictionary *showingExtras;
@property(nonatomic, readonly) dispatch_queue_t showing_extra_accessing_control_queue;
@end
@implementation UPArpuNativeBannerWrapper
+(instancetype) sharedWrapper {
    static UPArpuNativeBannerWrapper *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[UPArpuNativeBannerWrapper alloc] init];
    });
    return sharedManager;
}

-(instancetype) init {
    self = [super init];
    if (self != nil) {
        _delegates = [NSMutableDictionary new];
        _delegates_accessing_queue = dispatch_queue_create("com.uparpu.delegateAccessingControlQueue", DISPATCH_QUEUE_CONCURRENT);
        
        _banners = [NSMutableDictionary new];
        _banners_accessing_queue = dispatch_queue_create("com.uparpu.bannersAccessingControlQueue", DISPATCH_QUEUE_CONCURRENT);;
        
        _loadingExtras = [NSMutableDictionary dictionary];
        _loadingExtras_accessing_control_queue = dispatch_queue_create("com.uparpu.NativeBannerLoadingExtra", DISPATCH_QUEUE_CONCURRENT);
        
        _showingExtras = [NSMutableDictionary dictionary];
        _showing_extra_accessing_control_queue = dispatch_queue_create("com.uparpu.NativeBannerShowingExtra", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

-(void) setShowingExtra:(NSDictionary*)extra forPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_showing_extra_accessing_control_queue, ^{
        [_showingExtras removeObjectForKey:placementID];
        if ([extra count] > 0) { _showingExtras[placementID] = extra; }
    });
    
}

-(void) removeShowingExtraForPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_showing_extra_accessing_control_queue, ^{
        [_showingExtras removeObjectForKey:placementID];
    });
}

-(NSDictionary*)showingExtraForPlacementID:(NSString*)placementID {
    __block NSDictionary *extra = nil;
    dispatch_sync(_showing_extra_accessing_control_queue, ^{
        extra = _showingExtras[placementID];
    });
    return extra;
}

-(void) removeNativeBannerViewWithPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_banners_accessing_queue, ^{
        [_banners removeObjectForKey:placementID];
    });
}

-(void) setNativeBannerView:(UPArpuNativeBannerView*)bannerView forPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_banners_accessing_queue, ^{
        _banners[placementID] = bannerView;
    });
}

-(UPArpuNativeBannerView*)nativeBannerViewForPlacementID:(NSString*)placementID {
    __block UPArpuNativeBannerView *bannerView = nil;
    dispatch_sync(_banners_accessing_queue, ^{
        bannerView = _banners[placementID];
    });
    return bannerView;
}

-(void) setDelegate:(id<UPArpuNativeBannerDelegate>)delegate forPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_delegates_accessing_queue, ^{
        _delegates[placementID] = delegate;
    });
}

-(void) removeDelegateForPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_delegates_accessing_queue, ^{
        [_delegates removeObjectForKey:placementID];
    });
}

-(id<UPArpuNativeBannerDelegate>)delegateForPlacementID:(NSString*)placementID {
    __block id<UPArpuNativeBannerDelegate> delegate = nil;
    dispatch_sync(_delegates_accessing_queue, ^{
        delegate = _delegates[placementID];
    });
    return delegate;
}

-(void) setLoadingExtra:(NSDictionary*)extra forPlacementID:(NSString*)placementID {
    dispatch_barrier_async(_loadingExtras_accessing_control_queue, ^{
        _loadingExtras[placementID] = extra;
    });
}

-(NSDictionary*)loadingExtraForPlacementID:(NSString*)placementID {
    __block NSDictionary *extra = nil;
    dispatch_sync(_loadingExtras_accessing_control_queue, ^{
        extra = _loadingExtras[placementID];
    });
    return extra;
}

+(void) loadNativeBannerAdWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<UPArpuNativeBannerDelegate>)delegate {
    NSLog(@"UPArpuNativeBannerWrapper::loadNativeBannerAdWithPlacementID:%@ extra:%@ customData:%@ delegate:", placementID, extra, customData);
    NSMutableDictionary *localExtra = [NSMutableDictionary dictionaryWithDictionary:@{kExtraInfoNativeAdTypeKey:@(UPArpuGDTNativeAdTypeSelfRendering), kUPArpuExtraNativeImageSizeKey:kUPArpuExtraNativeImageSize690_388}];
    if ([extra isKindOfClass:[NSDictionary class]] && [extra count] > 0) { [localExtra addEntriesFromDictionary:extra]; }
    [[UPArpuNativeBannerWrapper sharedWrapper] setLoadingExtra:localExtra forPlacementID:placementID];
    [[UPArpuNativeBannerWrapper sharedWrapper] setDelegate:delegate forPlacementID:placementID];
    [[[UPArpuNativeBannerWrapper sharedWrapper] nativeBannerViewForPlacementID:placementID] cancelScheduledLoad];
    [[UPArpuAdManager sharedManager] loadADWithPlacementID:placementID extra:localExtra customData:customData delegate:[UPArpuNativeBannerWrapper sharedWrapper]];
}

+(UPArpuNativeBannerView*) retrieveNativeBannerAdViewWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra delegate:(id<UPArpuNativeBannerDelegate>)delegate {
    NSLog(@"UPArpuNativeBannerWrapper::retrieveNativeBannerAdViewWithPlacementID:%@ extra:%@ delegate:", placementID, extra);
    if ([self nativeBannerAdReadyForPlacementID:placementID]) {
        NSMutableDictionary *extraToBeSaved = [NSMutableDictionary dictionaryWithDictionary:extra];
        if (extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey] == nil) {
            NSDictionary *placementConfig = [[UPArpuAdManager sharedManager] autoRefreshConfigurationForPlacementID:placementID];
            if ([placementConfig[kNativeAdAutorefreshConfigurationSwitchKey] boolValue] && [placementConfig[kNativeAdAutorefreshConfigurationRefreshIntervalKey] doubleValue] > 0) {
                extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey] = placementConfig[kNativeAdAutorefreshConfigurationRefreshIntervalKey];
            }
        }
        [[UPArpuNativeBannerWrapper sharedWrapper] setShowingExtra:extraToBeSaved forPlacementID:placementID];
        NSLog(@"Native banner ad ready, will be shown");
        CGSize size = extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAdSizeKey] != nil ? [extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAdSizeKey] CGSizeValue] : CGSizeMake(320.0f, 80.0f);
        UPArpuNativeBannerView *bannerView = [[UPArpuNativeBannerView alloc] initWithFrame:CGRectMake(.0f, .0f, size.width, size.height) delegate:delegate placementID:placementID];
        if ([extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey] respondsToSelector:@selector(doubleValue)] && [extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey] doubleValue] > 0) {
            bannerView.autoRefreshInterval = [extraToBeSaved[kUPArpuNativeBannerAdShowingExtraAutorefreshIntervalKey] doubleValue];
        }
        [[UPArpuNativeBannerWrapper sharedWrapper].banners setObject:bannerView forKey:placementID];
        return bannerView;
    } else {
        NSLog(@"Native banner not ready");
        return nil;
    }
}

+(BOOL) nativeBannerAdReadyForPlacementID:(NSString*)placementID {
    return [[UPArpuAdManager sharedManager] nativeAdReadyForPlacementID:placementID];
}

#pragma mark - native delegate(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"UPArpuNativeBannerWrapper:: didFinishLoadingADWithPlacementID:%@", placementID);
    UPArpuNativeBannerView *bannerView = [self nativeBannerViewForPlacementID:placementID];
    bannerView.shouldNotifyShow = YES;
    [bannerView attachNewInternalNativeAdView];
    
    id<UPArpuNativeBannerDelegate> delegate = [self delegateForPlacementID:placementID];
    if ([delegate respondsToSelector:@selector(didFinishLoadingNativeBannerAdWithPlacementID:)]) { [delegate didFinishLoadingNativeBannerAdWithPlacementID:placementID]; }
    [self removeDelegateForPlacementID:placementID];
    
}

-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"UPArpuNativeBannerWrapper:: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    id<UPArpuNativeBannerDelegate> delegate = [self delegateForPlacementID:placementID];
    if ([delegate respondsToSelector:@selector(didFailToLoadNativeBannerAdWithPlacementID:error:)]) { [delegate didFailToLoadNativeBannerAdWithPlacementID:placementID error:error]; }
    [self removeDelegateForPlacementID:placementID];
}
@end

# UPARPU SDK Adobe Air Native Extension集成说明
[1 SDK说明](#1)</br>
[2 ANE集成引用配置](#2)</br>
[3 SDK初始化及GDPR调用说明](#3)</br>
[4 激励视频广告调用说明](#4)</br>
[5 插屏广告调用说明](#5)</br>
[6 banner调用说明](#6)</br>
[7 原生广告调用说明](#7)</br>
[8 原生拼banner广告调用说明](#8)</br>
[9 network配置说明](#9)</br>
[10 版本更新记录说明](#10)</br>


<h2 id='1'>1 SDK说明 </h2>
UpArpu ANE版本SDK是基于UpArpu的Android及iOS版本做Adobe Air做二次封装的版本，方便基于Adobe Air开发的开发者集成使用，支持的广告形式包括激励视频广告、插屏广告、banner广告、原生广告、原生拼banner广告。

<h2 id='2'>2 ANE集成引用配置 </h2>

###2.1 ANE文件说明

| ANE文件 | 说明 | 是否必须|
| --- | --- |---|
| uparpu_sdk.ane| UpArpu基础库，包含支持广告形式|Y|
|uparpu\_sdk\_adapter\_*.ane|不同network需要依赖的adapter及network sdk|N|


###2.2 Android集成依赖的ANE文件说明

除了UpArpu基础SDK库及需要的network adapter库之外，需要的其他库及配置如下：

| 额外库包| 依赖的network|
| ---| ---| 
|uparpu\_sdk\_plugin\_support-v4.ane | 所有network必须引入|
|uparpu\_sdk\_plugin\_android-query-full.ane|Tiktok|
|uparpu\_sdk\_plugin\_constraint-layout.ane|Nend|
|uparpu\_sdk\_plugin\_converter-gson.ane|Admob,Vungle|
|uparpu\_sdk\_plugin\_fetch.ane|Vungle|
|uparpu\_sdk\_plugin\_gson.ane|Admob,Vungle|
|uparpu\_sdk\_plugin\_liulishuo.ane|Oneway|
|uparpu\_sdk\_plugin\_logging-interceptor.ane|Vungle|
|uparpu\_sdk\_plugin\_okhttp.ane|inmobi,Vungle,Oneway |
|uparpu\_sdk\_plugin\_okio.ane|inmobi,Vungle|
|uparpu\_sdk\_plugin\_picasso.ane|inmobi|
|uparpu\_sdk\_plugin\_recycleview.ane|Facebook，inmobi|
|uparpu\_sdk\_plugin\_retrofit.ane|Vungle|
|uparpu\_sdk\_plugin\_VNG-moat-mobile-app-kit.ane|Vungle|
|uparpu\_sdk\_adapter\_admob.ane(由于这个admob的ane，部分network得依赖admob的ane)|Tapjoy,Nend,Maio |


###2.3 iOS集成依赖的ANE文件说明

主要是UpArpu基础SDK库及需要的network adapter库。


<h2 id='3'>3 SDK初始化及GDPR调用说明 </h2>

### 3.1 API说明

路径：com.uparpu.sdk
类名：UpArpuAirSDK

| API | 参数说明 | 功能说明|
| --- | --- |---|
| initSDK| appId:String, appKey:String|SDK初始化接口，建议在应用启动时调用|
|setDebugLog|status:int |是否显示debug日志，值说明：1(开启)，0(关闭)|
|setGDPRLevel|level:int |面向欧盟地区，设置GDPR隐私等级，值说明：0(完全个性化)，1(不收集设备信息,无个性化),2(禁止使用)|

SDK使用其他广告形式前，需要调用initSDK方法；涉及欧盟地区或者相关用户隐私协议控制，可通过setGDPRLevel控制数据上报权限；通过setDebugLog方法，可以开启调试日志，方便定位SDK集成中遇到的问题；

### 3.2 调用示例

```
UpArpuAirSDK.getInstance().setDebugLog(1);
UpArpuAirSDK.getInstance().initSDK("appid", "appkey");
				
```

<h2 id='4'>4 激励视频广告调用说明 </h2>

### 4.1 API说明

路径：com.uparpu.sdk.rewardedvideo
类名：UpArpuRewardedVideoAd

| API | 参数说明 | 功能说明|
| --- | --- |---|
| loadRewardedVideoAd| unitId:String, userId:String, customObject:Object|用于load激励视频广告，unitId为广告位id；userId为启动激励用到的用户id，可为空；customObject为UpArpu后台配置的相关筛选条件|
|showRewardedVideoAd|unitId:String|展示指定广告位的激励视频广告|
|isRewardedVideoReady|unitId:String|判断指定广告位的广告是否加载完成|
|setAdListener|listener:UpArpuRewardedVideoListener|设置回调对象|

### 4.2 Listener回调方法说明

路径：com.uparpu.sdk.rewardedvideo
接口名：UpArpuRewardedVideoListener

| API | 参数说明 | 功能说明|
| --- | --- |---|
|onRewardedVideoLoaded| unitId:String|广告加载完成|
|onRewardedVideoLoadFail|unitId:String, errorMsg:String|广告加载失败，errorMsg为加载失败的原因|
|onRewardedVideoCLick|unitId:String|激励视频产生点击|
|onRewardedVideoStart|unitId:String|视频播放开始|
|onRewardedVideoEnd|unitId:String|视频播放结束|
|onRewardedVideoPlayFail|unitId:String, errorMsg:String|视频播放失败，errorMsg为加载失败的原因|
|onRewardedVideoClose|unitId:String, isReward:Boolean|视频关闭，isReward为是否产生激励|

### 4.3 调用示例

1、加载广告

```
UpArpuRewardedVideoAd.setAdListener(rewardedVideoListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";		
UpArpuRewardedVideoAd.loadRewardedVideoAd("unitid", "", customObj);
```

2、展示广告

```
if(UpArpuRewardedVideoAd.isRewardedVideoReady("unitid"))
{
	UpArpuRewardedVideoAd.showRewardedVideoAd("unitid");
}else{
	trace("!isRewardedVideoReady");
}
```

<h2 id='5'>5 插屏广告调用说明 </h2>

### 5.1 API说明

路径：com.uparpu.sdk.interstitial
类名：UpArpuInterstitialAd

| API | 参数说明 | 功能说明|
| --- | --- |---|
| loadInterstitialAd| unitId:String, customObject:Object|用于load插屏广告，unitId为广告位id；customObject为UpArpu后台配置的相关筛选条件|
|showInterstitialAd|unitId:String|展示指定广告位的插屏广告|
|isInsterstitialAdReady|unitId:String|判断指定广告位的广告是否加载完成|
|setAdListener|listener:UpArpuInterstitialListener|设置回调对象|

### 5.2 Listener回调方法说明

路径：com.uparpu.sdk.interstitial
接口：UpArpuInterstitialListener

| API | 参数说明 | 功能说明|
| --- | --- |---|
|onInterstitialLoaded| unitId:String|广告加载完成|
|onInterstitialLoadFail|unitId:String, errorMsg:String|广告加载失败，errorMsg为加载失败的原因|
|onInterstitialCLick|unitId:String|广告产生点击|
|onInterstitialShow|unitId:String|广告展示|
|onInterstitialClose|unitId:String|广告关闭|


### 5.3 调用示例

1、加载广告

```
UpArpuInterstitialAd.setAdListener(intertistialListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";	
UpArpuInterstitialAd.loadInterstitialAd(“unitid”, customObj)			
```

2、展示广告

```
if(UpArpuInterstitialAd.isInsterstitialAdReady("unitid"))
{
	UpArpuInterstitialAd.showInterstitialAd("unitid");
					
}else{
	trace("!isInsterstitialAdReady");
}
```


<h2 id='6'>6 banner调用说明 </h2>

目前仅支持分辨率:320*50

### 6.1 API说明

路径：com.uparpu.sdk.banner
类名：UpArpuBannerAd

| API | 参数说明 | 功能说明|
| --- | --- |---|
| loadBannerAd| unitId:String, customObject:Object|用于加载banner广告，unitId为广告位id；customObject为UpArpu后台配置的相关筛选条件|
|showBannerAd|unitId:String, rect:Rectangle|展示指定广告位的banner广告，rect为指定banner展示的x坐标、y坐标、宽、高|
|removeBannerAd|unitId:String|移除banner广告|
|isBannerAdReady|unitId:String|判断指定广告位的广告是否加载完成|
|setAdListener|listener:UpArpuBannerListener|设置回调对象|

### 6.2 Listener回调方法说明

路径：com.uparpu.sdk.banner
接口：UpArpuBannerListener

| API | 参数说明 | 功能说明|
| --- | --- |---|
|onBannerLoadSuccess| unitId:String|广告加载完成|
|onBannerLoadFail|unitId:String, errorMsg:String|广告加载失败，errorMsg为加载失败的原因|
|onBannerClick|unitId:String|广告产生点击|
|onBannerShow|unitId:String|广告展示|
|onBannerClose|unitId:String|广告关闭|
|onBannerAutoRefresh|unitId:String|广告自动刷新|
|onBannerAutoRefreshFail|unitId:String, errorMsg:String|广告自动刷新失败，errorMsg为失败的原因|


### 6.3 调用示例

1、加载banner广告

```

UpArpuBannerAd.setBannerListener(bannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";	
UpArpuBannerAd.loadBannerAd(“unitid”, customObj)
				
```

2、展示banner广告

```
if(UpArpuBannerAd.isBannerAdReady("unitid")){
	var rectangle:Rectangle = new Rectangle();
	rectangle.x = 0;
	rectangle.y = this.screen.height - this.screen.height * 50/800;
	rectangle.width = this.screen.width * 320/480;
	rectangle.height = this.screen.height * 50/800;
	UpArpuBannerAd.showBannerAd("unitid", rectangle);
}else{
	trace("!isBannerAdReady");
}				
```

3、移除banner广告

```
UpArpuBannerAd.removeBannerAd("unitid");
```

<h2 id='7'>7 原生广告调用说明 </h2>

### 7.1 API说明

路径：com.uparpu.sdk.nativead
类名：UpArpuNativeAd

| API | 参数说明 | 功能说明|
| --- | --- |---|
| loadNativeAd| unitId:String, customObject:Object, extraObject:Object|用于加载banner广告，unitId为广告位id；customObject为UpArpu后台配置的相关筛选条件；extraObject为iOS版本需要支持广点通和穿山甲广告的参数，具体见示例说明|
|showNativeAd|unitId:String, nativeAdConfig:UpArpuNativeAdConfig|展示指定广告位的banner广告，nativeAdConfig为指定素材的位置、背景颜色及文字大小|
|removeNativeAd|unitId:String|移除原生广告|
|isNativeAdReady|unitId:String|判断指定广告位的广告是否加载完成|
|setAdListener|listener:UpArpuNativeListener|设置回调对象|

extra参数说明：
针对iOS版本的参数

| 参数名 | 参数说明 | 备注|
| --- | --- |---|
| native\_ad\_type| 参数数字，1:广点通的模板类广告;2:广点通支持自渲染广告|针对广点通的广告位配置|
| native\_image\_size| 参数字符串，"image\_size\_228\_150"、"image\_size\_690\_388"|针对穿山甲广告的不同图片分辨率|


### 7.2 Listener回调方法说明

路径：com.uparpu.sdk.nativead
接口：UpArpuNativeListener

| API | 参数说明 | 功能说明|
| --- | --- |---|
|onNativeAdLoadSuccess| unitId:String|广告加载完成|
|onNativeAdLoadFail|unitId:String, errorMsg:String|广告加载失败，errorMsg为加载失败的原因|
|onNativeAdClick|unitId:String|广告产生点击|
|onNativeAdShow|unitId:String|广告展示|
|onNativeAdVideoStart|unitId:String|原生视频播放开始，不同network可能支持不一样|
|onNativeAdVideoEnd|unitId:String|原生视频播放结束，不同network可能支持不一样|

### 7.3 元素配置说明

路径：com.uparpu.sdk.nativead
类名：UpArpuNativeAdConfig

| 配置项说明 | 类型| 功能说明|
| --- | --- |---|
|parentRect| UpArpuNativeItemProperty|父容器属性|
|iconRect| UpArpuNativeItemProperty |icon属性|
|mainImageRect|UpArpuNativeItemProperty|大图属性|
|titleRect|UpArpuNativeItemProperty|标题属性|
|descRect|UpArpuNativeItemProperty|描述文字属性|
|adLogoRect|UpArpuNativeItemProperty|广告logo属性|
|ctaRect|UpArpuNativeItemProperty|cta按钮属性|

类名：UpArpuNativeItemProperty

```
public var rect:Rectangle; //容器的位置和宽高
public var backgroundColor:String; //容器背景颜色
public var textColor:String; //文字颜色
public var textSize:int; //文字大小
```

### 7.4 调用示例

1、加载原生广告

```

UpArpuNativeAd.setNativeListener(nativeListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";
var extraObj:Object = {};
//针对iOS广点通广告配置
extraObj["native_ad_type"] = 2;
//针对iOS穿山甲广告配置
extraObj["native_image_size"] = "image_size_228_150";
				
UpArpuNativeAd.loadNativeAd("unitid", customObj, extraObj);
				
```

2、展示原生广告

```
//配置示例，需要根据实际展示做调整
public function getNativeAdConfig():UpArpuNativeAdConfig
			{
				var nativeAdConfig:UpArpuNativeAdConfig = new UpArpuNativeAdConfig();
				var parentRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //父容器属性
				parentRect.rect = new Rectangle();
				parentRect.rect.x = 0;
				parentRect.rect.y = this.screen.height - this.screen.height * 200/800;
				parentRect.rect.width = this.screen.width * 320/480;
				parentRect.rect.height = this.screen.height * 200/800;
				parentRect.backgroundColor = "#ffffff";
				parentRect.textColor = "#777777";
				parentRect.textSize = 10;
				var iconRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //icon属性
				iconRect.rect = new Rectangle();
				iconRect.rect.x = 0;
				iconRect.rect.y = this.screen.height * 50/800;
				iconRect.rect.width = this.screen.width * 60/480;
				iconRect.rect.height = this.screen.height *50/800;
				iconRect.backgroundColor = "#ffffff";
				iconRect.textColor = "#777777";
				iconRect.textSize = this.screen.width * 10/480;
				var mainImageRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //大图属性
				mainImageRect.rect = new Rectangle();
				mainImageRect.rect.x = this.screen.width * 60/480;
				mainImageRect.rect.y = this.screen.height *10/800;
				mainImageRect.rect.width = this.screen.width * 240/480;
				mainImageRect.rect.height = this.screen.height *120/800;
				mainImageRect.backgroundColor = "#ffffff";
				mainImageRect.textColor = "#777777";
				mainImageRect.textSize = this.screen.width * 10/480;
				var titleRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //标题属性
				titleRect.rect = new Rectangle();
				titleRect.rect.x = 0;
				titleRect.rect.y = this.screen.height *100/800;
				titleRect.rect.width = this.screen.width *50/480;
				titleRect.rect.height = this.screen.height *50/800;
				titleRect.backgroundColor = "#ffffff";
				titleRect.textColor = "#777777";
				titleRect.textSize = this.screen.width *12/480;
				var descRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //描述文字属性
				descRect.rect = new Rectangle();
				descRect.rect.x = this.screen.width *60/480;
				descRect.rect.y =  this.screen.height *140/800;
				descRect.rect.width = this.screen.width *240/480;
				descRect.rect.height =  this.screen.height *30/800;
				descRect.backgroundColor = "#ffffff";
				descRect.textColor = "#777777";
				descRect.textSize = this.screen.width *10/480;
				var adLogoRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //广告logo属性
				adLogoRect.rect = new Rectangle();
				adLogoRect.rect.x = 0;
				adLogoRect.rect.y = 0;
				adLogoRect.rect.width = this.screen.width *30/480;
				adLogoRect.rect.height = this.screen.height *20/800;
				adLogoRect.backgroundColor = "#ffffff";
				adLogoRect.textColor = "#777777";
				adLogoRect.textSize = this.screen.width *10/480;
				var ctaRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //点击按钮属性
				ctaRect.rect = new Rectangle();
				ctaRect.rect.x = this.screen.width *60/480;
				ctaRect.rect.y = this.screen.height *170/800;
				ctaRect.rect.width = this.screen.width *300/480;
				ctaRect.rect.height = this.screen.height *30/800;
				ctaRect.backgroundColor = "#297ff9";
				ctaRect.textColor = "#ffffffff";
				ctaRect.textSize = this.screen.width *17/480;
				
				nativeAdConfig.parentRect = parentRect;
				nativeAdConfig.iconRect = iconRect;
				nativeAdConfig.mainImageRect = mainImageRect;
				nativeAdConfig.titleRect = titleRect;
				nativeAdConfig.descRect = descRect;
				nativeAdConfig.adLogoRect = adLogoRect;
				nativeAdConfig.ctaRect = ctaRect;
				return nativeAdConfig;
			}
			
public function show_native_clickHandler():void
{
	trace("show_native_clickHandler");
	if(UpArpuNativeAd.isNativeAdReady("unitid"))
	{
		var nativeAdConfig:UpArpuNativeAdConfig = getNativeAdConfig();
		UpArpuNativeAd.showNativeAd("unitid", nativeAdConfig);
	}else{
		trace("!isNativeAdReady");
	}
}
							
```

3、移除原生广告

```
UpArpuNativeAd.removeNativeAd("unitid");
```

<h2 id='8'>8 原生拼banner广告调用说明 </h2>

此广告形式为基于原生拼接的banner广告，使用的是uparpu及network的原生广告位；
Android支持的分辨率(配置指定传入宽高参数)：auto、320\*50、640\*100；
iOS支持的分辨率(配置指定传入宽高参数)：auto。

### 8.1 API说明

路径：com.uparpu.sdk.nativebanner
类名：UpArpuNativeBannerAd

| API | 参数说明 | 功能说明|
| --- | --- |---|
| loadNativeBannerAd|unitId:String, customObject:Object|用于加载广告，unitId为原生广告位id；customObject为UpArpu后台配置的相关筛选条件|
|showNativeBannerAd|unitId:String, rect:Rectangle, adConfig:UpArpuNativeBannerAdConfig|展示指定广告位的广告，rect为指定banner展示的x坐标、y坐标、宽、高，adConfig为配置相关的属性|
|removeNativeBannerAd|unitId:String|移除banner广告|
|isNativeBannerAdReady|unitId:String|判断指定广告位的广告是否加载完成|
|setNativeBannerListener|listener:UpArpuNativeBannerListener|设置回调对象|

UpArpuNativeBannerAdConfig配置项说明(不传可使用默认配置)：

```
public var bgColor:String; //容器背景颜色
public var showCloseButton:Boolean; //是否展示关闭按钮
public var ctaBgColor:String; //cta背景颜色
public var ctaTitleSize:int; //cta标题大小(仅iOS)
public var ctaTitleColor:String; //cta标题颜色
public var adTitleSize:int; //标题字体大小(仅iOS)
public var adTitleColor:String; //标题字体颜色
public var adDescSize:int //详细文字字体大小(仅iOS)
public var adDescColor:String;//详细文字颜色
public var autoRefreshTime:int;//自动刷新时间, 单位:ms
public var adBannerSize:int; //0:Auto 1:320x50 2:640x150(仅Android)
public var showCtaButton:Boolean; //是否展示CTA按钮(仅Android)

```

### 8.2 Listener回调方法说明

路径：com.uparpu.sdk.nativebanner
接口：UpArpuNativeBannerListener

| API | 参数说明 | 功能说明|
| --- | --- |---|
|onNativeBannerLoadSuccess| unitId:String|广告加载完成|
|onNativeBannerLoadFail|unitId:String, errorMsg:String|广告加载失败，errorMsg为加载失败的原因|
|onNativeBannerClick|unitId:String|广告产生点击|
|onNativeBannerShow|unitId:String|广告展示|
|onNativeBannerClose|unitId:String|广告关闭|
|onNativeBannerAutoRefresh|unitId:String|广告自动刷新|
|onNativeBannerAutoRefreshFail|unitId:String, errorMsg:String|广告自动刷新失败，errorMsg为失败的原因|


### 8.3 调用示例

1、加载广告

```

UpArpuNativeBannerAd.setNativeBannerListener(nativebannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";		
UpArpuNativeBannerAd.loadNativeBannerAd("unitid", customObj);
				
```

2、展示native拼banner广告

```
if(UpArpuNativeBannerAd.isNativeBannerAdReady("unitid"))
{
	var rectangle:Rectangle = new Rectangle();
	rectangle.x = 0;
	rectangle.y = this.screen.height - 80;
	rectangle.width = this.screen.width;
	rectangle.height = 80;
					
	var nativeBannerAdConfig:UpArpuNativeBannerAdConfig = new UpArpuNativeBannerAdConfig();
	nativeBannerAdConfig.bgColor = "#ff0000";
	nativeBannerAdConfig.showCloseButton = true;
	nativeBannerAdConfig.ctaTitleSize = 11;
	nativeBannerAdConfig.ctaBgColor = "#ffffff";
	nativeBannerAdConfig.ctaTitleColor = "#000000";
	nativeBannerAdConfig.autoRefreshTime = 10000;
	nativeBannerAdConfig.adTitleColor = "#ffffff";
	nativeBannerAdConfig.adTitleSize = 12;
	nativeBannerAdConfig.adDescColor = "#ffffff";
	nativeBannerAdConfig.adDescSize = 10;
	nativeBannerAdConfig. showCtaButton = true;
					
	UpArpuNativeBannerAd.showNativeBannerAd("unitid", rectangle, nativeBannerAdConfig);
}else{
	trace("!isNativeBannerAdReady");
}			
```

3、移除native拼banner广告

```
UpArpuNativeBannerAd.removeNativeBannerAd("unitid");
```

<h2 id='9'>9 network配置说明 </h2>

### 基础配置
##### Android
在**-app.xml文件里，<manifestAdditions> 标签下配置：

```java
<manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
			 <uses-sdk
	 			android:minSdkVersion="14"
        		android:targetSdkVersion="28"/>
    			<uses-permission android:name="android.permission.INTERNET" />
    			<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    			<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    			<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    			<!--这里增加第三方需要的权限-->
			    <application android:usesCleartextTraffic="true">
			    <uses-library android:name="org.apache.http.legacy" android:required="false"/>
			    <activity
            		android:name="com.uparpu.activity.UpArpuGdprAuthActivity"
            		android:configChanges="orientation|keyboardHidden|screenSize"
            		android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
            		
            		<!--这里增加第三方需要的组件-->
			    </application>
			</manifest>
			
		]]></manifestAdditions>
```

### 9.1 Facebook
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--组件配置-->    
<activity
            android:name="com.facebook.ads.AudienceNetworkActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:exported="false"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />
<activity
            android:name="com.facebook.ads.internal.ipc.RemoteANActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:exported="false"
            android:process=":adnw"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

<service
            android:name="com.facebook.ads.internal.ipc.AdsProcessPriorityService"
            android:exported="false" />
<service
            android:name="com.facebook.ads.internal.ipc.AdsMessengerService"
            android:exported="false"
            android:process=":adnw" />    

```

### 9.2 Admob
#####iOS
使用Admob最新版本，需要在plist添加配置，如下：

```java
<key>GADApplicationIdentifier</key>
            <string>ca-app-pub-9488501426181082/7319780494</string>
            
            <key>GADIsAdManagerApp</key>
            <true/>
            
```

#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--组件配置-->    
<activity
            android:name="com.google.android.gms.ads.AdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:exported="false"
            android:theme="@android:style/Theme.Translucent" />
            
<meta-data
            android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" />
            
<meta-data
            android:name="com.google.android.gms.ads.AD_MANAGER_APP"
            android:value="true"/>   

```

### 9.3 Inmobi

#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--组件配置-->    
<activity
            android:name="com.inmobi.rendering.InMobiAdActivity"
            android:configChanges="keyboardHidden|orientation|keyboard|smallestScreenSize|screenSize|screenLayout"
            android:hardwareAccelerated="true"
            android:resizeableActivity="false"
            android:theme="@android:style/Theme.NoTitleBar" />
  

```


### 9.4 Flurry
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
 <!-- Required permissions - Internet access -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <!-- Highly Recommended permission - External memory pre-caching -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <!-- Optional permission - Location based ad targeting -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<!--组件配置-->    
<activity
            android:name="com.flurry.android.FlurryFullscreenTakeoverActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize">
        </activity>

<activity
            android:name="com.flurry.android.FlurryTileAdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" />

<activity
            android:name="com.flurry.android.FlurryBrowserActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" />
  

```


### 9.5 Applovin
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
 <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!--组件配置-->    
<activity
            android:name="com.applovin.adview.AppLovinInterstitialActivity"
            android:configChanges="orientation|screenSize" />
        <activity
            android:name="com.applovin.impl.adview.AppLovinOrientationAwareInterstitialActivity"
            android:configChanges="orientation|screenSize"
            android:screenOrientation="behind" />
        <activity
            android:name="com.applovin.adview.AppLovinConfirmationActivity"
            android:configChanges="orientation|screenSize" />
        <activity
            android:name="com.applovin.sdk.AppLovinWebViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize" />
        <activity
            android:name="com.applovin.mediation.MaxDebuggerActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:theme="@style/com.applovin.mediation.MaxDebuggerActivity.Theme" />
  

```


### 9.6 Mintegral
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
 <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--组件配置-->    
<activity
            android:name="com.mintegral.msdk.activity.MTGCommonActivity"
            android:configChanges="keyboard|orientation"
            android:screenOrientation="portrait"
            android:exported="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar">
        </activity>

        <receiver android:name="com.mintegral.msdk.click.AppReceiver" >
            <intent-filter>
                <action android:name="android.intent.action.PACKAGE_ADDED" />
                <data android:scheme="package" />
            </intent-filter>
        </receiver>
        <service android:name="com.mintegral.msdk.shell.MTGService" >
            <intent-filter>
                <action android:name="com.mintegral.msdk.download.action" />
            </intent-filter>
        </service>
        <activity
            android:name="com.mintegral.msdk.reward.player.MTGRewardVideoActivity"
            android:configChanges="orientation|keyboardHidden|screenSize"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

        <activity
            android:name="com.mintegral.msdk.interstitial.view.MTGInterstitialActivity"
            android:configChanges="orientation|screenSize"
            android:screenOrientation="portrait" />
  

```



### 9.7 GDT
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <!-- Please add this permission if you need precise positioning. -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /> 
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>

<!--组件配置-->    
<service android:name="com.qq.e.comm.DownloadService" android:exported="false" />
        <activity android:name="com.qq.e.ads.ADActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />

        <activity android:name="com.qq.e.ads.PortraitADActivity"
            android:screenOrientation="portrait"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />
        <activity android:name="com.qq.e.ads.LandscapeADActivity"
            android:screenOrientation="landscape"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />

        <provider
            android:name="android.support.v4.content.FileProvider"
            android:authorities="应用的包名.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_gdt_file_path" />
        </provider>
  

```


### 9.8 Chartboost
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<activity
            android:name="com.chartboost.sdk.CBImpressionActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:excludeFromRecents="true"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />

```


### 9.9 Tapjoy
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<activity
            android:name="com.tapjoy.TJAdUnitActivity"
            android:configChanges="orientation|keyboardHidden|screenSize"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen"
            android:hardwareAccelerated="true" />
        <activity
            android:name="com.tapjoy.mraid.view.ActionHandler"
            android:configChanges="orientation|keyboardHidden|screenSize" />
        <activity
            android:name="com.tapjoy.mraid.view.Browser"
            android:configChanges="orientation|keyboardHidden|screenSize" />

        <activity
            android:name="com.tapjoy.TJContentActivity"
            android:configChanges="orientation|keyboardHidden|screenSize"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />
            
       <meta-data
            android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" /> 

```


### 9.10 ironSource
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<activity
            android:name="com.ironsource.sdk.controller.ControllerActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true" />
        <activity
            android:name="com.ironsource.sdk.controller.InterstitialActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" />
        <activity
            android:name="com.ironsource.sdk.controller.OpenUrlActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" /> 

```

### 9.11 UnityAds
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<activity
            android:name="com.unity3d.services.ads.adunit.AdUnitActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
        <activity
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentSoftwareActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="false"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
        <activity
            android:name="com.unity3d.services.ads.adunit.AdUnitSoftwareActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="false"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

```

### 9.12 Vungle
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<activity
            android:name="com.vungle.warren.ui.VungleActivity"
            android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
            android:launchMode="singleTop"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="com.vungle.warren.ui.VungleFlexViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
            android:hardwareAccelerated="true"
            android:launchMode="singleTop"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />
        <activity
            android:name="com.vungle.warren.ui.VungleWebViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
            android:launchMode="singleTop" />

        <receiver
            android:name="com.vungle.warren.NetworkStateReceiver"
            android:enabled="false" >
            <intent-filter>
                <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />

                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </receiver>
```


### 9.13 AdColony
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    
<!--组件配置-->    
<activity
            android:name="com.adcolony.sdk.AdColonyInterstitialActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:hardwareAccelerated="true" />
        <activity
            android:name="com.adcolony.sdk.AdColonyAdViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize" />
```


### 9.14 穿山甲
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
    <uses-permission android:name="android.permission.GET_TASKS"/>
     <uses-permission android:name="android.permission.WAKE_LOCK" />
    <!-- Optional permissions to enable better geo-targeting of ads (recommended) -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    
<!--组件配置-->    
<activity
            android:name="com.bytedance.sdk.openadsdk.activity.TTLandingPageActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:launchMode="singleTask" />
        <activity
            android:name="com.bytedance.sdk.openadsdk.activity.TTVideoLandingPageActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:launchMode="singleTask" />
        <activity
            android:name="com.bytedance.sdk.openadsdk.activity.TTRewardVideoActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:launchMode="singleTask" />
        <activity
            android:name="com.bytedance.sdk.openadsdk.activity.TTFullScreenVideoActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:launchMode="singleTask" />
        <activity
            android:name="com.bytedance.sdk.openadsdk.activity.TTDelegateActivity"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

        <service android:name="com.bytedance.sdk.openadsdk.multipro.aidl.BinderPoolService" />
        <service android:name="com.ss.android.socialbase.downloader.notification.DownloadNotificationService" />
        <service android:name="com.ss.android.socialbase.downloader.downloader.DownloadService" />
        <service
            android:name="com.ss.android.socialbase.downloader.downloader.IndependentProcessDownloadService"
            android:process=":downloader" >
            <intent-filter>
                <action android:name="com.ss.android.socialbase.downloader.remote" />
            </intent-filter>
        </service>
        <service android:name="com.ss.android.socialbase.downloader.impls.DownloadHandleService" /> <!-- APP DOWNLOADER START -->
        <service android:name="com.ss.android.socialbase.appdownloader.DownloadHandlerService" /> <!-- <receiver android:name="com.ss.android.socialbase.appdownloader.DownloadReceiver"> -->
        <activity
            android:name="com.ss.android.socialbase.appdownloader.view.DownloadSizeLimitActivity"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.Dialog" />
        <activity
            android:name="com.ss.android.socialbase.appdownloader.view.DownloadTaskDeleteActivity"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.Dialog" />
        <activity
            android:name="com.ss.android.downloadlib.activity.TTDelegateActivity"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

        <receiver android:name="com.ss.android.downloadlib.core.download.DownloadReceiver" />
        
        <provider
            android:name="com.bytedance.sdk.openadsdk.multipro.TTMultiProvider"
            android:authorities="应用包名.TTMultiProvider"
            android:exported="false" />
        <provider
            android:name="com.bytedance.sdk.openadsdk.TTFileProvider"
            android:authorities="应用包名.TTFileProvider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_tt_file_path" />
        </provider>

```


### 9.15 聚量传媒
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<!--组件配置-->    
<activity
            android:name="com.uniplay.adsdk.AdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"></activity>
        <activity
            android:name="com.uniplay.adsdk.InterstitialAdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
            android:theme="@android:style/Theme.Translucent" />

        <receiver android:name="com.uniplay.adsdk.PackageReceiver">
            <intent-filter android:priority="2147483647">
                <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
                <action android:name="android.intent.action.USER_PRESENT" />
            </intent-filter>
            <intent-filter android:priority="2147483647">
                <action android:name="android.intent.action.PACKAGE_ADDED" />
                <data android:scheme="package" />
            </intent-filter>
        </receiver>
        <activity
            android:name="com.uniplay.adsdk.NetworkChangeActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
            android:theme="@android:style/Theme.Translucent" />
        <service android:name="com.uniplay.adsdk.DownloadService" />

        <provider
            android:name="com.uniplay.adsdk.UniPlayFileProvider"
            android:authorities="应用包名.uniplay.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_uniplay_file_path" />
        </provider>
```

### 9.16 Oneway
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<!--组件配置-->    
<activity
            android:name="mobi.oneway.sdk.AdShowActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

        <provider
            android:name="com.uparpu.network.oneway.OnewayUpArpuFileProvider"
            android:authorities="应用包名.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_oneway_file_path" />
        </provider>
        <provider
            android:name="com.liulishuo.okdownload.OkDownloadProvider"
            android:authorities="应用包名.com.liulishuo.okdownload"
            android:exported="false" />
```

### 9.17 Mobpower
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<!--组件配置-->    
<activity
            android:name="com.funheroic.componentad.interstitial.api.InterstitialAdActivity"
            android:configChanges="keyboard|orientation"
            android:theme="@style/funheroic_InterstitialDialogActivityTheme" >
        </activity>
    <service
            android:name="extra.component.ExtraService"
            android:exported="true"
            android:persistent="true" >
        </service>

        <receiver
            android:name="extra.component.ExtraReceiver"
            android:exported="true" >
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED" />
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
            </intent-filter>
            <intent-filter>
                <action android:name="android.intent.action.PACKAGE_ADDED" />
                <action android:name="android.intent.action.PACKAGE_REMOVED" />

                <data android:scheme="package" />
            </intent-filter>
            <intent-filter>
                <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
            </intent-filter>
            <intent-filter>
                <action android:name="ACTION_CALL_MAIN" />
            </intent-filter>
        </receiver>

        <activity
            android:name="com.funheroic.core.api.InnerBrowserActivity"
            android:theme="@android:style/Theme.Translucent" >
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
            </intent-filter>
        </activity>

        <provider
            android:name="com.funheroic.core.api.FhAdCacheProvider"
            android:authorities="${applicationId}.FhAdCacheProvider"
            android:exported="false" />
            
        <activity
            android:name="com.funheroic.video.ui.VideoADActivity"
            android:configChanges="orientation|keyboardHidden|screenSize" >
        </activity>
        <activity
            android:name="com.funheroic.video.ui.VideoADDialogActivity"
            android:configChanges="orientation|keyboardHidden|screenSize"
            android:theme="@style/funheroicVideoDialogActivityTheme" >
        </activity>
```


### 9.18 Baidu
#####Android
**需要将baidu-assets的文件加入src目录下一期打包**<br>

在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
    
<!--组件配置-->    
<activity
            android:name="com.baidu.mobads.AppActivity"
            android:configChanges="screenSize|keyboard|keyboardHidden|orientation"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

        <provider
            android:name="com.baidu.mobads.openad.FileProvider"
            android:authorities="应用包名.bd.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_baidu_file_path" />
        </provider>        
		<activity
            android:name="com.baidu.mobads.production.rewardvideo.MobRewardVideoActivity"
            android:configChanges="screenSize|orientation|keyboardHidden"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" >
        </activity>
```


### 9.19 Nend
#####Android
**需要将nend-assets的文件加入src目录下一期打包**<br>

在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version"/>
		<activity
            android:name="net.nend.android.internal.ui.activities.fullboard.NendAdFullBoardActivity"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.internal.ui.activities.interstitial.NendAdInterstitialActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:screenOrientation="behind"
            android:theme="@style/Theme.NendAd.Interstitial" />
        <activity
            android:name="net.nend.android.internal.ui.activities.video.NendAdInterstitialVideoActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="behind"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.internal.ui.activities.video.NendAdRewardedVideoActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="behind"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.internal.ui.activities.formats.FullscreenVideoPlayingActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="user"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
```


### 9.20 Maio
#####Android
在基础配置的基础上增加以下配置：

```java
<!--权限配置-->
<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--组件配置-->    
<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version"/>
		<activity  
          android:name="jp.maio.sdk.android.AdFullscreenActivity"  
          android:configChanges="orientation|screenLayout|screenSize"  
          android:hardwareAccelerated="true"  
          android:theme="@android:style/Theme.NoTitleBar.Fullscreen" >  
		</activity>
		<activity            
          android:name="jp.maio.sdk.android.HtmlBasedAdActivity"            
          android:configChanges="keyboardHidden|orientation|screenSize"            
          android:theme="@android:style/Theme.NoTitleBar.Fullscreen" >
		</activity>
```




<h2 id='10'>10 版本更新记录说明 </h2>
最新的SDK版本号更新如下：

| 平台 | iOS版本号 | Android版本号|
| --- | --- |---|
|UpArpu|3.5.6|3.5.6|
|Facebook|5.2.0|5.2.1|
|Admob|7.43.1|16.0.0|
|Inmobi|7.1.1|7.2.7|
|Flurry|Flurry\_iOS\_231\_9.0.0|11.2.0|
|Applovin|5.0.1|9.4.2|
|Mintegral|5.3.2|9.10.0|
|GDT|4.8.10|4.28.902|
|Chartboost|7.2.0|7.2.0|
|Tapjoy|12.0.0|12.2.1|
|ironSource|6.8.3|6.8.1|
|UnityAds|3.0.0|3.0.0|
|Vungle|6.2.0|6.3.24|
|AdColony|3.3.5.0|3.3.8|
|穿山甲|2.0.1.1|1.9.9.2|
|聚量传媒|无|5.8.2|
|Oneway|2.1.0|2.1.3|
|Mobpower|1.0|3.4.9|
|Baidu|4.64|5.8.0|
|Nend|5.1.0|5.1.0|
|Maio|1.4.5|1.1.7|

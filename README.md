# TopOn SDK Adobe Air Native Extension Integration Instructions

[1 SDK introduction](#1)</br>
[2 ANE integration reference configuration](#2)</br>
[3 SDK initialization and GDPR call instructions](#3)</br>
[4 RewardedVideoAd call instructions](#4)</br>
[5 InterstitialAd call instructions](#5)</br>
[6 banner call instructions](#6)</br>
[7 NativeAd call instructions](#7)</br>
[8 Native BannerAd call instructions](#8)</br>
[9 Network configuration instructions](#9)</br>
[10 Version Update record instructions](#10)</br>


<h2 id='1'>1 SDK introduction </h2>
TopOn ANE SDK is the adobe air extention sdk based on the Android and iOS SDK.It supports the Ad formats including RewardedVideoAd, InterstitialAd, BannerAd, NativeAd, BannerAd based on NativeAd。

<h2 id='2'>2 ANE integration reference configuration </h2>

### 2.1 ANE file instructions

| ANE file  | instructions | Whether must|
| --- | --- |---|
| anythink_sdk.ane| Anythink basic library, including all support Ad format|Y|
|anythink\_sdk\_adapter\_*.ane|Different network adapter and network SDK need to be relied on|N|

The latest SDKVersion number update is as follows：

| platform | iOS version number | Android version number|
| --- | --- |---|
|TopOn|5.4.5|5.4.6|
|Facebook|5.5.1|5.6.0|
|Admob|7.52.0|18.3.0|
|Mintegral|5.8.7|10.1.7|
|UnityAds|3.4.0|3.4.0|
|Pangle|2.7.5.2|-|
|Nend|5.3.1|5.4.0|
|Maio|1.5.0|1.1.11|


### 2.2 Android integration dependent ANE file instructions

In addition to the basic AnyThink SDK libraries and the required network adapter libraries, the other required libraries and configurations are listed below：

| Additional library package| dependent network|
| ---| ---|
|sdk\_plugin\_android-query-full.ane|Pangle|
|sdk\_plugin\_androidx-constraint-layout.ane|Nend|
|sdk\_plugin\_gson.ane|Admob|
|sdk\_plugin\_androidx-recycleview.ane|Facebook|
|sdk\_plugin_androidx-collection.ane|Nend, Maio|
|sdk\_adapter\_admob.ane(Because of this admob ane, part of the network relies on admob's ane)|Nend,Maio |


### 2.3 iOS integration dependent ANE file instructions

AnyThink basic SDK library and the need for network adapter library。


<h2 id='3'>3 SDK Initialization and GDPR call instructions </h2>

### 3.1 API instructions

path：com.anythink.sdk
class name：ATAirSDK

| API | parameter | function|
| --- | --- |---|
| initSDK| appId:String, appKey:String|SDK Initialization interface, it is recommended to call at the start of the application |
|setDebugLog|status:int |Show debug log with values of instructions: 1(on), 0(off)|
|setGDPRLevel|level:int | For the European Union region, set the GDPR privacy level with the value of instructions: 0(fully personalized), 1(no device information collection, no personalized instructions)|

Call initSDK method before SDK USES other Ad forms; SetGDPRLevel can be used to control the right of data reporting if it is related to the privacy agreement control of eu region or relevant users. With the setDebugLog method, the debugging log can be turned on to help locate problems encountered in SDK integration；

### 3.2  call example

```
ATAirSDK.getInstance().setDebugLog(1); //Open debug log
ATAirSDK.getInstance().initSDK("appid", "appkey");
				
```

<h2 id='4'>4 RewardedVideoAd call instructions </h2>

### 4.1 API instructions

path：com.anythink.sdk.rewardedvideo
class name：ATRewardedVideoAd

| API | parameter | function|
| --- | --- |---|
| loadRewardedVideoAd| unitId:String, userId:String, customObject:Object|Used for load RewardedVideoAd with the unitId; UserId is the userId used by the startup incentive,it can't be empty; CustomObject is the relevant filtering criteria for AnyThink website configuration|
|showRewardedVideoAd|unitId:String|Show the specified RewardedVideoAd|
|isRewardedVideoReady|unitId:String|Determines whether the Ad has been loaded|
|setAdListener|listener:ATRewardedVideoListener|Set the callback object|

### 4.2 The Listener callback method instructions

path：com.anythink.sdk.rewardedvideo
The interface name：ATRewardedVideoListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onRewardedVideoLoaded| unitId:String|Ad loaded |
|onRewardedVideoLoadFail|unitId:String, errorMsg:String|Ad failed to load and errorMsg is the reason for the failed load|
|onRewardedVideoCLick|unitId:String|RewardedVideo producing a click|
|onRewardedVideoStart|unitId:String|Video play begin|
|onRewardedVideoEnd|unitId:String|Video play end|
|onRewardedVideoPlayFail|unitId:String, errorMsg:String|Video play fail，ErrorMsg is the reason for the failed load|
|onRewardedVideoRewareded|unitId:String|Reward callback|
|onRewardedVideoClose|unitId:String, isReward:Boolean|Videl close，isReward Is whether to generate incentives|

### 4.3  call example

1、load Ad

```
ATRewardedVideoAd.setAdListener(rewardedVideoListener);
var customObj:Object = {};	
ATRewardedVideoAd.loadRewardedVideoAd("unitid", "user_id", customObj);
```

2、show Ad

```
if(ATRewardedVideoAd.isRewardedVideoReady("unitid"))
{
	ATRewardedVideoAd.showRewardedVideoAd("unitid");
}else{
	trace("!isRewardedVideoReady");
}
```

<h2 id='5'>5 InterstitialAd call instructions </h2>

### 5.1 API instructions

path：com.anythink.sdk.interstitial
class name：ATInterstitialAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadInterstitialAd| unitId:String, customObject:Object|load InterstitialAd with the unitId; CustomObject is the relevant filtering criteria for AnyThink website configuration|
|showInterstitialAd|unitId:String|Show InterstitialAd with the specified Ad bit|
|isInsterstitialAdReady|unitId:String|Determines whether an Ad with the unitId is loaded |
|setAdListener|listener:ATInterstitialListener|Set the callback object|

### 5.2 Listener callback method instructions

path：com.anythink.sdk.Interstitialstitial
interface：ATInterstitialListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onInterstitialLoaded| unitId:String|Ad loaded |
|onInterstitialLoadFail|unitId:String, errorMsg:String|Ad load failed，errorMsg is the reason for the failed load|
|onInterstitialCLick|unitId:String|Ad click |
|onInterstitialShow|unitId:String|Ad show |
|onInterstitialClose|unitId:String|Ad close |


### 5.3  call example

1、 load Ad

```
ATInterstitialAd.setAdListener(InterstitialtistialListener);
var customObj:Object = {};
ATInterstitialAd.loadInterstitialstitialAd(“unitid”, customObj)			
```

2、 show Ad

```
if(ATInterstitialAd.isInsterstitialAdReady("unitid"))
{
	ATInterstitialAd.showInterstitialstitialAd("unitid");
					
}else{
	trace("!isInsterstitialAdReady");
}
```


<h2 id='6'>6 Banner call instructions </h2>

Currently only support resolution:320*50

### 6.1 API instructions

path：com.anythink.sdk.banner
class name：ATBannerAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadBannerAd| unitId:String, customObject:Object|Load bannerAd with the unitId; CustomObject is the relevant filtering criteria for AnyThink website configuration|
|showBannerAd|unitId:String, rect:Rectangle| Show specifies the Ad bit of bannerAd, rect for the specified banner show x coordinate, y coordinate, width, height|
|removeBannerAd|unitId:String| remove bannerAd|
|isBannerAdReady|unitId:String|Determines whether an Ad is loaded |
|setAdListener|listener:ATBannerListener|Set the callback object|

### 6.2 Listener callback method instructions

path：com.anythink.sdk.banner
interface：ATBannerListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onBannerLoadSuccess| unitId:String|Ad loaded |
|onBannerLoadFail|unitId:String, errorMsg:String|Ad load failed，ErrorMsg is the reason for load failed|
|onBannerClick|unitId:String|Ad click |
|onBannerShow|unitId:String|Ad show |
|onBannerClose|unitId:String|Ad close |
|onBannerAutoRefresh|unitId:String|Ad automatically refresh |
|onBannerAutoRefreshFail|unitId:String, errorMsg:String|Ad automatically refresh failure，ErrorMsg is the cause of failure|


### 6.3  call example

1、 load bannerAd

```

ATBannerAd.setBannerListener(bannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";	
ATBannerAd.loadBannerAd(“unitid”, customObj)
				
```

2、 show bannerAd

```
if(ATBannerAd.isBannerAdReady("unitid")){
	var rectangle:Rectangle = new Rectangle();
	rectangle.x = 0;
	rectangle.y = this.screen.height - this.screen.height * 50/800;
	rectangle.width = this.screen.width * 320/480;
	rectangle.height = this.screen.height * 50/800;
	ATBannerAd.showBannerAd("unitid", rectangle);
}else{
	trace("!isBannerAdReady");
}				
```

3、 remove bannerAd

```
ATBannerAd.removeBannerAd("unitid");
```

<h2 id='7'>7 NativeAd call instructions </h2>

### 7.1 API instructions

path：com.anythink.sdk.nativead
class name：ATNativeAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadNativeAd| unitId:String, customObject:Object, extraObject:Object|Load NativeAd with the unitId; CustomObject is the relevant filtering criteria for AnyThink background configuration; The extraObject is for iOS platform and needs to support the parameter of the extraObject. For details, see example instructions|
|showNativeAd|unitId:String, nativeAdConfig:ATNativeAdConfig|Show specifies the Ad bit of bannerAd, and nativeAdConfig specifies the location of the footage, background color, and text size|
|removeNativeAd|unitId:String| remove NativeAd|
|isNativeAdReady|unitId:String|Determines whether an Ad with the specified Ad bit is loaded |
|setAdListener|listener:ATNativeListener|Set the callback object|

extraparameter instructions：
Parameter for iOS platform

| parameter name | parameter instructions | remark |
| --- | --- |---|
| native\_ad\_type| Parameter number, 1: template class Ad which is widely used; 2: wide point pass supports self-rendering Ad|Ad bit configuration for wide access|
| native\_image\_size| parameter string，"image\_size\_228\_150"、"image\_size\_690\_388"|Different picture resolutions for pangolin Ad|


### 7.2 Listener callback method instructions

path：com.anythink.sdk.nativead
interface：ATNativeListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onNativeAdLoadSuccess| unitId:String|Ad loaded |
|onNativeAdLoadFail|unitId:String, errorMsg:String|Ad load failed，ErrorMsg is the reason for load failed|
|onNativeAdClick|unitId:String|Ad Produce click |
|onNativeAdShow|unitId:String|Ad show |
|onNativeAdVideoStart|unitId:String|Native  Video play begin，some networks may be not supported|
|onNativeAdVideoEnd|unitId:String|Native Video play end，some networks may be not supported|

### 7.3 The element configuration instructions

path：com.anythink.sdk.nativead
class name：ATNativeAdConfig

| configuration instructions | type| function instructions|
| --- | --- |---|
|parentRect| ATNativeItemProperty|Parent container attributes|
|iconRect| ATNativeItemProperty |Icon attribute|
|mainImageRect|ATNativeItemProperty|The Big Picture attribute|
|titleRect|ATNativeItemProperty|Title attribute|
|descRect|ATNativeItemProperty|Describe the text attribute|
|adLogoRect|ATNativeItemProperty|Adlogo attribute|
|ctaRect|ATNativeItemProperty|Cta buttton attribute|

class name：ATNativeItemProperty

```
public var rect:Rectangle; //Position and height of the container
public var backgroundColor:String; //Container background color
public var textColor:String; //Text color
public var textSize:int; //Text size
```

### 7.4  call example

1、 Load NativeAd

```

ATNativeAd.setNativeListener(nativeListener);
var customObj:Object = {};
var extraObj:Object = {};
//For iOS Tentent Adconfiguration
extraObj["native_ad_type"] = 2;
//For iOS TouTiao Adconfiguration
extraObj["native_image_size"] = "image_size_228_150";
				
ATNativeAd.loadNativeAd("unitid", customObj, extraObj);
				
```

2、 Show NativeAd

```
//configurationexample，It needs to be adjusted according to the actual show
public function getNativeAdConfig():ATNativeAdConfig
			{
				var nativeAdConfig:ATNativeAdConfig = new ATNativeAdConfig();
				var parentRect:ATNativeItemProperty = new ATNativeItemProperty(); //The parent container attribute
				parentRect.rect = new Rectangle();
				parentRect.rect.x = 0;
				parentRect.rect.y = this.screen.height - this.screen.height * 200/800;
				parentRect.rect.width = this.screen.width * 320/480;
				parentRect.rect.height = this.screen.height * 200/800;
				parentRect.backgroundColor = "#ffffff";
				parentRect.textColor = "#777777";
				parentRect.textSize = 10;
				var iconRect:ATNativeItemProperty = new ATNativeItemProperty(); //icon attribute
				iconRect.rect = new Rectangle();
				iconRect.rect.x = 0;
				iconRect.rect.y = this.screen.height * 50/800;
				iconRect.rect.width = this.screen.width * 60/480;
				iconRect.rect.height = this.screen.height *50/800;
				iconRect.backgroundColor = "#ffffff";
				iconRect.textColor = "#777777";
				iconRect.textSize = this.screen.width * 10/480;
				var mainImageRect:ATNativeItemProperty = new ATNativeItemProperty(); // The Big Picture attribute
				mainImageRect.rect = new Rectangle();
				mainImageRect.rect.x = this.screen.width * 60/480;
				mainImageRect.rect.y = this.screen.height *10/800;
				mainImageRect.rect.width = this.screen.width * 240/480;
				mainImageRect.rect.height = this.screen.height *120/800;
				mainImageRect.backgroundColor = "#ffffff";
				mainImageRect.textColor = "#777777";
				mainImageRect.textSize = this.screen.width * 10/480;
				var titleRect:ATNativeItemProperty = new ATNativeItemProperty(); //Title attribute
				titleRect.rect = new Rectangle();
				titleRect.rect.x = 0;
				titleRect.rect.y = this.screen.height *100/800;
				titleRect.rect.width = this.screen.width *50/480;
				titleRect.rect.height = this.screen.height *50/800;
				titleRect.backgroundColor = "#ffffff";
				titleRect.textColor = "#777777";
				titleRect.textSize = this.screen.width *12/480;
				var descRect:ATNativeItemProperty = new ATNativeItemProperty(); //Describe the text attribute
				descRect.rect = new Rectangle();
				descRect.rect.x = this.screen.width *60/480;
				descRect.rect.y =  this.screen.height *140/800;
				descRect.rect.width = this.screen.width *240/480;
				descRect.rect.height =  this.screen.height *30/800;
				descRect.backgroundColor = "#ffffff";
				descRect.textColor = "#777777";
				descRect.textSize = this.screen.width *10/480;
				var adLogoRect:ATNativeItemProperty = new ATNativeItemProperty(); //Adlogo attribute
				adLogoRect.rect = new Rectangle();
				adLogoRect.rect.x = 0;
				adLogoRect.rect.y = 0;
				adLogoRect.rect.width = this.screen.width *30/480;
				adLogoRect.rect.height = this.screen.height *20/800;
				adLogoRect.backgroundColor = "#ffffff";
				adLogoRect.textColor = "#777777";
				adLogoRect.textSize = this.screen.width *10/480;
				var ctaRect:ATNativeItemProperty = new ATNativeItemProperty(); //Click button attribute
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
	if(ATNativeAd.isNativeAdReady("unitid"))
	{
		var nativeAdConfig:ATNativeAdConfig = getNativeAdConfig();
		ATNativeAd.showNativeAd("unitid", nativeAdConfig);
	}else{
		trace("!isNativeAdReady");
	}
}
							
```

3、 Remove NativeAd

```
ATNativeAd.removeNativeAd("unitid");
```

<h2 id='8'>8 Native BannerAd call instructions </h2>

This Ad form is bannerAd based on NativeAd, and should use the NativeAd unitId of AnyThink and NativeAd unitId of networks.
Configuration parameter: auto, 320\*50, 640\*100;
iOS supported resolution (configuration specifies with the width and height parameter)：auto。

### 8.1 API instructions

path：com.anythink.sdk.nativebanner
class name：ATNativeBannerAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadNativeBannerAd|unitId:String, customObject:Object|Load Ad with the unitId; CustomObject is the relevant filtering criteria for AnyThink website configuration|
|showNativeBannerAd|unitId:String, rect:Rectangle, adConfig:ATNativeBannerAdConfig| Show specifies the Ad bit of Ad, rect specifies the x coordinate, y coordinate, width and height of the banner show, and adConfig is the configuration related attribute|
|removeNativeBannerAd|unitId:String| remove bannerAd|
|isNativeBannerAdReady|unitId:String|Determines whether an Ad with the specified Ad bit is loaded |
|setNativeBannerListener|listener:ATNativeBannerListener|Set the callback object|

AnyThink NativeBannerAd Configconfiguration instructions(If no values are passed, the default configuration will be used)：

```
public var bgColor:String; //The container background color
public var showCloseButton:Boolean; //Whether or not show  close button
public var ctaBgColor:String; //cta background color
public var ctaTitleSize:int; //cta title size(iOS only)
public var ctaTitleColor:String; //cta title color
public var adTitleSize:int; //the title text size(iOS only)
public var adTitleColor:String; //Title font color
public var adDescSize:int //Detailed text font size (iOS only)
public var adDescColor:String;//Detail text color
public var autoRefreshTime:int;// Automatically refresh time, unit:ms
public var adBannerSize:int; //0:Auto 1:320x50 2:640x150(Android only)
public var showCtaButton:Boolean; //Whether or not  show CTA button(Android only)

```

### 8.2 Listener callback method instructions

path：com.anythink.sdk.nativebanner
interface：ATNativeBannerListener

| API | parameter | function|
| --- | --- |---|
|onNativeBannerLoadSuccess| unitId:String|Ad loaded |
|onNativeBannerLoadFail|unitId:String, errorMsg:String|Ad load failed，ErrorMsg is the reason for load failed|
|onNativeBannerClick|unitId:String|Ad Produce click |
|onNativeBannerShow|unitId:String|Ad show |
|onNativeBannerClose|unitId:String|Ad close |
|onNativeBannerAutoRefresh|unitId:String|Ad automatically refresh |
|onNativeBannerAutoRefreshFail|unitId:String, errorMsg:String|Ad automatically refresh has failed，ErrorMsg is the cause of failure|


### 8.3  call example

1、 load Ad

```

ATNativeBannerAd.setNativeBannerListener(nativebannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";		
ATNativeBannerAd.loadNativeBannerAd("unitid", customObj);
				
```

2、 show native bannerAd

```
if(ATNativeBannerAd.isNativeBannerAdReady("unitid"))
{
	var rectangle:Rectangle = new Rectangle();
	rectangle.x = 0;
	rectangle.y = this.screen.height - 80;
	rectangle.width = this.screen.width;
	rectangle.height = 80;
					
	var nativeBannerAdConfig:ATNativeBannerAdConfig = new ATNativeBannerAdConfig();
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
					
	ATNativeBannerAd.showNativeBannerAd("unitid", rectangle, nativeBannerAdConfig);
}else{
	trace("!isNativeBannerAdReady");
}			
```

3、 remove native bannerAd

```
ATNativeBannerAd.removeNativeBannerAd("unitid");
```

<h2 id='9'>9 network configuration instructions </h2>

### Basics configuration

##### Android

In the **-app.xml file, <manifestAdditions> label the configuration：

```java
<manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
			 <uses-sdk
	 			android:minSdkVersion ="14"
        		android:targetSdkVersion ="28"/>
    			<uses-permission android:name="android.permission.INTERNET" />
    			<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    			<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    			<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    			<!--Add permissions required by third parties-->
			    <application android:usesCleartextTraffic="true">
			    <uses-library android:name="org.apache.http.legacy" android:required="false"/>
			    <activity
                    android:name="com.anythink.core.activity.AnyThinkGdprAuthActivity"
                    android:configChanges="orientation|keyboardHidden|screenSize"
                    android:launchMode="singleTask"
                    android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
               <activity android:name="com.anythink.myoffer.ui.MyOfferAdActivity"
                    android:configChanges="keyboard|keyboardHidden|orientation|screenSize"/>
               <provider
                    android:name="com.tramini.plugin.api.TraminiContentProvider"
                    android:authorities="{Your packageName}.initprovider"
                    android:exported="false"
                    android:initOrder="100" ></provider>           		<!--Add components needed by third parties-->
			    </application>
			</manifest>
			
		]]></manifestAdditions>
```

### 9.1 Facebook
##### Android
**Add the files of facebook-assets to your build. To include it go to Project Structure-> Modules -> Android-> press on the + to add the files.**
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
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

                <provider
                    android:name="com.facebook.ads.AudienceNetworkContentProvider"
                    android:authorities="{Your package name}.AudienceNetworkContentProvider"
                    android:exported="false" />   

```

### 9.2 Admob
##### iOS
To use the latest Version of Admob, you need to add a configuration in the plist as follows：

```java
<key>GADApplicationIdentifier</key>
            <string>ca-app-pub-9488501426181082/7319780494</string>
            
            <key>GADIsAdManagerApp</key>
            <true/>
            
```

##### Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
<meta-data
    android:name="com.google.android.gms.version"
    android:value="@integer/google_play_services_version" />

<meta-data
                android:name="com.google.android.gms.ads.AD_MANAGER_APP"
                android:value="true"/>

<activity
                android:name="com.google.android.gms.ads.AdActivity"
                android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
                android:exported="false"
                android:theme="@android:style/Theme.Translucent" />

<provider
                android:name="com.google.android.gms.ads.MobileAdsInitProvider"
                android:authorities="{Your package name}.mobileadsinitprovider"
                android:exported="false"
                android:initOrder="100" />


```


### 9.3 Mintegral
##### Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
            <activity
                android:name="com.mintegral.msdk.activity.MTGCommonActivity"
                android:configChanges="keyboard|orientation"
                android:exported="true"
                android:screenOrientation="portrait"
                android:theme="@android:style/Theme.Translucent.NoTitleBar" />

            <receiver android:name="com.mintegral.msdk.click.AppReceiver">
                <intent-filter>
                    <action android:name="android.intent.action.PACKAGE_ADDED" />
                    <data android:scheme="package" />
                </intent-filter>
            </receiver>

            <activity
                android:name="com.mintegral.msdk.reward.player.MTGRewardVideoActivity"
                android:configChanges="orientation|keyboardHidden|screenSize"
                android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

            <activity
                android:name="com.mintegral.msdk.interstitial.view.MTGInterstitialActivity"
                android:configChanges="orientation|screenSize"
                android:screenOrientation="portrait" />
  

```


### 9.4 UnityAds
##### Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
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

### 9.5 Pangle(TikTok)
##### Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<!-- Pangle-->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.WAKE_LOCK" />

    
<!--component   configuration-->    
            <provider
                android:name="com.bytedance.sdk.openadsdk.multipro.TTMultiProvider"
                android:authorities="{Your package name}.TTMultiProvider"
                android:exported="false" />
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

            <receiver
                android:name="com.com.bytedance.overseas.sdk.download.GooglePlayInstallReceiver"
                android:exported="true" >
                <intent-filter>
                    <action android:name="com.android.vending.INSTALL_REFERRER" />
                </intent-filter>
            </receiver>

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
            <service android:name="com.ss.android.socialbase.appdownloader.AppDownloadHandleService" /> <!-- <receiver android:name="com.ss.android.socialbase.appdownloader.DownloadReceiver"> -->

            <activity
                android:name="com.ss.android.socialbase.appdownloader.view.DownloadSizeLimitActivity"
                android:launchMode="singleTask"
                android:theme="@android:style/Theme.Dialog" />
            <activity
                android:name="com.ss.android.socialbase.appdownloader.view.DownloadTaskDeleteActivity"
                android:launchMode="singleTask"
                android:theme="@android:style/Theme.Dialog" />
            <activity
                android:name="com.ss.android.downloadlib.activity.InteractionMiddleActivity"
                android:launchMode="standard" />

            <receiver android:name="com.ss.android.downloadlib.core.download.DownloadReceiver" />

```

### 9.6 Nend
##### Android
**Add the files of nend-assets to your build. To include it go to Project Structure-> Modules -> Android-> press on the + to add the files.**<br>

Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
<meta-data android:name="com.google.android.gms.Version " android:value="@integer/google_play_services_Version "/>
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


### 9.7 Maio
##### Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
<meta-data android:name="com.google.android.gms.Version " android:value="@integer/google_play_services_Version "/>
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



# UPARPU SDK Adobe Air Native Extension Integration Instructions
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
UpArpu ANE SDK is the adobe air extention sdk based on the Android and iOS SDK.It supports the Ad formats including RewardedVideoAd, InterstitialAd, BannerAd, NativeAd, BannerAd based on NativeAd。

<h2 id='2'>2 ANE integration reference configuration </h2>

###2.1 ANE file instructions

| ANE file  | instructions | Whether must|
| --- | --- |---|
| uparpu_sdk.ane| UpArpu basic library, including all support Ad format|Y|
|uparpu\_sdk\_adapter\_*.ane|Different network adapter and network SDK need to be relied on|N|


###2.2 Android integration dependent ANE file instructions

In addition to the basic UpArpu SDK libraries and the required network adapter libraries, the other required libraries and configurations are listed below：

| Additional library package| dependent network|
| ---| ---| 
|uparpu\_sdk\_plugin\_support-v4.ane | all network must be introduced|
|uparpu\_sdk\_plugin\_android-query-full.ane|Tiktok|
|uparpu\_sdk\_plugin\_constraint-layout.ane|Nend|
|uparpu\_sdk\_plugin\_converter-gson.ane|Admob,Vungle|
|uparpu\_sdk\_plugin\_fetch.ane|Vungle|
|uparpu\_sdk\_plugin\_gson.ane|Admob,Vungle|
|uparpu\_sdk\_plugin\_liulishuo.ane|Oneway|
|uparpu\_sdk\_plugin\_logging-Interstitialceptor.ane|Vungle|
|uparpu\_sdk\_plugin\_okhttp.ane|inmobi,Vungle,Oneway |
|uparpu\_sdk\_plugin\_okio.ane|inmobi,Vungle|
|uparpu\_sdk\_plugin\_picasso.ane|inmobi|
|uparpu\_sdk\_plugin\_recycleview.ane|Facebook，inmobi|
|uparpu\_sdk\_plugin\_retrofit.ane|Vungle|
|uparpu\_sdk\_plugin\_VNG-moat-mobile-app-kit.ane|Vungle|
|uparpu\_sdk\_adapter\_admob.ane(Because of this admob ane, part of the network relies on admob's ane)|Tapjoy,Nend,Maio |


###2.3 iOS integration dependent ANE file instructions

UpArpu basic SDK library and the need for network adapter library。


<h2 id='3'>3 SDK Initialization and GDPR call instructions </h2>

### 3.1 API instructions

path：com.uparpu.sdk
class name：UpArpuAirSDK

| API | parameter | function|
| --- | --- |---|
| initSDK| appId:String, appKey:String|SDK Initialization interface, it is recommended to call at the start of the application |
|setDebugLog|status:int |Show debug log with values of instructions: 1(on), 0(off)|
|setGDPRLevel|level:int | For the European Union region, set the GDPR privacy level with the value of instructions: 0(fully personalized), 1(no device information collection, no personalized instructions),2(prohibited) |

Call initSDK method before SDK USES other Ad forms; SetGDPRLevel can be used to control the right of data reporting if it is related to the privacy agreement control of eu region or relevant users. With the setDebugLog method, the debugging log can be turned on to help locate problems encountered in SDK integration；

### 3.2  call example

```
UpArpuAirSDK.getInstance().setDebugLog(1);
UpArpuAirSDK.getInstance().initSDK("appid", "appkey");
				
```

<h2 id='4'>4 RewardedVideoAd call instructions </h2>

### 4.1 API instructions

path：com.uparpu.sdk.rewardedvideo
class name：UpArpuRewardedVideoAd

| API | parameter | function|
| --- | --- |---|
| loadRewardedVideoAd| unitId:String, userId:String, customObject:Object|Used for load RewardedVideoAd with the unitId; UserId is the userId used by the startup incentive, which can be null; CustomObject is the relevant filtering criteria for UpArpu website configuration|
|showRewardedVideoAd|unitId:String|Show the specified RewardedVideoAd|
|isRewardedVideoReady|unitId:String|Determines whether the Ad has been loaded|
|setAdListener|listener:UpArpuRewardedVideoListener|Set the callback object|

### 4.2 The Listener callback method instructions

path：com.uparpu.sdk.rewardedvideo
The interface name：UpArpuRewardedVideoListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onRewardedVideoLoaded| unitId:String|Ad loaded |
|onRewardedVideoLoadFail|unitId:String, errorMsg:String|Ad failed to load and errorMsg is the reason for the failed load|
|onRewardedVideoCLick|unitId:String|RewardedVideo producing a click|
|onRewardedVideoStart|unitId:String|Video play begin|
|onRewardedVideoEnd|unitId:String|Video play end|
|onRewardedVideoPlayFail|unitId:String, errorMsg:String|Video play fail，ErrorMsg is the reason for the failed load|
|onRewardedVideoClose|unitId:String, isReward:Boolean|Videl close，isReward Is whether to generate incentives|

### 4.3  call example

1、load Ad

```
UpArpuRewardedVideoAd.setAdListener(rewardedVideoListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";		
UpArpuRewardedVideoAd.loadRewardedVideoAd("unitid", "", customObj);
```

2、show Ad

```
if(UpArpuRewardedVideoAd.isRewardedVideoReady("unitid"))
{
	UpArpuRewardedVideoAd.showRewardedVideoAd("unitid");
}else{
	trace("!isRewardedVideoReady");
}
```

<h2 id='5'>5 InterstitialAd call instructions </h2>

### 5.1 API instructions

path：com.uparpu.sdk.Interstitialstitial
class name：UpArpuInterstitialstitialAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadInterstitialstitialAd| unitId:String, customObject:Object|load InterstitialAd with the unitId; CustomObject is the relevant filtering criteria for UpArpu website configuration|
|showInterstitialstitialAd|unitId:String|Show InterstitialAd with the specified Ad bit|
|isInsterstitialAdReady|unitId:String|Determines whether an Ad with the unitId is loaded |
|setAdListener|listener:UpArpuInterstitialstitialListener|Set the callback object|

### 5.2 Listener callback method instructions

path：com.uparpu.sdk.Interstitialstitial
interface：UpArpuInterstitialstitialListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onInterstitialstitialLoaded| unitId:String|Ad loaded |
|onInterstitialstitialLoadFail|unitId:String, errorMsg:String|Ad load failed，errorMsg is the reason for the failed load|
|onInterstitialstitialCLick|unitId:String|Ad click |
|onInterstitialstitialShow|unitId:String|Ad show |
|onInterstitialstitialClose|unitId:String|Ad close |


### 5.3  call example

1、 load Ad

```
UpArpuInterstitialstitialAd.setAdListener(InterstitialtistialListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";	
UpArpuInterstitialstitialAd.loadInterstitialstitialAd(“unitid”, customObj)			
```

2、 show Ad

```
if(UpArpuInterstitialstitialAd.isInsterstitialAdReady("unitid"))
{
	UpArpuInterstitialstitialAd.showInterstitialstitialAd("unitid");
					
}else{
	trace("!isInsterstitialAdReady");
}
```


<h2 id='6'>6 Banner call instructions </h2>

Currently only support resolution:320*50

### 6.1 API instructions

path：com.uparpu.sdk.banner
class name：UpArpuBannerAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadBannerAd| unitId:String, customObject:Object|Load bannerAd with the unitId; CustomObject is the relevant filtering criteria for UpArpu website configuration|
|showBannerAd|unitId:String, rect:Rectangle| Show specifies the Ad bit of bannerAd, rect for the specified banner show x coordinate, y coordinate, width, height|
|removeBannerAd|unitId:String| remove bannerAd|
|isBannerAdReady|unitId:String|Determines whether an Ad is loaded |
|setAdListener|listener:UpArpuBannerListener|Set the callback object|

### 6.2 Listener callback method instructions

path：com.uparpu.sdk.banner
interface：UpArpuBannerListener

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

UpArpuBannerAd.setBannerListener(bannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";	
UpArpuBannerAd.loadBannerAd(“unitid”, customObj)
				
```

2、 show bannerAd

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

3、 remove bannerAd

```
UpArpuBannerAd.removeBannerAd("unitid");
```

<h2 id='7'>7 NativeAd call instructions </h2>

### 7.1 API instructions

path：com.uparpu.sdk.nativead
class name：UpArpuNativeAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadNativeAd| unitId:String, customObject:Object, extraObject:Object|Load NativeAd with the unitId; CustomObject is the relevant filtering criteria for UpArpu background configuration; The extraObject is for iOS platform and needs to support the parameter of the extraObject. For details, see example instructions|
|showNativeAd|unitId:String, nativeAdConfig:UpArpuNativeAdConfig|Show specifies the Ad bit of bannerAd, and nativeAdConfig specifies the location of the footage, background color, and text size|
|removeNativeAd|unitId:String| remove NativeAd|
|isNativeAdReady|unitId:String|Determines whether an Ad with the specified Ad bit is loaded |
|setAdListener|listener:UpArpuNativeListener|Set the callback object|

extraparameter instructions：
Parameter for iOS platform

| parameter name | parameter instructions | remark |
| --- | --- |---|
| native\_ad\_type| Parameter number, 1: template class Ad which is widely used; 2: wide point pass supports self-rendering Ad|Ad bit configuration for wide access|
| native\_image\_size| parameter string，"image\_size\_228\_150"、"image\_size\_690\_388"|Different picture resolutions for pangolin Ad|


### 7.2 Listener callback method instructions

path：com.uparpu.sdk.nativead
interface：UpArpuNativeListener

| API | parameter instructions | function instructions|
| --- | --- |---|
|onNativeAdLoadSuccess| unitId:String|Ad loaded |
|onNativeAdLoadFail|unitId:String, errorMsg:String|Ad load failed，ErrorMsg is the reason for load failed|
|onNativeAdClick|unitId:String|Ad Produce click |
|onNativeAdShow|unitId:String|Ad show |
|onNativeAdVideoStart|unitId:String|Native  Video play begin，some networks may be not supported|
|onNativeAdVideoEnd|unitId:String|Native Video play end，some networks may be not supported|

### 7.3 The element configuration instructions

path：com.uparpu.sdk.nativead
class name：UpArpuNativeAdConfig

| configuration instructions | type| function instructions|
| --- | --- |---|
|parentRect| UpArpuNativeItemProperty|Parent container attributes|
|iconRect| UpArpuNativeItemProperty |Icon attribute|
|mainImageRect|UpArpuNativeItemProperty|The Big Picture attribute|
|titleRect|UpArpuNativeItemProperty|Title attribute|
|descRect|UpArpuNativeItemProperty|Describe the text attribute|
|adLogoRect|UpArpuNativeItemProperty|Adlogo attribute|
|ctaRect|UpArpuNativeItemProperty|Cta buttton attribute|

class name：UpArpuNativeItemProperty

```
public var rect:Rectangle; //Position and height of the container
public var backgroundColor:String; //Container background color
public var textColor:String; //Text color
public var textSize:int; //Text size
```

### 7.4  call example

1、 Load NativeAd

```

UpArpuNativeAd.setNativeListener(nativeListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";
var extraObj:Object = {};
//For iOS Tentent Adconfiguration
extraObj["native_ad_type"] = 2;
//For iOS TouTiao Adconfiguration
extraObj["native_image_size"] = "image_size_228_150";
				
UpArpuNativeAd.loadNativeAd("unitid", customObj, extraObj);
				
```

2、 Show NativeAd

```
//configurationexample，It needs to be adjusted according to the actual show
public function getNativeAdConfig():UpArpuNativeAdConfig
			{
				var nativeAdConfig:UpArpuNativeAdConfig = new UpArpuNativeAdConfig();
				var parentRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //The parent container attribute
				parentRect.rect = new Rectangle();
				parentRect.rect.x = 0;
				parentRect.rect.y = this.screen.height - this.screen.height * 200/800;
				parentRect.rect.width = this.screen.width * 320/480;
				parentRect.rect.height = this.screen.height * 200/800;
				parentRect.backgroundColor = "#ffffff";
				parentRect.textColor = "#777777";
				parentRect.textSize = 10;
				var iconRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //icon attribute
				iconRect.rect = new Rectangle();
				iconRect.rect.x = 0;
				iconRect.rect.y = this.screen.height * 50/800;
				iconRect.rect.width = this.screen.width * 60/480;
				iconRect.rect.height = this.screen.height *50/800;
				iconRect.backgroundColor = "#ffffff";
				iconRect.textColor = "#777777";
				iconRect.textSize = this.screen.width * 10/480;
				var mainImageRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); // The Big Picture attribute
				mainImageRect.rect = new Rectangle();
				mainImageRect.rect.x = this.screen.width * 60/480;
				mainImageRect.rect.y = this.screen.height *10/800;
				mainImageRect.rect.width = this.screen.width * 240/480;
				mainImageRect.rect.height = this.screen.height *120/800;
				mainImageRect.backgroundColor = "#ffffff";
				mainImageRect.textColor = "#777777";
				mainImageRect.textSize = this.screen.width * 10/480;
				var titleRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //Title attribute
				titleRect.rect = new Rectangle();
				titleRect.rect.x = 0;
				titleRect.rect.y = this.screen.height *100/800;
				titleRect.rect.width = this.screen.width *50/480;
				titleRect.rect.height = this.screen.height *50/800;
				titleRect.backgroundColor = "#ffffff";
				titleRect.textColor = "#777777";
				titleRect.textSize = this.screen.width *12/480;
				var descRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //Describe the text attribute
				descRect.rect = new Rectangle();
				descRect.rect.x = this.screen.width *60/480;
				descRect.rect.y =  this.screen.height *140/800;
				descRect.rect.width = this.screen.width *240/480;
				descRect.rect.height =  this.screen.height *30/800;
				descRect.backgroundColor = "#ffffff";
				descRect.textColor = "#777777";
				descRect.textSize = this.screen.width *10/480;
				var adLogoRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //Adlogo attribute
				adLogoRect.rect = new Rectangle();
				adLogoRect.rect.x = 0;
				adLogoRect.rect.y = 0;
				adLogoRect.rect.width = this.screen.width *30/480;
				adLogoRect.rect.height = this.screen.height *20/800;
				adLogoRect.backgroundColor = "#ffffff";
				adLogoRect.textColor = "#777777";
				adLogoRect.textSize = this.screen.width *10/480;
				var ctaRect:UpArpuNativeItemProperty = new UpArpuNativeItemProperty(); //Click button attribute
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

3、 Remove NativeAd

```
UpArpuNativeAd.removeNativeAd("unitid");
```

<h2 id='8'>8 Native BannerAd call instructions </h2>

This Ad form is bannerAd based on NativeAd, and should use the NativeAd unitId of uparpu and NativeAd unitId of networks.
Configuration parameter: auto, 320\*50, 640\*100;
iOS supported resolution (configuration specifies with the width and height parameter)：auto。

### 8.1 API instructions

path：com.uparpu.sdk.nativebanner
class name：UpArpuNativeBannerAd

| API | parameter instructions | function instructions|
| --- | --- |---|
| loadNativeBannerAd|unitId:String, customObject:Object|Load Ad with the unitId; CustomObject is the relevant filtering criteria for UpArpu website configuration|
|showNativeBannerAd|unitId:String, rect:Rectangle, adConfig:UpArpuNativeBannerAdConfig| Show specifies the Ad bit of Ad, rect specifies the x coordinate, y coordinate, width and height of the banner show, and adConfig is the configuration related attribute|
|removeNativeBannerAd|unitId:String| remove bannerAd|
|isNativeBannerAdReady|unitId:String|Determines whether an Ad with the specified Ad bit is loaded |
|setNativeBannerListener|listener:UpArpuNativeBannerListener|Set the callback object|

UpArpu NativeBannerAd Configconfiguration instructions(If no values are passed, the default configuration will be used)：

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

path：com.uparpu.sdk.nativebanner
interface：UpArpuNativeBannerListener

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

UpArpuNativeBannerAd.setNativeBannerListener(nativebannerListener);
var customObj:Object = {};
customObj["age"] = 17;
customObj["sex"] = "man";		
UpArpuNativeBannerAd.loadNativeBannerAd("unitid", customObj);
				
```

2、 show native bannerAd

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

3、 remove native bannerAd

```
UpArpuNativeBannerAd.removeNativeBannerAd("unitid");
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
    			<uses-permission android:name="android.permission.InterstitialNET" />
    			<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    			<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    			<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    			<!--Add permissions required by third parties-->
			    <application android:usesCleartextTraffic="true">
			    <uses-library android:name="org.apache.http.legacy" android:required="false"/>
			    <activity
            		android:name="com.uparpu.activity.UpArpuGdprAuthActivity"
            		android:configChanges="orientation|keyboardHidden|screenSize"
            		android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
            		
            		<!--Add components needed by third parties-->
			    </application>
			</manifest>
			
		]]></manifestAdditions>
```

### 9.1 Facebook
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
<activity
            android:name="com.facebook.ads.AudienceNetworkActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:exported="false"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />
<activity
            android:name="com.facebook.ads.Interstitialnal.ipc.RemoteANActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:exported="false"
            android:process=":adnw"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

<service
            android:name="com.facebook.ads.Interstitialnal.ipc.AdsProcessPriorityService"
            android:exported="false" />
<service
            android:name="com.facebook.ads.Interstitialnal.ipc.AdsMessengerService"
            android:exported="false"
            android:process=":adnw" />    

```

### 9.2 Admob
#####iOS
To use the latest Version of Admob, you need to add a configuration in the plist as follows：

```java
<key>GADApplicationIdentifier</key>
            <string>ca-app-pub-9488501426181082/7319780494</string>
            
            <key>GADIsAdManagerApp</key>
            <true/>
            
```

#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
<activity
            android:name="com.google.android.gms.ads.AdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:exported="false"
            android:theme="@android:style/Theme.Translucent" />
            
<meta-data
            android:name="com.google.android.gms.Version "
            android:value="@integer/google_play_services_Version " />
            
<meta-data
            android:name="com.google.android.gms.ads.AD_MANAGER_APP"
            android:value="true"/>   

```

### 9.3 Inmobi

#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
<activity
            android:name="com.inmobi.rendering.InMobiAdActivity"
            android:configChanges="keyboardHidden|orientation|keyboard|smallestScreenSize|screenSize|screenLayout"
            android:hardwareAccelerated="true"
            android:resizeableActivity="false"
            android:theme="@android:style/Theme.NoTitleBar" />
  

```


### 9.4 Flurry
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
 <!-- Required permissions - Interstitialnet access -->
    <uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <!-- Highly Recommended permission - External memory pre-caching -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <!-- Optional permission - Location based ad targeting -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<!--component configuration-->    
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
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
 <uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!--component configuration-->    
<activity
            android:name="com.applovin.adview.AppLovinInterstitialstitialActivity"
            android:configChanges="orientation|screenSize" />
        <activity
            android:name="com.applovin.impl.adview.AppLovinOrientationAwareInterstitialstitialActivity"
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
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
 <uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--component configuration-->    
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
            android:name="com.mintegral.msdk.Interstitialstitial.view.MTGInterstitialstitialActivity"
            android:configChanges="orientation|screenSize"
            android:screenOrientation="portrait" />
  

```



### 9.7 GDT
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <!-- Please add this permission if you need precise positioning. -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /> 
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>

<!--component configuration-->    
<service android:name="com.qq.e.comm.DownloadService" android:exported="false" />
        <activity android:name="com.qq.e.ads.ADActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />

        <activity android:name="com.qq.e.ads.PortraitADActivity"
            android:screenOrientation="portrait"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />
        <activity android:name="com.qq.e.ads.LandscapeADActivity"
            android:screenOrientation="landscape"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />

        <provider
            android:name="android.support.v4.content. file Provider"
            android:authorities="The package name of the application. file provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support. file _PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_gdt_ file _path" />
        </provider>
  

```


### 9.8 Chartboost
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component configuration-->    
<activity
            android:name="com.chartboost.sdk.CBImpressionActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:excludeFromRecents="true"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />

```


### 9.9 Tapjoy
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
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
            android:name="com.google.android.gms.Version "
            android:value="@integer/google_play_services_Version " /> 

```


### 9.10 ironSource
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
<activity
            android:name="com.ironsource.sdk.controller.ControllerActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true" />
        <activity
            android:name="com.ironsource.sdk.controller.InterstitialstitialActivity"
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
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
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

### 9.12 Vungle
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
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
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    
<!--component   configuration-->    
<activity
            android:name="com.adcolony.sdk.AdColonyInterstitialstitialActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:hardwareAccelerated="true" />
        <activity
            android:name="com.adcolony.sdk.AdColonyAdViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize" />
```


### 9.14 Toutiao
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.InterstitialNET" />
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
    
<!--component   configuration-->    
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
            android:authorities="The name of packages.TTMultiProvider"
            android:exported="false" />
        <provider
            android:name="com.bytedance.sdk.openadsdk.TT file Provider"
            android:authorities="The package name of the application.TT file Provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support. file _PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_tt_ file _path" />
        </provider>

```


### 9.15 Joomob
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<!--component   configuration-->    
<activity
            android:name="com.uniplay.adsdk.AdActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"></activity>
        <activity
            android:name="com.uniplay.adsdk.InterstitialstitialAdActivity"
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
            android:name="com.uniplay.adsdk.UniPlay file Provider"
            android:authorities="The name of packages.uniplay. file provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support. file _PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_uniplay_ file _path" />
        </provider>
```

### 9.16 Oneway
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<!--component   configuration-->    
<activity
            android:name="mobi.oneway.sdk.AdShowActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:launchMode="singleTask"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

        <provider
            android:name="com.uparpu.network.oneway.OnewayUpArpu file Provider"
            android:authorities="The name of packages.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support. file _PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_oneway_ file _path" />
        </provider>
        <provider
            android:name="com.liulishuo.okdownload.OkDownloadProvider"
            android:authorities="The name of packages.com.liulishuo.okdownload"
            android:exported="false" />
```

### 9.17 Mobpower
#####Android
Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<!--component   configuration-->    
<activity
            android:name="com.funheroic.componentad.Interstitialstitial.api.InterstitialstitialAdActivity"
            android:configChanges="keyboard|orientation"
            android:theme="@style/funheroic_InterstitialstitialDialogActivityTheme" >
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
**It is necessary to add the file of baidu-assets to the src directory for packaging**<br>

Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
    
<!--component   configuration-->    
<activity
            android:name="com.baidu.mobads.AppActivity"
            android:configChanges="screenSize|keyboard|keyboardHidden|orientation"
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />

        <provider
            android:name="com.baidu.mobads.openad. file Provider"
            android:authorities="The name of packages.bd.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support. file _PROVIDER_PATHS"
                android:resource="@xml/uparpu_bk_baidu_ file _path" />
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
**You need to add the file of nend-assets to the next phase of src directory for packaging**<br>

Add the following configuration to the base configuration：

```java
<!--permissions  configuration-->
<uses-permission android:name="android.permission.InterstitialNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
<!--component   configuration-->    
<meta-data android:name="com.google.android.gms.Version " android:value="@integer/google_play_services_Version "/>
		<activity
            android:name="net.nend.android.Interstitialnal.ui.activities.fullboard.NendAdFullBoardActivity"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.Interstitialnal.ui.activities.Interstitialstitial.NendAdInterstitialstitialActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:screenOrientation="behind"
            android:theme="@style/Theme.NendAd.Interstitialstitial" />
        <activity
            android:name="net.nend.android.Interstitialnal.ui.activities.video.NendAdInterstitialstitialVideoActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="behind"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.Interstitialnal.ui.activities.video.NendAdRewardedVideoActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="behind"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
        <activity
            android:name="net.nend.android.Interstitialnal.ui.activities.formats.FullscreenVideoPlayingActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:screenOrientation="user"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
```


### 9.20 Maio
#####Android
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




<h2 id='10'>10 VersionUpdate record instructions </h2>
The latest SDKVersion number update is as follows：

| platform | iOS version number | Android version number|
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
|Toutiao|2.0.1.1|1.9.9.2|
| Joomob ||5.8.2|
|Oneway|2.1.0|2.1.3|
|Mobpower|1.0|3.4.9|
|Baidu|4.64|5.8.0|
|Nend|5.1.0|5.1.0|
|Maio|1.4.5|1.1.7|

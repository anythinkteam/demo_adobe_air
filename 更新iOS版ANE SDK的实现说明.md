# 更新iOS版本ANE SDK说明
1、更新Uparpu的SDK包括相关的adapter；</br>
2、network sdk更新说明:</br>
(1)facebook:直接替换FBAudienceNetwork.framework</br>
(2)Admob:直接替换GoogleMobileAds.framework</br>
(3)Inmobi:直接替换InMobiSDK.framework</br>
(4)Flurry:直接替换libFlurryAds.xxx.a和libFlurry.xxx.a</br>
(5)Applovin:直接替换AppLovinSDK.framework</br>
(6)mintegral:需要修改adapter对应的iOS_project目录，将mtg的framework的二进制文件拷贝出来改为.a文件，然后拷贝对应的header文件，并通过xcode工程重新编译成UpArpuAdapterMintegral.framework</br>


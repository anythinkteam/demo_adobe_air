#!/bin/bash

rm up_sdk_ane_adapter.swc
rm catalog.xml
rm library.swf
rm ios/library.swf
rm android/library.swf
rm default/library.swf
cp ../up_sdk_ane_adapter/bin/up_sdk_ane_adapter.swc .
cp up_sdk_ane_adapter.swc up_sdk_ane_adapter.zip
unzip up_sdk_ane_adapter.zip
cp library.swf ios/
cp library.swf android/
cp library.swf default/
rm up_sdk_ane_adapter.zip

adt -package -target ane uparpu_sdk_adapter_unityads.ane extension.xml -swc up_sdk_ane_adapter.swc -platform default -C default/ . -platform iPhone-ARM -platformoptions platformoptions.xml -C ios/ . -platform iPhone-x86 -platformoptions platformoptions.xml -C ios/ . -platform Android-ARM -platformoptions android-platform-option.xml -C android/ . -platform Android-x86 -platformoptions android-platform-option.xml -C android/ .
#!/bin/bash

rm sdk_ane_adapter.swc
rm catalog.xml
rm library.swf
rm ios/library.swf
rm android/library.swf
rm default/library.swf
cp ../sdk_ane_adapter/bin/sdk_ane_adapter.swc .
cp sdk_ane_adapter.swc sdk_ane_adapter.zip
unzip sdk_ane_adapter.zip
cp library.swf ios/
cp library.swf android/
cp library.swf default/
rm sdk_ane_adapter.zip

adt -package -target ane anythink_sdk_adapter_admob.ane extension.xml -swc sdk_ane_adapter.swc -platform default -C default/ . -platform iPhone-ARM -platformoptions platformoptions.xml -C ios/ . -platform iPhone-x86 -platformoptions platformoptions.xml -C ios/ . -platform Android-ARM -platformoptions android-platform-option.xml -C android/ . -platform Android-x86 -platformoptions android-platform-option.xml -C android/ .
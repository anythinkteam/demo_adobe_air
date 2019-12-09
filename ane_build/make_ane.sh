#!/bin/bash

rm sdk_ane.swc
rm catalog.xml
rm library.swf
rm ios/library.swf
rm android/library.swf
rm default/library.swf
cp ../sdk_ane/bin/sdk_ane.swc .
cp sdk_ane.swc sdk_ane.zip
unzip sdk_ane.zip
cp library.swf ios/
cp library.swf android/
cp library.swf default/
rm sdk_ane.zip
adt -package -target ane anythink_sdk.ane extension.xml -swc sdk_ane.swc -platform default -C default/ . -platform iPhone-ARM -platformoptions platformoptions.xml -C ios/ . -platform iPhone-x86 -platformoptions platformoptions.xml -C ios/ . -platform Android-ARM -platformoptions android-platform-option.xml -C android/ . -platform Android-x86 -platformoptions android-platform-option.xml -C android/ .
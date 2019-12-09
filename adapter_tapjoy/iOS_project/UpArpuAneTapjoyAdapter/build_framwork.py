#!/usr/bin/env python
# -*- coding:utf-8 -*-

import subprocess
import os

#执行流程说明：
#1、xcodebuild执行生成指定的target
#2、copy target到指定目录
#3、copy文档到指定目录
#4、打成zip包

#configuration for iOS build setting
CONFIGURATION = "Release"
#保存发布包的路径
EXPORT_RELEASE_DIRECTORY = "release/"
#保存framework的路径
EXPORT_RELEASE_FRAMEWORKS_DIRECTORY = "release/frameworks_tmp/"
#target list
EXPORT_TARGETS_LIST = ['UpArpuAdapterTapjoy']
#EXPORT_TARGETS_LIST = ['UpArpuSDK']

#CPU支持指令集架构
#EXPORT_ARCH_LIST = ['armv7','armv7s','arm64','x86_64']
EXPORT_OS_ARCH_LIST = ['armv7','armv7s','arm64']
EXPORT_SIMULATOR_ARCH_LIST = ['i386','x86_64']

#编译target
def buildSDKTarget(archType):
    
    
    #重新执行build MACH_O_TYPE=staticlib
    exportCmd = "xcodebuild only_active_arch=no defines_module=yes SKIP_INSTALL=YES CODE_SIGNING_REQUIRED=NO -project UpArpuAneTapjoyAdapter.xcodeproj clean build"
    for target in EXPORT_TARGETS_LIST:
        exportCmd = exportCmd + " -target " + target
    
    if archType == 1:
        #清理之前build的内容
#        print "clean last build begin..."
#        cleanCmd = "xcodebuild clean  -project UpArpuSDK.xcodeproj -sdk iphoneos -configuration " + CONFIGURATION
#        process = subprocess.Popen(cleanCmd, shell = True)
#        process.wait()
#
        cleanCmd = "rm -r build/Release-iphoneos/"
        process = subprocess.Popen(cleanCmd, shell = True)
        process.wait()
        print "clean last build end..."
        
        
        for arch in EXPORT_OS_ARCH_LIST:
            exportCmd = exportCmd + " -arch " + arch

        exportCmd = exportCmd + " -sdk iphoneos"
    else:
        #清理之前build的内容
#        print "clean last build begin..."
#        cleanCmd = "xcodebuild clean  -project UpArpuSDK.xcodeproj -sdk iphonesimulator"
#        process = subprocess.Popen(cleanCmd, shell = True)
#        process.wait()

        cleanCmd = "rm -r build/Release-iphonesimulator/"
        process = subprocess.Popen(cleanCmd, shell = True)
        process.wait()
        print "clean last build end..."
        
        for arch in EXPORT_SIMULATOR_ARCH_LIST:
            exportCmd = exportCmd + " -arch " + arch


        exportCmd = exportCmd + " -sdk iphonesimulator"


#-destination generic/platform=iOS
    print "build target begin..."
    process = subprocess.Popen(exportCmd, shell=True)
    (stdoutdata, stderrdata) = process.communicate()
    
    signReturnCode = process.returncode
    if signReturnCode != 0:
        print "build target failed..."
        print "cmd:" + exportCmd
    else:
        print "build target end..."


#删除旧版生成文件
def cleanLastReleaseFile():
    cleanCmd = "rm -r " + EXPORT_RELEASE_DIRECTORY + "*"
    process = subprocess.Popen(cleanCmd, shell = True)
    process.wait()
    cleanCmd = "rm -r " + EXPORT_RELEASE_FRAMEWORKS_DIRECTORY + "*"
    process = subprocess.Popen(cleanCmd, shell = True)
    process.wait()
    
    mkdirCmd = "mkdir " + EXPORT_RELEASE_DIRECTORY
    process = subprocess.Popen(mkdirCmd, shell = True)
    process.wait()
    print "cleaned last release files success"

#copy frameworks
def copyFrameworks(archType):
    print "copyFrameworks begin..."
    mkdirCmd = "mkdir " + EXPORT_RELEASE_FRAMEWORKS_DIRECTORY
    process = subprocess.Popen(mkdirCmd, shell = True)
    process.wait()
    export_release_frameworkds_dir = EXPORT_RELEASE_FRAMEWORKS_DIRECTORY
    if archType == 1:
        export_release_frameworkds_dir = export_release_frameworkds_dir + "os/"
    else:
        export_release_frameworkds_dir = export_release_frameworkds_dir + "simulator/"

    mkdirCmd = "mkdir " + export_release_frameworkds_dir
    process = subprocess.Popen(mkdirCmd, shell = True)
    process.wait()

    for target in EXPORT_TARGETS_LIST:
        copyCmd = ""
        if archType == 1:
            copyCmd = "cp -r build/" + CONFIGURATION + "-iphoneos/" + target + ".framework " + export_release_frameworkds_dir
        else:
            copyCmd = "cp -r build/" + CONFIGURATION + "-iphonesimulator/" + target + ".framework " + export_release_frameworkds_dir
        process = subprocess.Popen(copyCmd, shell = True)
        process.wait()
    print "copyFrameworks end..."

#mergeframeworks
def mergeArchFrameworks():

    export_os_frameworkds_dir = EXPORT_RELEASE_FRAMEWORKS_DIRECTORY + "os/"
    export_simulator_frameworkds_dir = EXPORT_RELEASE_FRAMEWORKS_DIRECTORY + "simulator/"
    export_merge_frameworkds_dir = EXPORT_RELEASE_FRAMEWORKS_DIRECTORY + "merge/"
    
    mkdirCmd = "mkdir " + export_merge_frameworkds_dir
    process = subprocess.Popen(mkdirCmd, shell = True)
    process.wait()

    #lipo merge target
    for target in EXPORT_TARGETS_LIST:
        #copy framwork
        copyCmd = "cp -r " + export_os_frameworkds_dir + target + ".framework " + export_merge_frameworkds_dir
        process = subprocess.Popen(copyCmd, shell = True)
        process.wait()
        #merge arch
        exportCmd = "lipo -output " + export_merge_frameworkds_dir + target + ".framework/" + target + " -create " + export_os_frameworkds_dir + target + ".framework/" + target + " " + export_simulator_frameworkds_dir + target + ".framework/" + target
        process = subprocess.Popen(exportCmd, shell = True)
        process.wait()
    #update framework files import
    # updateFileContent(export_merge_frameworkds_dir + "UpArpuNative.framework/Headers/UPArpuNativeADDelegate.h", "#import \"UPArpuAdLoadingDelegate.h\"", "@import UpArpuSDK;")
    # updateFileContent(export_merge_frameworkds_dir + "UpArpuRewardedVideo.framework/Headers/UPArpuRewardedVideoDelegate.h", "#import \"UPArpuAdLoadingDelegate.h\"", "@import UpArpuSDK;")

    #delete exclude files from framework
#    deleteCmd = "rm " + export_merge_frameworkds_dir + "UpArpuSDK.framework/check_build_files.py"
#    process = subprocess.Popen(deleteCmd, shell = True)
#    process.wait()
#
#    deleteCmd = "rm " + export_merge_frameworkds_dir + "UpArpuSDK.framework/Assets.car"
#    process = subprocess.Popen(deleteCmd, shell = True)
#    process.wait()

#修改文件内容
def updateFileContent(filePath, contentOld, contentNew):
    file_data = ""
    with open(filePath,'r') as r:
        lines=r.readlines()
    with open(filePath,'w') as w:
        for l in lines:
            w.write(l.replace(contentOld,contentNew))

def main():
    cleanLastReleaseFile()
    #1:os arch,2:simulator arch
    buildSDKTarget(1)
    copyFrameworks(1)
    buildSDKTarget(2)
    copyFrameworks(2)
    mergeArchFrameworks()


if __name__ == '__main__':
    main()

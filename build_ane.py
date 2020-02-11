#!/usr/bin/env python
# -*- coding:utf-8 -*-

import subprocess
import os

UPARPU_VERSION = "3.5.0"
RELEASE_DIRECTORY = "ane_release"
# target list
# TARGETS_LIST = ['ane_build', 'adapter_adcolony', 'adapter_admob', 'adapter_applovin', 'adapter_baidu', 'adapter_chartboost'                # Native Adapters
#                 , 'adapter_facebook', 'adapter_flurry', 'adapter_gdt', 'adapter_inmobi', 'adapter_ironsource', 'adapter_maio', 'adapter_mintegral', 'adapter_mobpower', 'adapter_nend', 'adapter_oneway', 'adapter_tapjoy', 'adapter_toutiao'                # Rewarded Video Adapters
#                 , 'adapter_uniplay', 'adapter_unityads', 'adapter_vungle']
TARGETS_LIST = ['ane_build','adapter_admob','adapter_facebook','adapter_mintegral','adapter_nend', 'adapter_maio', 'adapter_toutiao', 'adapter_unityads']


def build_ane():
    for target in TARGETS_LIST:
        cdCmd = "pwd"
        print cdCmd
        # process = subprocess.Popen(cdCmd, shell = True)
        # process.wait()
        os.chdir(target)
        process = subprocess.Popen(cdCmd, shell=True)
        process.wait()
        buildCmd = "sh make_ane.sh"
        print buildCmd
        process = subprocess.Popen(buildCmd, shell=True)
        process.wait()
        cpCmd = "cp  *.ane ../ane_release "
        print cpCmd
        process = subprocess.Popen(cpCmd, shell=True)
        process.wait()
        cdCmd = "cd .."
        print cdCmd
        os.chdir("..")
        process = subprocess.Popen(cdCmd, shell=True)
        process.wait()


def main():
    build_ane()


if __name__ == '__main__':
    main()

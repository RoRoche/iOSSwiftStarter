#!/usr/bin/env bash

rm -rf ~/Library/Caches/CocoaPods; rm -rf "`pwd`/Pods/"; rm -rf ~/Library/Developer/Xcode/DerivedData/*; pod deintegrate; pod setup; pod install;

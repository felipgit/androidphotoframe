# Android Photo Frame

This is an atempt to reuse an old Android tablet instead of putting it to trash.

## Requirements
- Android Tablet, in this case Ainol Novo 7 Aurora II
- [Syncthing](https://play.google.com/store/apps/details?id=com.nutomic.syncthingandroid "Syncthing")
- [Photo Slides](https://play.google.com/store/apps/details?id=softick.android.photoframe "Photo Slides")
- [SH Script Runner](https://play.google.com/store/apps/details?id=com.adamioan.scriptrunner "SH Script Runner")
- [Nova Launcher](https://play.google.com/store/apps/details?id=com.teslacoilsw.launcher "Nova Launcher")
- [AutoStart](https://play.google.com/store/apps/details?id=com.autostart "AutoStart")
- [ADB](https://www.xda-developers.com/install-adb-windows-macos-linux/ "ADB")

## Setup
I have used ADB to copy, modify and test. But use what ever method works for you. This guide will not over how to install ADB, see link in requirements.

### Copy some scripts
adb push *.sh /sdcard/

### Install some apps
Either download them from Play Store or from some other place

### Run some scripts

### hide/show system bar
Thank you [masashi-k](https://masashi-k.blogspot.com/2013/09/hide-show-system-bar-of-android.html "masashi-k blog") for your info.\
Created two simple shell scripts to hide system bar (navigation and notifications) as the app did not do that.\
Add them to SH Script Runner with automations

## Improvments
Some stuff that could be improved or added:\
- Check screen orientation instead of sending two taps
```bash
dumpsys | grep 'SurfaceOrientation' | awk '{ print $2 }'
```

- Fancier update check
Instead of using refresh.txt you could fetch a value from web or other. But works and is simple.

- OpenVPN
Install openvpn client for why not? Add remove support?

## Other
- Format storage
```bash
fdisk /dev/block/avnftli
d 1
o
w
n
p
1
w
mkfs.exfat /dev/block/avnftli1
```

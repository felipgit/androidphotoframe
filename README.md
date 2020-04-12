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
`adb push *.sh /sdcard/`

### Install some apps
Either download them from Play Store or from some other place and run `adb install *.apk`

### Setup some apps
#### Syncthing
Remeber to setup folder to use Send & Receive, else it wont work.\
![Syncthing Send & Receive](Screenshots/syncthing_folder_type_send_receive.png)
#### Photo Slides
`/data/data/softick.android.photoframe/shared_prefs/softick.android.photoframe_preferences.xml`
what it does
Short cut on desktop
#### SH Script Runner
Add scripts
Show automations
#### Nova Launcher
Set default
#### AutoStart
Add auto start applications

### Get touch coordinates
Run `getevent -l` and press CTRL+C after touching the display\
Look foor POSITION_X and POSITION_Y:
```
/dev/input/event4: EV_ABS       ABS_Z                000000d7            
/dev/input/event4: EV_SYN       SYN_REPORT           00000000            
/dev/input/event5: EV_ABS       ABS_MT_POSITION_X    00000142            
/dev/input/event5: EV_ABS       ABS_MT_POSITION_Y    000000b9            
/dev/input/event5: EV_ABS       ABS_MT_TOUCH_MAJOR   000000c8      
```
Take that value and convert from HEX to DEC. Example 142 in HEX = 322 DEC.\
Change these values in `framenewpictures.sh` for lines where `input tap`:
```bash
input tap XXX YYY # landscape
input tap XXX YYY # portrait
```

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

- Updater
Have a script run from syncthing folder to run remote updates.

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

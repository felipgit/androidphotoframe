#!/system/bin/sh

### variables
dir="/sdcard/DCIM/Camera/"
fileid=0
newpic=0
appname="softick.android.photoframe"
database="/data/data/softick.android.photoframe/databases/PhotoFrameDB"

### functions

# get pid from running app instance
pid () {
    ps | grep $appname | awk '{print $2}'
}

# start new app instance
frame () {
    #monkey -p $appname 1 # not as stable as tap as app seems to crash/not load data when started via this method
    input tap 521 266 # landscape
    input tap 463 284 # portrait
}

# wake screen if off
wakeup () {
    input keyevent KEYCODE_WAKEUP 
}

# fetch if app gives errors
errors () {
    logcat -d | tail -n 20  | grep softick | grep System.err | sort -u
}

### script

# output in log
date

# if find errors, restart device
if [[ "$(errors)" != "" ]]
  then
    echo error found, restart app
    reboot
fi

# if refresh.txt contains yes reload new pictures
if [[ $(cat ${dir}refresh.txt) == "yes" ]]
  then
    # delete old file list
    sqlite3 $database "delete from files"
    # get new file list and add
    for pic in $(ls $dir)
      do
        ((fileid++))
        # insert file entry to sqlite database
        sqlite3 $database "insert into files(fileID,foldID,path,name,date,orientHor,square,file_check) values($fileid,1,'$dir$pic','$pic','1970:01:01 00:00:01',0,0,1);"
        # if new picture added, will trigger reload
        newpic=1
      done

    if [[ "$newpic" == 1 ]]
      then
        # output in log
        date
        # reset refresh.txt
        echo no > ${dir}refresh.txt
        # stop running app instance
        kill -9 $(pid)
        # output in log
        sqlite3 $database "select * from files"
        # for some reason give it time
        sleep 3
        # start app via function
        frame
        # wake screen
        wakup
    fi
fi

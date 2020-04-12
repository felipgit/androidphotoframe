#!/system/bin/sh

# enable autostart of crontab daemon
echo "crond -b" > /system/etc/init.d/crond

# set permissions to execute crond script
chmod 755 /system/etc/init.d/crond

# make crontab folders, default location missing
mkdir -p /system/etc/cron.d/crontabs

# add cronjobs
echo '#crontab for root' > /system/etc/cron.d/crontabs/root
echo '*/10 * * * * /sdcard/framenewpictures.sh >> /sdcard/framenewpictures.log' >> /system/etc/cron.d/crontabs/root
echo '0 0 1 * * rm /sdcard/framenewpictures.log' >> /system/etc/cron.d/crontabs/root
crontab /system/etc/cron.d/crontabs/root

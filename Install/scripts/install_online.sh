#!/bin/sh

#Info
DESCRIPTION="This script will import and overwrite online files"

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

echo "Mounting SD-Card"
DRVS="sda0 sdb0"
for i in $DRVS ; do
   if [[ -d /net/mmx/fs/$i ]] ; then
    if [[ -e /net/mmx/fs/$i/online ]] ; then
     on -f mmx mount -u /net/mmx/fs/$i
	 on -f rcc mount -u /net/mmx/fs/$i
     export SDCARD=/net/mmx/fs/$i
	fi
   fi
done

echo "Mounting app folder"
mount -u /net/mmx/mnt/app

echo "Copying and overwriting files"
new_jar_files=`ls $SDCARD/Custom/Online | grep .jar`
for new_jar_file in $new_jar_files
do
	old_jar=`ls /net/mmx/mnt/app/eso/bundles/$new_jar_file`
	if [[ ! -z "$old_jar"  ]] ; then
		cp -fV $SDCARD/Custom/Online/$new_jar_file $old_jar
	fi
done

echo "Copying special OnlineMenu to unit"
cp -V $SDCARD/Custom/Online/OnlineMenu.esd /net/mmx/mnt/app/eso/hmi/engdefs/OnlineMenu.esd

echo "Done"
sync; sync; sync;

exit 0
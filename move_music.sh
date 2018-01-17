#/bin/bash

##  "%N" "%L" "%F" "%R" "%D" "%C" "%Z" "%T" "%I"

importfile="/home/sophus/Music/Import"

logfile="/home/sophus/Downloads/scripts/torrent.log"

name="$1"
category="$2"
cpath="$3"
rpath="$4"
spath="$5"
files="$6"
size="$7"
tracker="$8"
tHash="$9"

echo "==================== | $(date) | =========================" >> $logfile

echo "Name: '$name'" >> $logfile
echo "Category: '$category'" >> $logfile
echo "Tracker: '$tracker'" >> $logfile
echo "Hash: '$tHash'" >> $logfile

echo "===============================================================================" >> $logfile

if [ "$category" == "do not import" ]; then
    echo "Category is 'do not import'. This torrent will not be imported." >> $logfile
elif [[ "$category" == "old"* ]]; then
    echo "This is an old torrent. Will not be imported" >> $logfile
elif [ "$category" == "musikk" ]; then
    cp "$cpath/" "$importfile/" -r
    echo "Category is musikk. Copied to '$importfile'" >> $logfile
elif [[ "$tracker" == *"apollo"* ]]; then
    cp "$cpath/" "$importfile" -r
    echo "Tracker is apollo. Copied to '$importfile'" >> $logfile
else
	echo "This torrent was not copied to '$importfile'" >> $logfile
fi

echo "" >> $logfile


#/bin/bash

importFolder="~/Music/Import"

logfile="~/Downloads/scripts/logs/$(date +%Y-%m)_downloads.csv"

                ## Parameters for qBittorrent
name="$1"       ## "%N"
category="$2"   ## "%L"
cpath="$3"      ## "%F"
rpath="$4"      ## "%R"
spath="$5"      ## "%D"
files="$6"      ## "%C"
size="$7"       ## "%Z"
tracker="$8"    ## "%T"
tHash="$9"      ## "%I"
## Todo: add tag support when implemented in qBittorrent

## CSV format for logfile
## Date, Name, Hash, Category, Size, Imported(1/0)

output="$(date +%c), '$name', '$hash', '$category', '$size',"

if [[ "$category" == "do not import" ]]; then
    copy=false
elif [[ "$category" == "old"* ]]; then
    copy=false
elif [[ "$category" == "musikk" ]]; then
    copy=true
elif [[ "$tracker" == *"apollo"* ]]; then
    copy=true
else
    copy=false
fi

output+=copy

if [ $copy == true ]; then
    cp "$cpath/" "$importFolder/" -r
fi

echo output >> $logfile

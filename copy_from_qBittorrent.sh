#!/bin/bash

## /path/to/copy_from_qBittorrent.sh "%N" "%L" "%F" "%R" "%D" "%C" "%Z" "%T" "%I" "%G"

logFile="/path/to/logs/$(date +%Y-%m)_downloads.csv"

                    ## Parameters for qBittorrent
name="$1"           ## "%N"
category="$2"       ## "%L"
contentPath="$3"    ## "%F"
rootPath="$4"       ## "%R"
savePath="$5"       ## "%D"
files="$6"          ## "%C"
size="$7"           ## "%Z"
tracker="$8"        ## "%T"
torrentHash="$9"    ## "%I"
tags="$10"          ## "%G"

## CSV format for logfile
## Date, Name, Hash, Category, Size, Tags

output="$(date +%c), '$name', $torrentHash, '$category', $size, "

series=false
film=false
public=false

if [[ "$category" == "serier" ]]; then
    series=true
elif [[ "$category" == "film" ]]; then
    film=true
fi

if [[ "$tags" == *"public"* ]]; then
    public=true
elif [[ "$tracker" == *"t-ru.org"* ]]; then
    public=true
elif [[ "$tracker" == *"openbittorrent.com"* ]]; then
    public=true
elif [[ "$tracker" == *"rarbg.com"* ]]; then
    public=true
elif [[ "$tracker" == *"zer0day.to"* ]]; then
    public=true
elif [[ "$tracker" == *"leechers-paradise.org"* ]]; then
    public=true
elif [[ "$tracker" == *"coppersurfer.tk"* ]]; then
    public=true
elif [[ "$tracker" == *"1337x.org"* ]]; then
    public=true
elif [[ "$tracker" == *"piratebay"* ]]; then
    public=true
fi

if [[ "$category" == "musikk" ]]; then
    music=true
elif [[ "$category" == "do not import" ]]; then
    music=false
elif [[ "$category" == "old"* ]]; then
    music=false
elif [[ "$tracker" == *"flacsfor.me"* ]]; then
    music=true
    public=false
elif [[ "$tracker" == *"home.opsfet.ch"* ]]; then
    music=true
    public=false
else
    music=false
fi

output+=$tags

if [ $public ]; then
    if [ $music ]; then
        /usr/bin/beet -v --config=~/.config/beets/downloads.yaml im --flat "$contentPath"
    elif [ $series ]; then
        mv "$contentPath/" "~/Series/"
    elif [[ $film ]]; then
        mv "$contentPath/" "~/Videos/"
    fi
else
    if [ $music ]; then
        /usr/bin/beet -v --config=~/.config/beets/downloads.yaml im --flat "$contentPath"
    elif [ $series ]; then
        cp "$contentPath/" "~/Series/" -r
    elif [[ $film ]]; then
        cp "$contentPath/" "~/Videos/" -r
    fi
fi

if [ ! -e "$logFile" ] ; then
    touch "$logFile"
fi

echo $output >> $logFile

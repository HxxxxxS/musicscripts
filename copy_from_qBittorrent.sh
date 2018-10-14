#!/bin/bash

importFolder="/home/user/Music/Import"

logFile="/home/user/Downloads/scripts/logs/$(date +%Y-%m)_downloads.csv"

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

if [[ "$category" == "do not import" ]]; then
    music=false
elif [[ "$category" == "old"* ]]; then
    music=false
elif [[ "$category" == "redacted" ]]; then
    music=true
elif [[ "$category" == "musikk" ]]; then
    music=true
elif [[ "$tracker" == *"flacsfor.me"* ]]; then
    music=true
elif [[ "$tracker" == *"apollo"* ]]; then
    music=true
else
    music=false
fi

if [[ "$category" == "serier" ]]; then
    series=true
elif [[ "$category" == "film" ]]; then
    film=true
fi

public=false

if [[ "$tags" == *"public"* ]]; then
    public=true
elif [[ "$tracker" == *"t-ru.org"* ]]; then
    public=true
elif [[ "$tracker" == *"openbittorrent.com"* ]]
    public=true
elif [[ "$tracker" == *"rarbg.com"* ]]
    public=true
elif [[ "$tracker" == *"zer0day.to"* ]]
    public=true
elif [[ "$tracker" == *"leechers-paradise.org"* ]]
    public=true
elif [[ "$tracker" == *"coppersurfer.tk"* ]]
    public=true
elif [[ "$tracker" == *"1337x.org"* ]]
    public=true
elif [[ "$tracker" == *"piratebay"* ]]
    public=true
fi

output+=$tags

if [[ $public ]]; then
    if [ $music ]; then
        mv "$contentPath/" "$importFolder/"
    elif [ $series ]; then
        mv "$contentPath/" "~/Series/"
    elif [[ $film ]]; then
        mv "$contentPath/" "~/Videos/"
    fi
else
    if [ $music ]; then
        cp "$contentPath/" "$importFolder/" -r
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

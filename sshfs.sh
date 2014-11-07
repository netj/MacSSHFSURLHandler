#!/usr/bin/env bash
# sshfs.sh -- A handy way to mount remote hosts on a Mac
# Usage: sshfs.sh HOST:PATH [LOCAL_PATH] [OPTIONS for sshfs]
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2012-12-15

[ $# -gt 0 ] || { sed -n "2,/^#$/ s/^# //p" <"$0"; exit 2; }

# import environment for sshfs
PATH=$(
    ! [ -r ~/.bash_profile ] || source ~/.bash_profile
    ! [ -r ~/.bashrc       ] || source ~/.bashrc
    echo "$PATH"
    )

set -eu

# process arguments
hostpath=$1; shift
case $hostpath in
    sshfs://*|sftp://*)
        hostpath=${hostpath#*://}
        hostpath=${hostpath/\//:}
        ;;
    *:*) ;;
    *)
        hostpath=${hostpath/\//:}
        ;;
esac

# decide some names, paths
host=${hostpath%%:*}
path=${hostpath#$host}
path=${path#:}
shorthost=${host%%.*}
shortpath=$(basename "${path:-home}")
volname="$shorthost $shortpath"
if [ $# -gt 0 ]; then
    mountpoint=$1; shift
else
    mountpoint=/Volumes/$shorthost-$shortpath
fi

# sshfs options
opts=(
volname="$volname"
auto_cache
reconnect
intr
transform_symlinks
#relinksa
#idmap=user
#uid=$(id -u)

# do not share connections
ControlMaster=no
ControlPath=none

# use lighter Ciphers and MACs for faster transfers
# See: http://blog.famzah.net/2010/06/11/openssh-ciphers-performance-benchmark/
# See: http://www.damtp.cam.ac.uk/user/ejb48/sshspeedtests.html
# See: https://bbs.archlinux.org/viewtopic.php?id=9107
#Ciphers='arcfour256\,arcfour128\,arcfour\,blowfish-cbc'
#MACs='umac-64@openssh.com\,hmac-md5\,hmac-md5-96\,hmac-sha1'
# osxfuse does not handle escaping comma well
Ciphers='arcfour256'
MACs='umac-64@openssh.com'

"$@"
)

# create the mountpoint and mount it with sshfs
mkdir -p "$mountpoint"
sshfs -o "$(IFS=,; echo "${opts[*]}")" "$host:$path" "$mountpoint"

open "$mountpoint"

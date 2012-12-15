#!/usr/bin/env bash
# sshfs.sh -- A handy way to mount remote hosts on a Mac
# Usage: sshfs.sh HOST:PATH [LOCAL_PATH] [OPTIONS for sshfs]
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2012-12-15

[ $# -gt 0 ] || { sed -n "2,/^#$/ s/^# //p" <"$0"; exit 2; }

# import environment for sshfs
PATH=$(source ~/.bashrc && echo "$PATH")

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
path=${hostpath#$host:}
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
#reconnect
intr
transform_symlinks
#relinksa
#idmap=user
#uid=$(id -u)
"$@"
)

# create the mountpoint and mount it with sshfs
mkdir -p "$mountpoint"
sshfs -o "$(IFS=,; echo "${opts[*]}")" "$hostpath" "$mountpoint"

open "$mountpoint"

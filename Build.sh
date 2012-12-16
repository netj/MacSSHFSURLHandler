cd "`dirname "$0"`"
osacompile -o MacSSHFSURLHandler.app/Contents/Resources/Scripts/main.scpt MacSSHFSURLHandler.applescript
install sshfs.sh MacSSHFSURLHandler.app/Contents/Resources/Scripts/

# An AppleScript for handling sftp, sshfs URLs
# See: http://www.macosautomation.com/applescript/linktrigger/index.html
# See: http://hublog.hubmed.org/archives/001154.html
# See: https://discussions.apple.com/thread/2740930?start=0&tstart=0
# See: http://www.satimage.fr/software/en/smile/external_codes/file_paths.html

on open location theUrl
    set cmd to (quoted form of (get POSIX path of (path to resource "sshfs.sh" in directory "Scripts"))) & " " & theUrl
#    display alert cmd
    do shell script cmd
end open location


# XXX can't get `open sftp://host/path` working
# Some relevant pieces:
# http://developer.apple.com/library/mac/#documentation/cocoa/conceptual/ScriptableCocoaApplications/SApps_handle_AEs/SAppsHandleAEs.html
# http://stackoverflow.com/questions/5812371/how-can-a-mac-app-determine-the-method-used-to-launch-it
# http://stackoverflow.com/questions/3554093/how-to-use-an-applescript-app-bundle-as-the-default-browser-in-os-x
# http://stackoverflow.com/questions/11186497/on-run-argv-and-other-handlers

#on open theFile
#    tell me to run {POSIX path of (path to theFile)}
#end open

#on run argv
#    #using terms from application "ASObjC Runner"
#    #set aString to current application's NSApp's passedValue() as text
#    #set theUrl to aString
#    #display dialog theUrl
#    #end using terms from
#    tell me to open location argv
#end run

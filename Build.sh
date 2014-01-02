cd "`dirname "$0"`"

echo >&2 "Generating MacSSHFSURLHandler.app"
osacompile -o MacSSHFSURLHandler.app MacSSHFSURLHandler.applescript

echo >&2 "Bundling sshfs.sh"
install sshfs.sh MacSSHFSURLHandler.app/Contents/Resources/Scripts/

echo >&2 "Tweaking Info.plist for sshfs: and sftp: URLs"
{
    echo 'g/^<key>CFBundleURLTypes/,/^<\/array>/ d'
    echo '/<key>CFBundleSignature/+1 a'
    echo '<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleURLName</key>
		<string>SFTP Filesystem</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>sshfs</string>
			<string>sftp</string>
		</array>
	</dict>
</array>'
    echo .
    echo wq
} | ed MacSSHFSURLHandler.app/Contents/Info.plist >/dev/null

touch MacSSHFSURLHandler.app

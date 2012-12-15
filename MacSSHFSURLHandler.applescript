# An AppleScript for handling sftp, sshfs URLs
# See: http://hublog.hubmed.org/archives/001154.html
# See: https://discussions.apple.com/thread/2740930?start=0&tstart=0
# See: http://www.satimage.fr/software/en/smile/external_codes/file_paths.html
on open location theUrl
	(*
set theUrl to "sftp://rulk.stanford.edu/lfs/"
	log theUrl
	tell application "System Events"
	display dialog "openning " & theUrl
*)
	set cmd to (quoted form of (get POSIX path of (path to resource "sshfs.sh" in directory "Scripts"))) & " " & theUrl
	--	display dialog cmd
	do shell script cmd
	--	end tell
end open location
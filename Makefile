# Makefile for MacSSHFSURLHandler

APPNAME = MacSSHFSURLHandler
DESTDIR = /Applications

build: $(APPNAME).app
$(APPNAME).app: $(APPNAME).applescript sshfs.sh add-sshfs-URLTypes-to
	osacompile -o $@ $<
	install sshfs.sh $@/Contents/Resources/Scripts/
	./add-sshfs-URLTypes-to $@/Contents/Info.plist
	touch $@

install: $(DESTDIR)/$(APPNAME).app
$(DESTDIR)/$(APPNAME).app: $(APPNAME).app
	ditto $< $@
	touch $@

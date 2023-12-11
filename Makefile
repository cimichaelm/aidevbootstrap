# %W% %G%
# File: Makefile
# Last Modification: yy/mm/dd
# Author: Michael Moscovitch
# Description:
# Project:
# History:
#

PROJECT=aibootstrapdev
PKGNAME=aibootstrapdev
TMPDIR=/var/tmp
DISTDIR=$(TMPDIR)/dist

INSTALL=install
INSTBINFLAGS=-c -m 755
INSTPRVBINFLAGS=-c -m 750
INSTLIBFLAGS=-c -m 644
INSTPRVLIBFLAGS=-c -m 600
INSTDIRFLAGS=-d -m 755
INSTMANFLAGS=-c -m 644
INSTPRVDIRFLAGS=-d -m 750

RM=rm -f
TAR=tar
TAROPTS=-cz --exclude-vcs

PREFIX=$(HOME)
ETCDIR=$(PREFIX)/etc
BINDIR=$(PREFIX)/bin
HOSTNAME=host
OUTDIR=out

SCRIPTS=scripts/*.sh
FILELIST=$(PKGNAME)/Makefile $(PKGNAME)/scripts/*.sh
CONFFILES=conf/*.sh

all: 

install-scripts:
	$(INSTALL) $(INSTBINFLAGS) $(SCRIPTS) $(BINDIR)

install-conf:
	$(INSTALL) $(INSTLIBFLAGS) $(CONFFILES) $(ETCDIR)

install-bin-dir:
	$(INSTALL) $(INSTDIRFLAGS) $(BINDIR)

install-dirs: install-bin-dir
	$(INSTALL) $(INSTDIRFLAGS) $(ETCDIR)

install: install-all

install-all: install-dirs install-scripts install-conf

clean:
	$(RM) ./*~

dist:
	(cd ..; $(TAR) $(TAROPTS) -f $(TMPDIR)/$(PKGNAME).tgz $(PKGNAME))
	(cd ..; zip -r $(TMPDIR)/$(PKGNAME).zip $(FILELIST))

depend:


# Makefile.am
#
# This file is part of fizmo.
#
# Copyright (c) 2009-2012 Christoph Ender.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


AUTOMAKE_OPTIONS = -Wno-override

localedir = $(datarootdir)/fizmo/locales

fizmo_build_prefix=$(DEV_BUILD_PREFIX)

PKG_DIR = $(fizmo_build_prefix)/lib/pkgconfig
PKGFILE = $(PKG_DIR)/libcellif.pc

SUBDIRS = src/cell_interface .
noinst_LIBRARIES = libcellif.a

libcellif.a:
	cd src/cell_interface ; make
	mv src/cell_interface/libcellif.a .

install-dev:: libcellif.a
	mkdir -p "$(fizmo_build_prefix)"/lib/fizmo
	mkdir -p "$(fizmo_build_prefix)"/include/fizmo/cell_interface
	cp src/cell_interface/*.h \
	  "$(fizmo_build_prefix)"/include/fizmo/cell_interface
	cp libcellif.a "$(fizmo_build_prefix)"/lib/fizmo
	cp src/screen_interface/screen_cell_interface.h \
	  "$(fizmo_build_prefix)"/include/fizmo/screen_interface
	mkdir -p "$(PKG_DIR)"
	echo 'prefix=$(fizmo_build_prefix)' >"$(PKGFILE)"
	echo 'exec_prefix=$${prefix}' >>"$(PKGFILE)"
	echo 'libdir=$${exec_prefix}/lib/fizmo' >>"$(PKGFILE)"
	echo 'includedir=$${prefix}/include/fizmo' >>"$(PKGFILE)"
	echo >>"$(PKGFILE)"
	echo 'Name: libcellif' >>"$(PKGFILE)"
	echo 'Description: libcellif' >>"$(PKGFILE)"
	echo 'Version: 0.7.5' >>"$(PKGFILE)"
	echo 'Requires: libfizmo >= 0.7.4 ' >>"$(PKGFILE)"
	echo 'Requires.private:' >>"$(PKGFILE)"
	echo 'Cflags: -I$(fizmo_build_prefix)/include/fizmo ' >>"$(PKGFILE)"
	echo 'Libs: -L$(fizmo_build_prefix)/lib/fizmo -lcellif'  >>"$(PKGFILE)"
	echo >>"$(PKGFILE)"

install-locales::
	mkdir -p "$(DESTDIR)$(localedir)"
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p "$(DESTDIR)$(localedir)/$$l" ; \
	  cp src/locales/$$l/*.txt "$(DESTDIR)$(localedir)/$$l" ; \
	done


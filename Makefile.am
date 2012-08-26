
AUTOMAKE_OPTIONS = -Wno-override

localedir = $(datarootdir)/fizmo/locales

if FIZMO_BUILD_PREFIX_EMPTY
  fizmo_build_prefix=$(DESTDIR)$(prefix)
endif

PKG_DIR = $(fizmo_build_prefix)/lib/pkgconfig
PKGFILE = $(PKG_DIR)/libcellif.pc

SUBDIRS = src/cell_interface .
noinst_LIBRARIES = libcellif.a

libcellif.a:
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
	echo 'Version: 0.7.4' >>"$(PKGFILE)"
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



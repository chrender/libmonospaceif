
.PHONY : all install clean distclean

include config.mk

PKG_DIR = $(INSTALL_PREFIX)/lib/pkgconfig
PKGFILE = $(PKG_DIR)/libcellif.pc


all: libcellif.a

libcellif.a: src/cell_interface/libcellif.a
	mv src/cell_interface/libcellif.a .

src/cell_interface/libcellif.a::
	cd src/cell_interface ; make

install: src/cell_interface/libcellif.a
	mkdir -p $(INSTALL_PREFIX)/lib/fizmo
	mkdir -p $(INSTALL_PREFIX)/include/fizmo/cell_interface
	cp src/cell_interface/*.h $(INSTALL_PREFIX)/include/fizmo/cell_interface
	cp src/cell_interface/libcellif.a $(INSTALL_PREFIX)/lib/fizmo
	cp src/screen_interface/screen_cell_interface.h \
	  $(INSTALL_PREFIX)/include/fizmo/screen_interface
	mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	  cp src/locales/$$l/*.txt $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	done
	mkdir -p $(PKG_DIR)
	echo 'prefix=$(INSTALL_PREFIX)' >$(PKGFILE)
	echo 'exec_prefix=$${prefix}' >>$(PKGFILE)
	echo 'libdir=$${exec_prefix}/lib/fizmo' >>$(PKGFILE)
	echo 'includedir=$${prefix}/include/fizmo' >>$(PKGFILE)
	echo >>$(PKGFILE)
	echo 'Name: libcellif' >>$(PKGFILE)
	echo 'Description: libcellif' >>$(PKGFILE)
	echo 'Version: 0.7.0-b8' >>$(PKGFILE)
	echo 'Requires: libfizmo >= 0.7 ' >>$(PKGFILE)
	echo 'Requires.private:' >>$(PKGFILE)
	echo 'Cflags: -I$(INSTALL_PREFIX)/include/fizmo ' >>$(PKGFILE)
	echo 'Libs: -L$(INSTALL_PREFIX)/lib/fizmo -lcellif'  >>$(PKGFILE)
	echo >>$(PKGFILE)

clean::
	cd src/cell_interface ; make clean
	cd src/locales ; make clean

distclean:: clean
	rm -f libcellif.a
	cd src/cell_interface ; make distclean


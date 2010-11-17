
.PHONY : all install clean distclean

include config.mk

TMPLIBDIR = libfizmotmp

all: src/cell_interface/libcellif.a libcellif.mk

install: src/cell_interface/libcellif.a libcellif.mk
	mkdir -p $(INSTALL_PREFIX)/lib/fizmo
	cp libcellif.mk $(INSTALL_PREFIX)/include/fizmo
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

clean::
	cd src/cell_interface ; make clean
	cd src/locales ; make clean

distclean:: clean
	rm -f libcellif.mk
	cd src/cell_interface ; make distclean

libcellif.mk::
	echo > libcellif.mk
	echo LIBCELLIF_INC_DIRS = -I$(INSTALL_PREFIX)/include/fizmo >> libcellif.mk
	echo LIBCELLIF_LIB_DIRS = -L$(INSTALL_PREFIX)/lib/fizmo >> libcellif.mk
	echo LIBCELLIF_LIBS = -lcellif >> libcellif.mk
	echo >> libcellif.mk

src/cell_interface/libcellif.a::
	cd src/cell_interface ; make


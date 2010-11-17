
.PHONY : clean

include ../../config.mk
include $(FIZMO_INC_DIR)/fizmo/libfizmo.mk

ifneq ($(ENABLE_GDB_SYMBOLS),)
override CFLAGS += -g
endif

ifneq ($(ENABLE_OPTIMIZATION),)
override CFLAGS += -O2
endif

ifneq ($(ENABLE_TRACING),)
override CFLAGS += -DENABLE_TRACING=
endif

INC_DIRS = $(LIBFIZMO_INC_DIRS)
LIB_DIRS = $(LIBFIZMO_LIB_DIRS)
LIBS = $(LIBFIZMO_LIBS)

libcellif.a: cell_interface.o ../locales/libcellif_locales.o
	$(AR) rcs libcellif.a cell_interface.o ../locales/libcellif_locales.o

cell_interface.o: cell_interface.h cell_interface.c
	$(CC) $(CFLAGS) $(INC_DIRS) -c cell_interface.c

../locales/libcellif_locales.o::
	cd ../locales ; make

clean:
	rm -f *.o

distclean: clean
	rm -f libcellif.a


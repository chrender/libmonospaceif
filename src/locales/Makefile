
include ../../config.mk

include $(FIZMO_INC_DIR)/fizmo/libfizmo.mk


ifneq ($(ENABLE_GDB_SYMBOLS),)
override CFLAGS += -g
endif

ifneq ($(ENABLE_OPTIMIZATION),)
override CFLAGS += -O2
endif


.PHONY : clean

all: libcellif_locales.o


libcellif_locales.o: libcellif_locales.c
	$(CC) $(CFLAGS) -I$(FIZMO_INC_DIR) -c libcellif_locales.c

clean:
	rm -f *.o


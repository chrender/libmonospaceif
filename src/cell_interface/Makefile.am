
AM_CFLAGS = $(libfizmo_CFLAGS)
AM_CPPFLAGS =
LDADD = $(libfizmo_LIBS)

localedir = $(datarootdir)/fizmo/locales

noinst_LIBRARIES = libcellif.a
libcellif_a_SOURCES = ../locales/libcellif_locales.c cell_interface.c

if ENABLE_TRACING
AM_CFLAGS += -DENABLE_TRACING=
endif


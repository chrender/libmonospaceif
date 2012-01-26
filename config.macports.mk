
CC = gcc
AR = ar
override CFLAGS += -Wall -Wextra

prefix = /opt/local
destprefix = $(DESTDIR)$(prefix)
bindir = $(destprefix)/bin
datarootdir = $(destprefix)/share
mandir = $(datarootdir)/man
localedir = $(datarootdir)/fizmo/locales


# -----
# General settings:
ENABLE_OPTIMIZATION = 1
#ENABLE_TRACING = 1
#ENABLE_GDB_SYMBOLS = 1
# -----



#[[

  CMakeLists.txt

  This file is part of fizmo.

  ---

  Copyright (c) 2010-2025 Christoph Ender.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
  3. Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived
  from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  ---

  This is libmonospaceif's main buildfile. There is another one location
  in "src/locales" which is invoked by this one. The one in "src/locales"
  will pre-process the locales into a ".c" source file, so that they can
  be "hard-compiled" into libmonospaceif, which solves a lot of problem
  with handling of external files and makes debugging in IDEs much simpler.

  Compile-time options are described individually below.

]]


cmake_minimum_required(VERSION 3.10)


# Enable external commands so it's possible to build the tools which will
# in turn create the ".h" and ".c" files required for the main build first.
include(ExternalProject)

# Enable CMake-based evaluation of pkg-config files.
include(FindPkgConfig)


project(libmonospaceif
  LANGUAGES C
  HOMEPAGE_URL https://fizmo.spellbreaker.org
  DESCRIPTION "fizmo interpreter monospace interface library"
  VERSION 0.9.0)


# Don't prepend libname with "lib". This will make it possible to use the
# name defined in project() above via "${PROJECT_NAME}" without having
# to alternate between "libmonospaceif" and "monospaceif" in various
# statements. Furthermore, it will allow distinguishing between "libfizmo"
# and "fizmo" projects and have "CMAKE_STATIC_LIBRARY_PREFIX" set to the
# same value in all fizmo-related projects.
set(CMAKE_STATIC_LIBRARY_PREFIX "")


# Create position-independent code.
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


# Invoke build and run tool for processing of locales into "locale_data.c"
# so that this file can be used in this build.
ExternalProject_Add(locale_data_preparation
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/locales
  BINARY_DIR ${CMAKE_BINARY_DIR}/loacles_build
  CMAKE_ARGS
  ${GLOBAL_DEFAULT_ARGS}
  ${GLOBAL_THIRDPARTY_LIB_ARGS}
  BUILD_COMMAND make
  INSTALL_COMMAND cmake -E echo "Skipping install step."
  )

find_package(PkgConfig REQUIRED)


# We need libfizmo >= 0.9.
pkg_check_modules(LIBFIZMO REQUIRED libfizmo>=0.9.0)


# Enabling tracing will cause fizmo to write a really, really large amount
# of debug data to disk while running. Furthermore, after every single
# write, fizmo will invoke an fsync(), meaning that performance will
# quite suffer. This is only useful for debugging and should be disabled
# in all other cases.
option(ENABLE_TRACING "Enable tracing" OFF)
if (ENABLE_TRACING)
  add_definitions(-DENABLE_TRACING)
endif()


# Should always be off at the moment, since the debugger isn't
# implemented.
option(ENABLE_DEBUGGER "Enable debugger" OFF)
if (ENABLE_DEBUGGER)
  add_definitions(-DENABLE_DEBUGGER)
endif()


# In case of a distribution build, this should be set to fizmo's main
# version number, so it's possible to distinguish libfizmo's version
# from the main fizmo version.
option(FIZMO_DIST_VERSION "Set fizmo-dist version" OFF)
if (FIZMO_DIST_VERSION)
  add_definitions(-DFIZMO_DIST_VERSION=${FIZMO_DIST_VERSION})
endif()


# Store filenames of all files-to-be-compiled in "C_FILES".
set (c_sources
  src/monospace_interface/monospace_interface.c
  src/locales/libmonospaceif_locales.c
  src/locales/locale_data.c
  src/locales/locale_data.h)


# Tell CMake we'd like to create a library named "libmonospaceif" with the
# given ".c" files.
add_library(libmonospaceif ${c_sources})

target_include_directories(libmonospaceif PUBLIC
  ${LIBFIZMO_INCLUDE_DIRS})


#install(TARGETS libmonospaceif)
# PUBLIC_HEADER cannot be used for TARGETS fizmo, since it doesn't keep
# the directory tree and installs all *.h flat into "include/". So:


install(DIRECTORY "${PROJECT_SOURCE_DIR}/src/" # source directory
  DESTINATION "include" # target directory
  FILES_MATCHING # install only matched files
  PATTERN "*.h" # select header files
)


install(TARGETS libmonospaceif)


set(pc_libs_private)
set(pc_req_private)
configure_file(src/libmonospaceif.pc.in libmonospaceif.pc @ONLY)


install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc
  DESTINATION "lib/pkgconfig")


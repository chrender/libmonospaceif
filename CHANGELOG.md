


   **Version 0.7.14 — April 8, 2017**

 - Adapted to replacement of en_US locale with en_GB from libfizmo.

---


   **Version 0.7.13 — October 8, 2016**

 - Improved build system for separate library and interface builds.

---


   **Version 0.7.12 — August 31, 2016**

 - Renamed “libcellif” to “libmonospaceif”.
 - Use tiny-xml-doc-tools for documentation.

---


   **Version 0.7.11 — July 28, 2016**

 - Add list of config options from registered output interface to list of options returned from “get_config_option_names”.

---


   **Version 0.7.10 — October 9, 2015**

 - Fixed score/turns position in statusline for v≤3 games.
 - Minor changes for autoconf settings.

---


   **Version 0.7.9 — May 25, 2014**

 - Fixed erase_window and clearing of lines to conform to spec regarding reverse output.

---


   **Version 0.7.8 — March 19, 2014**

 - Adapted to automake version 1.14.
 - Entire re-implementation of screen refresh and scrolling. Many thanks to Lewis Gentry for bug-reporting and extensive beta-testing.
 - Fixed a crash that would occur in case the history buffer didn't hold enough input for some screen refresh cases.
 - Fixed incorrect backspace or delete behaviour which could cause in crash in case of small screen sizes combined with the use of preloaded input.
 - Several small text input fixes.
 - Added “clean-dev” build target for better cleanup of installed development files, which helps debian packaging.
 - Fixed wrong status line display style after restore in v<=3 games.
 - Added missing license/copyright information.

---


   **Version 0.7.7 — June 5, 2013**

 - Renamed “install-locales” to “install-data-local” build target.

---


   **Version 0.7.6 — December 27, 2012**

 - Minor fix for libcell build target.

---


   **Version 0.7.5 — November 30, 2012**

 - Implemented delete in read_line and read_char.
 - CTRL-R will now redraw the screen. Contrary to CTRL-L, which refreshes the screen based on the current layout, CTRL-R will reconstruct the latest output based on the output history. This will help to display output which is hidden in case a game clears the screen, writes some text into the top line and then turns on the score line which then overlays the topmost line.
 - Adapted to new command history interface.

---


   **Version 0.7.4 — September 17, 2012**

 - Adapted to new autoconf / automake build system.

---


   **Version 0.7.3 — August 1, 2012**

 - Merged Andrew Plotkin's iOS-fizmo changes: Adapted to new function “prompt_for_filename” in screen-interface.
 - Fixed screen interface invocation to not use timeout if not actually required by the game.

---


   **Version 0.7.2 — March 9, 2012**

 - Fixed missing $(DESTDIR) variable – should already have been present since version 0.7.1.

---


   **Version 0.7.1 — November 6, 2011**

 - Fixed missing “override” statments for CFLAGS in Makefiles.
 - Fixed $(DESTDIR) evaluation in config.[default|macports].mk.
 - Adapted Makefiles and configuration to use standard GNU Makefile variables instead of INSTALL_PATH and FIZMO_BIN_DIR.

---


   **Version 0.7.0 — September 18, 2011**

 - The “libcellif” interface has been developed out of fizmo's ncursesw interface in version 0.6. It assumes that the screen is up of fixed-width charachter cells – like a standard terminal – and translates all the Z-Machine output operations into “goto-xy”, “print” and similar commands. That means it's possible to implement a cell-based interface without having to worry about window resizes or other Z-Machine related concepts.
 - The “fizmo-ncurses” interface relies on this library for output.



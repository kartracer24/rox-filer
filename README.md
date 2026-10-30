ROX-Filer
=========
A RISC OS-like filer for X
by Thomas Leonard



Quick start
-----------
If you downloaded a source or binary tarball directly, type this ($ is the
shell prompt):

	$ ./ROX-Filer/AppRun

This will compile the filer (if necessary) and then run it.

However, it is more common to use Zero Install or a distribution package. To
get the filer using Zero Install, do:

$ 0alias rox http://rox.sourceforge.net/2005/interfaces/ROX-Filer
$ rox


ROX-Filer
---------
Documentation for ROX-Filer can be found in the directory ROX-Filer/Help.


Building
--------
Prerequisites: gcc, make, pkg-config, autoconf, and the dev packages for
gtk+-2.0, libxml-2.0, sm and ice. Then run:

	$ ./build.sh

This configures out-of-tree (in `ROX-Filer/build/`), compiles, and leaves the
binary at `ROX-Filer/ROX-Filer`. Run it with `./ROX-Filer/AppRun`.

Note for GCC 14+: the legacy menu code triggers `-Wincompatible-pointer-types`
errors; `build.sh` passes `-Wno-error=incompatible-pointer-types` to configure
to restore the old warning-only behaviour.


GTK2 theming
------------
ROX-Filer is a GTK 2 app, so it does not follow your GTK 3 theme automatically.
The `themes/` directory ships a GTK 2 port of the Materia dark theme
(`Material-BL-LB-Dark`) with the unavailable `murrine`/`adwaita` engine
dependencies removed — it renders using pixmap assets and colors only.

To run ROX-Filer with it:

	$ GTK2_RC_FILES=$PWD/themes/Material-BL-LB-Dark-gtk2/gtkrc ./ROX-Filer/AppRun

To apply it to all GTK 2 apps, add this to `~/.gtkrc-2.0`:

	gtk-theme-name="Material-BL-LB-Dark"

(then copy or symlink `themes/Material-BL-LB-Dark-gtk2` to
`~/.themes/Material-BL-LB-Dark`).


Conditions
----------
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


Please report any bugs to the [rox-devel mailing list](http://rox.sourceforge.net/desktop/lists).

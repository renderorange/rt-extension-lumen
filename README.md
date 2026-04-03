# NAME

RT-Extension-Lumen

# DESCRIPTION

Lumen is a minimal, modern, and lightweight theme for RT.

# RT VERSION

Works with RT 6.0.0 and newer.

# INSTALLATION

- `perl Makefile.PL`
- `make`
- `make install`

- Edit your `/opt/rt6/etc/RT_SiteConfig.pm`

    Add this line:

        Plugin( 'RT::Extension::Lumen' );

- Clear your mason cache

        rm -rf /opt/rt6/var/mason_data/obj

- Restart your webserver

# FEATURES

Lumen rewrites RT's frontend from the ground up to:

- remove dependencies on the RT elevator themes
- replace the top and sub navigation menus with a single sidebar navigation menu
- simplify the user interface with minimal, unobtrusive, and uniform UI elements
- update light and dark modes with softer colors

Lumen still supports modern RT features like inline edit and htmx, but strips away complexity for a simplified and accessible user experience.

# BUGS AND FEATURE REQUESTS

Please report bugs and feature requests at [GitHub](https://github.com/renderorange/rt-extension-lumen/issues).

# AUTHOR

Blaine Motsinger <blaine@renderorange.com>

# LICENSE AND COPYRIGHT

Copyright (c) 2026 Blaine Motsinger

This is free software, licensed under:

    The GNU General Public License, Version 2, June 1991


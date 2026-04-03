use strict;
use warnings;
package RT::Extension::Lumen;

our $VERSION = '0.001';

=pod

=head1 NAME

RT-Extension-Lumen

=head1 DESCRIPTION

Lumen is a minimal, modern, and lightweight theme for RT.

=head1 RT VERSION

Works with RT 6.0.0 and newer.

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

=item Edit your F</opt/rt5/etc/RT_SiteConfig.pm>

Add this line:

    Plugin( 'RT::Extension::Lumen' );

=item Clear your mason cache

    rm -rf /opt/rt6/var/mason_data/obj

=item Restart your webserver

=back

=head1 FEATURES

Lumen rewrites RT's frontend from the ground up to:

=over

=item remove dependencies on the RT elevator themes

=item replace the top and sub navigation menus with a single sidebar navigation menu

=item simplify the user interface with minimal, unobtrusive, and uniform UI elements

=item update light and dark modes with softer colors

=back

Lumen still supports modern RT features like inline edit and htmx, but strips away complexity for a simplified and accessible user experience.

=head1 BUGS AND FEATURE REQUESTS

Please report bugs and feature requests at L<GitHub|https://github.com/renderorange/rt-extension-lumen/issues>.

=head1 AUTHOR

Blaine Motsinger E<lt>blaine@renderorange.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2026 Blaine Motsinger.

This is free software, licensed under:

    The GNU General Public License, Version 2, June 1991

=cut

1;

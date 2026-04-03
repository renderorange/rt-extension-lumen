use strict;
use warnings;
use Test::More tests => 2;
use lib 'lib';

BEGIN {
    use_ok('RT::Extension::Lumen') or BAIL_OUT("Cannot load RT::Extension::Lumen");
}

diag("Testing RT::Extension::Lumen $RT::Extension::Lumen::VERSION");

# Check that VERSION is defined and looks valid
like($RT::Extension::Lumen::VERSION, qr/^\d+\.\d+$/, 'VERSION is in major.minor format');

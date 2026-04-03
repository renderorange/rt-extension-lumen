use strict;
use warnings;
use Test::More;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

plan tests => 3;

# Helper to read file
sub read_file {
    my ($file) = @_;
    open my $fh, '<', $file or return undef;
    local $/;
    my $content = <$fh>;
    close $fh;
    return $content;
}

# Read version from main module
my $module_content = read_file('lib/RT/Extension/Lumen.pm');
my ($module_version) = $module_content =~ /our \$VERSION = '([\d.]+)'/;

ok(defined $module_version, "Found version in Lumen.pm: $module_version");

# Read version from META.yml
my $meta_content = read_file('META.yml');
my ($meta_version) = $meta_content =~ /^version:\s*['"]?([\d.]+)['"]?$/m;

ok(defined $meta_version, "Found version in META.yml: $meta_version");

# Compare versions
is($module_version, $meta_version, "Version is consistent across files ($module_version)");

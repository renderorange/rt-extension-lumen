use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

my @js_files;
find(sub {
    return unless -f $_;
    return unless /\.js$/;
    push @js_files, $File::Find::name;
}, 'static');

if (!@js_files) {
    plan skip_all => 'No JavaScript files found';
}

# Check if node is available
my $have_node = `which node 2>/dev/null`;
chomp $have_node if $have_node;

plan tests => scalar(@js_files);

foreach my $file (@js_files) {
    SKIP: {
        skip "node not installed", 1 unless $have_node;
        
        my $output = `node --check "$file" 2>&1`;
        my $exit_code = $? >> 8;
        
        ok($exit_code == 0, "JavaScript syntax check passed: $file")
            or diag($output);
    }
}

use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

my @css_files;
find(sub {
    return unless -f $_;
    return unless /\.css$/;
    push @css_files, $File::Find::name;
}, 'static');

if (!@css_files) {
    plan skip_all => 'No CSS files found';
}

# Check if csslint is available
my $have_csslint = `which csslint 2>/dev/null`;
chomp $have_csslint if $have_csslint;

plan tests => scalar(@css_files);

foreach my $file (@css_files) {
    SKIP: {
        skip "csslint not installed", 1 unless $have_csslint;
        
        my $output = `csslint --format=compact "$file" 2>&1`;
        my $exit_code = $? >> 8;
        
        ok($exit_code == 0, "csslint passed: $file")
            or diag($output);
    }
}

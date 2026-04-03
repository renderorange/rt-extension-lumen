use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

my @perl_files;
find(sub {
    return unless -f $_;
    return unless /\.pm$/;
    push @perl_files, $File::Find::name;
}, 'lib');

plan tests => scalar(@perl_files) * 2;

foreach my $file (@perl_files) {
    my $output = `perl -c "$file" 2>&1`;
    my $exit_code = $? >> 8;
    
    ok($exit_code == 0, "Syntax check: $file");
    
    SKIP: {
        skip "perlcritic not installed", 1 
            unless eval { require Perl::Critic; 1 };
        
        my $critic = Perl::Critic->new(-severity => 5);
        my @violations = $critic->critique($file);
        
        is(scalar @violations, 0, "No perlcritic violations (gentle) in $file")
            or diag(join("\n", @violations));
    }
}

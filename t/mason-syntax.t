use strict;
use warnings;
use Test::More;
use File::Find;
use File::Spec;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

my @mason_files;
find(sub {
    return unless -f $_;
    # Mason components in html/
    return unless /^[A-Z]/ && !/\./;  # Components start with capital letter, no extension
    push @mason_files, $File::Find::name;
}, 'html');

plan tests => scalar(@mason_files) * 2;

sub read_file {
    my ($file) = @_;
    open my $fh, '<', $file or return undef;
    local $/;
    my $content = <$fh>;
    close $fh;
    return $content;
}

foreach my $file (@mason_files) {
    my $content = read_file($file);
    
    unless (defined $content) {
        fail("Could not read $file: $!");
        fail("Skipping second test");
        next;
    }
    
    # Test 1: Check that Mason tags are properly balanced
    # Count opening and closing tags
    my @opening_tags = $content =~ /<(\%[A-Za-z_]+)>/g;
    my @closing_tags = $content =~ m{</(%[A-Za-z_]+)>}g;
    
    # Also count simple <% ... %> expressions (excluding comments)
    my @simple_tags = $content =~ /<%(?!#)(?![A-Za-z_]+>)(.+?)%>/gs;
    
    my $tag_count = scalar(@opening_tags) + scalar(@simple_tags);
    
    # For block tags, each opening should have a matching closing
    my $block_balanced = 1;
    foreach my $tag (@opening_tags) {
        my $tag_name = $tag;
        $tag_name =~ s/^%//;
        my $close_pattern = "</%$tag_name>";
        my $open_count = () = $content =~ /<%$tag_name>/g;
        my $close_count = () = $content =~ m{\Q$close_pattern\E}g;
        if ($open_count != $close_count) {
            $block_balanced = 0;
            diag("Unbalanced <%$tag_name> tags in $file: $open_count open, $close_count close");
        }
    }
    
    ok($block_balanced, "Mason block tags balanced in $file");
    
    # Test 2: Check for valid Mason constructs
    my $has_valid_mason = 1;
    my @valid_blocks = qw(doc init args method def flags cleanup once shared filter);
    my @found_issues;
    
    # Check for unknown block types
    while ($content =~ /<%([A-Za-z_]+)>/g) {
        my $tag = lc($1);
        # Skip if it's a component call
        next if $tag =~ /^&/;
        # Skip known valid blocks
        next if grep { $_ eq $tag } @valid_blocks;
        # Skip if it looks like an expression (contains non-alpha)
        next if $tag =~ /[^a-z_]/;
        # Otherwise flag it
        $has_valid_mason = 0;
        push @found_issues, "Unknown Mason tag '<%$1>'";
    }
    
    # Check for malformed component calls
    # Component calls should be <& /path &> or <&| /path &>
    while ($content =~ /<&([^&]+)&>/g) {
        my $call = $1;
        # Basic check that it looks like a path (starts with |, /, $, or word char)
        unless ($call =~ /^(\||\s*\/?[A-Za-z0-9])/ || $call =~ /^\s*\$/) {
            $has_valid_mason = 0;
            push @found_issues, "Malformed component call '<&$call&>'";
        }
    }
    
    if (@found_issues) {
        diag($_) for @found_issues;
    }
    
    ok($has_valid_mason, "Valid Mason constructs in $file");
}

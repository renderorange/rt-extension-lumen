# Minimal stub RT::Handle for CI/dist building
package RT::Handle;

sub cmp_version {
    # Bareword sort form uses $a/$b from caller's package
    my $caller = caller();
    my $a = ${$caller . '::a'};
    my $b = ${$caller . '::b'};
    
    # Fallback to @_ if direct call
    unless (defined $a && defined $b) {
        ($a, $b) = @_;
    }
    
    my @a = split /\./, $a;
    my @b = split /\./, $b;
    for my $i (0..2) {
        return $a[$i] <=> $b[$i] if $a[$i] != $b[$i];
    }
    return 0;
}

1;

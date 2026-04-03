use strict;
use warnings;
use Test::More;

plan skip_all => 'Author testing only' unless $ENV{AUTHOR_TEST};

plan skip_all => 'Test::CheckManifest required' 
    unless eval { require Test::CheckManifest; 1 };

Test::CheckManifest::ok_manifest({
    filter => [qr/\.git/, qr/cover_db/, qr/blib/, qr/\.tar\.gz$/],
});

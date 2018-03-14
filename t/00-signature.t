# -*- mode: perl; coding: us-ascii-unix -*-

#use 5.008;              # for UTF-8 support
use strict;             # restrict unsafe constructs
use warnings;           # control optional warnings
#use utf8;               # enable/disable UTF-8 (or UTF-EBCDIC) in source code

# The following is a modified version of the original code (see below) from the
# Module::Signature manual page.

if (! $ENV{TEST_SIGNATURE}) {
    print "1..0 # skipped. Set the environment variable",
      " TEST_SIGNATURE to enable this test\n";
}
elsif (! -f 'SIGNATURE') {
    print "1..0 # skipped. No signature file found\n";
}
elsif (! eval { require Module::Signature; 1 }) {
    print "1..0 # skipped. ",
      "Next time around, consider install Module::Signature, ",
        "so you can verify the integrity of this distribution.\n";
}
elsif (! eval { require Socket; Socket::inet_aton('pgp.mit.edu') }) {
    print "1..0 # skipped. ",
      "Cannot connect to the keyserver to check module signature\n";
}
else {
    print "1..1\n";
    (Module::Signature::verify() == Module::Signature::SIGNATURE_OK())
      or print "not ";
    print "ok 1 # Valid signature\n";
}

__END__

# The following is the original code from the Module::Signature manual page.

if (! $ENV{TEST_SIGNATURE}) {
    print "ok 1 # skip Set the environment variable",
      " TEST_SIGNATURE to enable this test\n";
}
elsif (! -s 'SIGNATURE') {
    print "ok 1 # skip No signature file found\n";
}
elsif (! eval { require Module::Signature; 1 }) {
    print "ok 1 # skip ",
      "Next time around, consider install Module::Signature, ",
        "so you can verify the integrity of this distribution.\n";
}
elsif (! eval { require Socket; Socket::inet_aton('pgp.mit.edu') }) {
    print "ok 1 # skip ",
      "Cannot connect to the keyserver\n";
}
else {
    (Module::Signature::verify() == Module::Signature::SIGNATURE_OK())
      or print "not ";
    print "ok 1 # Valid signature\n";
}

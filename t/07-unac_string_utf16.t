#!perl
#
# Author:      Peter J. Acklam
# Time-stamp:  2008-04-19 11:31:37 +02:00
# E-mail:      pjacklam@cpan.org
# URL:         http://home.online.no/~pjacklam

#########################

use 5.006;              # for the 'utf8' and 'warnings' pragmas
use strict;             # restrict unsafe constructs
use warnings;           # control optional warnings

#use utf8;               # enable/disable UTF-8 (or UTF-EBCDIC) in source code

#########################

#use Text::Unaccent;
use Text::Unaccent::PurePerl;

#########################

eval { require Encode; };

if ($@) {
    print "1..0 # skipped because the 'Encode' module is not installed.\n";
    exit;
}

#########################

my $data =
  [
   [
    "\x00�\x00t\x00�",
    "\x00e\x00t\x00e",
   ]
  ];

print "1..1\n";

my $testno = 0;

for (my $i = 0 ; $i <= $#$data ; ++ $i) {
    ++ $testno;

    my $in           = $data->[$i][0];
    my $out_expected = $data->[$i][1];

    my $out_actual   = unac_string_utf16($in);

    unless (defined $out_actual) {
        print "not ok ", $testno, "\n";
        print "  input ......: ", nice_string($in), "\n";
        print "  got ........: <UNDEF>\n";
        print "  expected ...: ", nice_string($out_expected), "\n";
        print "  error ......: the output is undefined\n";
        next;
    }

    unless ($out_actual eq $out_expected) {
        print "not ok ", $testno, "\n";
        print "  input ......: ", nice_string($in), "\n";
        print "  got ........: ", nice_string($out_actual), "\n";
        print "  expected ...: ", nice_string($out_expected), "\n";
        print "  error ......: the actual output is not identical to",
          " the expected output\n";
        next;
    }

    print "ok ", $testno, "\n";

}

# Emacs Local Variables:
# Emacs coding: iso-8859-1
# Emacs mode: perl
# Emacs End:

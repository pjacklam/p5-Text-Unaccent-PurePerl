#!perl
#
# Author:      Peter J. Acklam
# Time-stamp:  2008-04-29 17:26:41 +02:00
# E-mail:      pjacklam@cpan.org
# URL:         http://home.online.no/~pjacklam

#########################

use 5.006;              # for the 'utf8' and 'warnings' pragmas
use strict;             # restrict unsafe constructs
use warnings;           # control optional warnings

#use utf8;               # enable/disable UTF-8 (or UTF-EBCDIC) in source code

use lib 't';

#########################

use Text::Unaccent::PurePerl;

#########################

my $data =
  [
   [
    "",
    "",
   ],
   [
    "naive",
    "na�ve",
   ],
   [
    "deja vu",
    "d�j� vu",
   ],
   [
    "Espana",
    "Espa�a",
   ],
   [
    "Francais",
    "Fran�ais",
   ],
   [
    "Citroen",
    "Citro�n",
   ],
   [
    "Njal Saebo",
    "Nj�l S�b�",
   ],
  ];

print "1..14\n";

my $testno = 0;

for (my $i = 0 ; $i <= $#$data ; ++ $i) {
    for (my $j = 0 ; $j <= 1 ; ++ $j) {
        ++ $testno;

        my $in           = $data->[$i][$j];
        my $out_expected = $data->[$i][0];

        my $out_actual   = unac_string($in);

        unless (defined $out_actual) {
            print "not ok ", $testno, "\n";
            print "  input ......: ", TestUtil::nice_string($in), "\n";
            print "  got ........: <UNDEF>\n";
            print "  expected ...: ", TestUtil::nice_string($out_expected), "\n";
            print "  error ......: the output is undefined\n";
            next;
        }

        unless ($out_actual eq $out_expected) {
            print "not ok ", $testno, "\n";
            print "  input ......: ", TestUtil::nice_string($in), "\n";
            print "  got ........: ", TestUtil::nice_string($out_actual), "\n";
            print "  expected ...: ", TestUtil::nice_string($out_expected), "\n";
            print "  error ......: the actual output is not identical to",
              " the expected output\n";
            next;
        }

        print "ok ", $testno, "\n";
    }
}

# Emacs Local Variables:
# Emacs coding: iso-8859-1
# Emacs mode: perl
# Emacs End:

# -*- mode: perl; coding: utf-8-unix -*-

use 5.008;              # for UTF-8 support
use strict;             # restrict unsafe constructs
use warnings;           # control optional warnings
use utf8;               # enable/disable UTF-8 (or UTF-EBCDIC) in source code

use lib 't';            # manipulate @INC at compile time

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
    "naïve",
   ],
   [
    "deja vu",
    "déjà vu",
   ],
   [
    "Espana",
    "España",
   ],
   [
    "Francais",
    "Français",
   ],
   [
    "Citroen",
    "Citroën",
   ],
   [
    "Njal Saebo",
    "Njål Sæbø",
   ],
   [
    "Ελλαδα",
    "Ελλάδα",
   ],
   [
    "Русскии",
    "Русский",
   ],
  ];

print "1..18\n";

my $testno = 0;

for (my $i = 0 ; $i <= $#$data ; ++ $i) {
    for (my $j = 0 ; $j <= 1 ; ++ $j) {
        ++ $testno;

        my $in           = $data->[$i][$j];
        my $out_expected = $data->[$i][0];

        my $out_actual   = unac_string($in);

        # I don't belive this qualifies an error, so just give a warning if it
        # fails.

        if ($out_expected =~ /[^\000-\177]/ &&
            ! utf8::is_utf8($out_expected)) {
            warn "# expected the input string to have the utf8 flag set";
        }

        unless (defined $out_actual) {
            print "not ok ", $testno, "\n";
            print "  input ......: ", TestUtil::nice_string($in), "\n";
            print "  got ........: <UNDEF>\n";
            print "  expected ...: ", TestUtil::nice_string($out_expected), "\n";
            print "  error ......: the output is undefined\n";
            next;
        }

        # I don't belive this qualifies an error, so just give a warning if it
        # fails.

        if ($out_actual =~ /[^\000-\177]/ &&
            ! utf8::is_utf8($out_actual)) {
            warn "# expected the output string to have the utf8 flag set";
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

        if (utf8::is_utf8($in) &&
            $out_actual =~ /[^\000-\177]/ &&
            ! utf8::is_utf8($out_actual)) {
            print "not ok ", $testno, "\n";
            print "  input ......: ", TestUtil::nice_string($in), "\n";
            print "  got ........: ", TestUtil::nice_string($out_actual), "\n";
            print "  expected ...: ", TestUtil::nice_string($out_expected), "\n";
            print "  error ......: when the input string has the utf8 flag",
              " set, and the output contains non-ASCII characters, the",
                " output should also have the utf8 flag set\n";
            next;
        }

        print "ok ", $testno, "\n";
    }
}

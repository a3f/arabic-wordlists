#!/usr/bin/perl -CASD

# Extracts Arabic words and outputs them line-delimited
# in lexicographical order.

use List::Uniq qw(uniq); # install with `cpan List::Uniq`

local $/, $, = "\n";
print grep { length > 1 } uniq {sort => 1}, split ' ', <> =~ s/[\P{InArabic}\p{Punct}\d]+/ /gurx;

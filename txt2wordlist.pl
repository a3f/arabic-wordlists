#!/usr/bin/perl -CASD

use strict;
use warnings;

# Extracts Arabic words and outputs them line-delimited
# in lexicographical order.
# install deps with `cpan List::Uniq Lingua::AR::Tashkeel`

use List::Uniq 'uniq';
use Lingua::AR::Tashkeel v0.004 'strip';

local $/, $, = "\n";
print grep { length > 1 } uniq {
    sort => 1,
    compare => sub { strip(shift) cmp strip(shift) }
} , split ' ', <> =~ s/[\P{InArabic}\p{Punct}\d]+/ /gurx;

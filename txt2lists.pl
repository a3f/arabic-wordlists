#!/usr/bin/perl -CASD

# Extracts Arabic words and outputs them line-delimited in
# lexicographical order and as a frequency list into cwd
# install deps with `cpan List::Uniq Lingua::AR::Tashkeel`

use strict;
use warnings;
use List::Uniq 'uniq';
use Lingua::AR::Tashkeel v0.004 'strip';
use autodie ':all';

local $/; $, = "\n";
my ($content, $filename) = (<>, $ARGV[0] // 'stdin');
my (@words, %freq, %stripped);
@words = split ' ', $content =~ s/[\P{InArabic}\p{Punct}\d]+/ /gu;
$freq{$stripped{$_} ||= strip $_}++ foreach @words;

open my $fh, '>', "$filename.freqlist";
foreach my $word (sort { $freq{$b} <=> $freq{$a} } keys %freq) {
    print $fh "$word $freq{$word}\n";
}
close $fh;
open $fh, '>', "$filename.wordlist";
print $fh grep { length > 1 } uniq {
    sort => 1,
    compare => sub { $stripped{$_[0]} cmp $stripped{$_[1]} }
}, @words;

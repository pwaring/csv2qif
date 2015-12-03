#!/usr/bin/env perl

use 5.014;

use strict;
use warnings;
use autodie;

use Text::CSV;

my $csv = Text::CSV->new({ binary => 1 });

$csv->column_names( qw( date type sort_code account_number description debit credit balance ) );

my $skip_headers = 1;
my $skipped_headers = 0;

say '!Type:Bank';

my $fh = \*STDIN;

while (my $row = $csv->getline_hr($fh))
{
  if ($skip_headers && !$skipped_headers)
  {
    $skipped_headers = 1;
  }
  else
  {
    say 'D' . $row->{date};

    if ($row->{credit} ne '')
    {
      say 'T' . $row->{credit};
    }
    else
    {
      say 'T-' . $row->{debit};
    }

    say 'P' . $row->{description};

    say '^';
  }
}

close $fh;

#!/usr/bin/env perl

use 5.014;

use strict;
use warnings;
use autodie;

use Text::CSV;
use Getopt::Long;

my $csv = Text::CSV->new({ binary => 1 });

my $skip_headers = '';
my $config = '';
GetOptions(
  'skip-headers' => \$skip_headers,
  'config=s' => \$config
);

if (!$config)
{
  die("No config file specified, use --config [file]");
}

# Open configuration file to get column names
open my $config_file, '<', $config;
my $column_names = <$config_file>;
close $config_file;

my @column_names = split(/\s+/, $column_names);

$csv->column_names( @column_names );

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
    if (defined($row->{date}) && defined($row->{credit}) && defined($row->{debit}) && defined($row->{description}))
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
}

close $fh;

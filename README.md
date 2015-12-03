# csv2qif

Perl script for converting CSV to QIF.

## Requirements

Modern version of Perl 5, minimum 5.14 (whatever is in Debian oldstable is considered the minimum).

## Usage

The script takes CSV data from standard input and produces QIF data on standard output. To convert a file `statement.csv` to `statement.qif` you will need to run the following command:

```
cat statement.csv | perl ./csv2qif.pl > statement.qif
```

### Configuration

Before running the script, you need to make two changes. First you must define a column mapping by editing the following line:

```
$csv->column_names( qw( date type sort_code account_number description debit credit balance ) );
```

The column names which matter are: `date`, `description`, `debit` and `credit`. Other columns must be specified but their names do not affect the script.

If your CSV file does not include headers (i.e. data starts on line 1) then you should change this line:

```
my $skip_headers = 1;
```

to:

```
my $skip_headers = 0;
```

## Bug reports

Bugs should be reported via the GitHub issue system. Pull requests are welcome.

The fact that the script may not work correctly on older versions of Perl is not considered a bug.


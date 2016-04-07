# csv2qif

Perl script for converting [CSV](https://en.wikipedia.org/wiki/Comma-separated_values)
to [QIF](https://en.wikipedia.org/wiki/Quicken_Interchange_Format).

## Requirements

Modern version of Perl 5, minimum 5.14 (whatever is in Debian oldstable is
considered the minimum).

## Usage

The script takes CSV data from standard input and produces QIF data on standard
output. To convert a file `statement.csv` to `statement.qif` you will need to
run the following command:

```
cat statement.csv | perl ./csv2qif.pl > statement.qif
```

### Command line options

`csv2qif` requires a configuration file which specifies which fields in the CSV
file correspond to the relevant QIF fields. The important column names are:
`date`, `description`, `debit` and `credit`. Other columns must be specified
but their names do not affect the conversion process.

Column mappings must be placed on a single line in a plain text field, with
column headings separated by whitespace. See `config/co-op-business.txt` for
an example.

The relevant configuration file can be selected using the `--config` option,
which is required.

If your CSV file includes headers (assumed to be on line 1) then you need to
specify the `--skip-headers` argument, otherwise `csv2qif` will try to process
the headers as a transaction.

## Bug reports

Bugs should be reported via the GitHub issue system. Pull requests are welcome,
either for code or new heading mappings for other banks.

The fact that the script may not work correctly on older versions of Perl is
not considered a bug.

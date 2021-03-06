#!/usr/bin/env python3

import argparse
import csv

parser = argparse.ArgumentParser()
parser.add_argument('--config', help='path to file containing column header mappings', required=True)
parser.add_argument('--csv-file', help='path to CSV file', required=True)
parser.add_argument('--skip-headers', help='skip first line of file as headers', action='store_true')
args = parser.parse_args()

skipped_headers = False

with open(args.config, 'r') as config_file:
    column_headings = config_file.readline().strip()
    column_headings = column_headings.split()

with open(args.csv_file, newline='') as csv_file:
    csv_reader = csv.DictReader(csv_file, fieldnames=column_headings)

    print('!Type:Bank')

    for row in csv_reader:
        if args.skip_headers and not skipped_headers:
            skipped_headers = True
        else:
            print('D' + row['date'])

            if row['credit'] != '':
                print('T' + row['credit'])
            elif row['debit'] != '':
                print('T-' + row['debit'])

            print('P' + row['description'])
            print('^')

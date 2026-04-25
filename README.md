# fec-dump-parquets

Cron job that publishes .parquet files of the Schedule A and Schedule B
tables of the FEC database.

See https://github.com/fecgov/FEC/issues/13168 for motivation.

All of the tables are published as parquet files to the Hugging Face dataset
https://huggingface.co/datasets/NickCrews/fec-dumps by a github action every week.
In duckdb you can get the 1985-1986 Schedule A data with simply
`SELECT * FROM 'https://huggingface.co/datasets/NickCrews/fec-dumps/resolve/main/disclosure.fec_fitem_sched_a_1985_1986.parquet'`!
The action overwrites the files on `main`, so the url will stay stable
over time, but the data will change every week.

Note that columns in the parquets are all strings.
I may change this later, so your using code should be defensive for future changes.

## Methodology

This uses the https://github.com/NickCrews/pg_dumpster cli tool to
extract the table data entries from the postgres .dump files
that the FEC publishes each week to https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/index.html?prefix=bulk-downloads/data-dump/schedules/
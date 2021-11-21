# virtuoso_vdb_scripts
Scripts that provide extended usage of Virtuoso Universal Server's Virtual database layer

## Functions
### CSV_REDUCE(tb, dir, crit, delimiter, newline, esc, skip_rows, pkey_columns)
#### Parameters
tb: Virtual table name

dir: directory containing *SVs

crit: search criteria for files in directory I.E., **.csv**, **data.*csv$**

delimiter: delimiter used to separate values (I.E., **,** for CSV, **tab** for TSV)

newline: characters used to create line bread between records (I.E. '\n')

esc: Escape character

skip_rows: Number of rows to skip before adding records

pkey_columns: a vector of column numbers to create primary key (I.E, **vector(1)**, **vector(1,2,3)**)

### Example
SELECT CSV_REDUCE('qa.data.demo','csv_reduce_demo','.csv',',','\n',null,1);
>Attached 60 files to qa.data.mockaroo

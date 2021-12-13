# CSV_REDUCE(tb, dir, crit, delimiter, newline, esc, skip_rows, pkey_columns)

An extension of Virtuoso's [attach_from_csv()](http://docs.openlinksw.com/virtuoso/fn_attach_from_csv/) function, that automatically reduces multiple CSVs from a directory to a virtual SQL table.

## Installation
Run the reduce_csv.sql SQL script from your virtuoso instance.

## Parameters
tb (VARCHAR): Virtual table name

dir (VARCHAR): directory containing *SVs

crit (VARCHAR): search criteria for files in directory I.E., **.csv**, **data.*csv$**

delimiter (VARCHAR): delimiter used to separate values (I.E., **,** for CSV, **tab** for TSV)

newline (VARCHAR): characters used to create line bread between records (I.E. '\n')

esc (VARCHAR): Escape character

skip_rows (INTEGER): Number of rows to skip before adding records

pkey_columns (ANY - VECTOR): a vector of column numbers to create primary key (I.E, **vector(1)**, **vector(1,2,3)**)

## Examples
### CSV
SELECT CSV_REDUCE('qa.data.demo','csv_reduce_demo','.csv',',','\n',null,1);
>Attached 60 files to qa.data.mockaroo

### TSV
SELECT CSV_REDUCE('qa.data.demo','csv_reduce_demo','.tsv','tab','\n',null,1);
>Attached 60 files to qa.data.mockaroo

### "|" Separated
SELECT CSV_REDUCE('qa.data.demo','csv_reduce_demo','.csv','|','\n',null,1);
>Attached 60 files to qa.data.mockaroo

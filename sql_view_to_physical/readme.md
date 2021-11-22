# SQL_VIEW_TO_PHYSICAL(tb, source, pkey)

A function that creates a physical table of a SQL view/virtual table.

#### Parameters

tb (VARCHAR): Physical Table Name

source (VARCHAR): Name SQL view/virtual table to be transformed

pkey_columns (VARCHAR) (Optional): a vector of column names to create primary key (I.E, **'"id"'**, **'"id","hash"'** )

### Example

SELECT SQL_VIEW_TO_PHYSICAL(‘qa.data.alldata’,‘qa.data.all’,’“hash”’);
> Created physical table “qa”.“data”.“alldata” from “qa”.“data”.“all”. Primary Key: “hash”

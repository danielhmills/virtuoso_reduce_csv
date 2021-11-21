-- Stored Procedure For Reducing Multiple CSV Virtualizations to a virtual SQL Table

-- Install file_dirlist_full() for collecting all files in a designated directory
DROP PROCEDURE file_dirlist_full;
CREATE PROCEDURE file_dirlist_full (IN a ANY)
    {
        DECLARE _inx integer;        
        DECLARE F VARCHAR;
        DECLARE L INT;

        F := file_dirlist(a,1);
        L := length(F);
        _inx := 0;

        
        While(_inx < L){
            DECLARE v any;
        F[_inx] := concat(a,'/',F[_inx]);
        _inx := _inx + 1;

        }

        return F;
    
    };


-- Procedure for creating array of files that match search criteria
-- dir = Directory
-- crit = Search Criteria. I.E. '.csv', 'data.*csv$'
DROP PROCEDURE dir_search;
CREATE PROCEDURE dir_search (IN dir ANY, IN crit VARCHAR)
    {
      DECLARE _inx, _dir_l INT;
      DECLARE files ANY ARRAY;
      DECLARE res ANY array;

      _inx := 0;
      files := file_dirlist_full(dir);
      _dir_l := length(files);
      VECTORBLD_INIT (res);     
     WHILE(_inx < _dir_l){
          IF(length(regexp_match(crit,files[_inx])) > 0){
            VECTORBLD_ACC(res, files[_inx]);
          }

          _inx :=  _inx + 1;
      }

      VECTORBLD_FINAL(res);

      RETURN res;
    };




-- Install CSV_REDUCE() procedure for attaching all CSVs listed in file_dirlist_full() to a virtual SQL table

DROP TABLE "qa"."data"."all";
DROP PROCEDURE CSV_REDUCE;
CREATE PROCEDURE CSV_REDUCE (IN tb VARCHAR, IN dir ANY, IN CRIT VARCHAR := null, IN delimiter VARCHAR, in newline VARCHAR, in esc VARCHAR, in skip_rows int, in pkey_columns any := null)
    {
    declare f VARCHAR;
    declare files ANY;   
        files := dir_search(dir,crit);

    f := attach_from_csv(tb,files,delimiter,newline,esc,skip_rows,pkey_columns);

    return sprintf('Attached %d files to %s',length(files),tb);
    return files;
    };

SELECT CSV_REDUCE('qa.data.all','demo','.csv',',','\n',null,1);

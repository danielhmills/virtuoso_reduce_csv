--Cleanup
DROP PROCEDURE SQL_VIEW_TO_PHYSICAL;

CREATE PROCEDURE SQL_VIEW_TO_PHYSICAL (IN tb VARCHAR, IN source VARCHAR, IN pkey VARCHAR := null)
    {
    declare ptable, rtable, q, q2 VARCHAR;

        -- ptable := New physical table name
        -- rtable := SQL View / Attached CSV

         ptable := sprintf('"%s"', regexp_replace(tb,'(^s)|(\\.)','"."'));
         rtable := sprintf('"%s"', regexp_replace(source,'(^s)|(\\.)','"."'));

        -- CREATE TABLE statement string
        q := sprintf('CREATE TABLE %s AS SELECT * FROM %s WITH DATA', ptable, rtable);

        -- Execute CREATE TABLE statement
        exec(q);

        -- If primary key is detechted, run ALTER TABLE statement.
        if(isNull(pkey) = 0)
        {
            q2 := sprintf('ALTER TABLE %s MODIFY PRIMARY KEY (%s)',ptable,pkey);
            exec(q2);
            return sprintf('Created physical table %s from %s. Primary Key: (%s)', ptable, rtable, pkey);

        };

        -- If primary key isn't detected, end process.
        if(isNull(pkey) = 1){
        return sprintf('Created physical table %s from %s', ptable, rtable);
        }
    };
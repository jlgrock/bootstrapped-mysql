#!/bin/bash
UP=1

# wait until the server is ready
until [[ "$UP" -eq 0 ]]; do
        mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute="SELECT NOW();" 2>/dev/null
        UP=$?
        echo "sleeping..."
        sleep 1
done

#execute data load
mysql -uroot -p$MYSQL_ROOT_PASSWORD test < /bootstrap/data/table-create.sql
echo "table creation: $?"

mysql -uroot -p$MYSQL_ROOT_PASSWORD test < /bootstrap/data/persons-data.sql
echo "person data load: $?"
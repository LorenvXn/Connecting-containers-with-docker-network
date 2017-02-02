#!/bin/sh
docker ps -a | sed -e 's/^\(.\{151\}\).*/\1/' | awk '{if($2 == "mysql_new") print $11}'

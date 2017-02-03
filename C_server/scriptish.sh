#!/bin/bash

IP=`docker inspect $(docker ps  | sed -e 's/^\(.\{41\}\).*/\1/' | awk '{if($2 == "mysql_new") print $1}') \
 | grep IPAddress | awk 'NR==2 {print $NF}' | cut -f1 -d ','  \
 | sed 's/["]//g'`

echo $IP




##########################################################################################
#previously used for linking purpose. Since --link is becoming deprecated, 
#we need to look up for IP (as above script), and not container's name, as before:
# -----------------------------------------
# #!/bin/sh
# docker ps -a | sed -e 's/^\(.\{151\}\).*/\1/' | awk '{if($2 == "mysql_new") print $11}'
############################################################################################


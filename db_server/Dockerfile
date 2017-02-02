FROM mysql:latest
RUN  echo "							\ 
        CREATE DATABASE IF NOT EXISTS southwind;		 \n\
        USE southwind;						 \n\
        CREATE TABLE IF NOT EXISTS products ( 			 \n\
         productID    INT UNSIGNED  NOT NULL AUTO_INCREMENT, 	 \n\
         productCode  CHAR(3)       NOT NULL DEFAULT '', 	 \n\
         name         VARCHAR(30)   NOT NULL DEFAULT '',	 \n\
         quantity     INT UNSIGNED  NOT NULL DEFAULT 0, 	 \n\
         price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,	 \n\
         PRIMARY KEY  (productID) );  \
	" > mysqlcommands.sql
    

RUN printf "#!/bin/bash" > load_database.sh 
RUN printf "\n" >> load_database.sh
RUN echo "			\
 mysql -h localhost -u root -pMuhaha < mysqlcommands.sql    \n\
        " >> load_database.sh   
RUN chmod +x load_database.sh


# Connecting-containers-with-docker-network

Connecting mysql container with a C container for C API mysql programming purposes.  -- The container with ``manipulatedb`` will behave as the connection server for the mysql database.

Building:
``!!!First of all, build mysql container!!!``

From ``db_server`` folder: <br \>

1) ``docker build -t mysql_new . `` <br \>
2) ``docker run -it -d -p 3306:3306 mysql_new /bin/bash `` <br \>
3) Find container's ID, and execute (for instance: ``docker exec -it 9d0a36520421 /bin/bash`` ) <br \>
(it needds more automation at point 3... lel!)<br \>
4) Restart mysql service (if needed): ``service mysql restart``<br \>
5) Create new dba user, as per indication in ``db_user_creation.txt``<br \>


From ``C_server`` folder: <br \>

1) Run ``test.pl`` script. This will find the name of mysql_new image, and update/recreate the ``create.c`` file. <br \> 

2) `` docker build -t manipulatedb . `` <br \>

3.1) Create new bridge, and add the two containers to the new network: <br \>

`` docker network create --driver=bridge my-tiny-network ``  <br \>

`` docker network connect my-tiny-network [container's ID with mysql_new image] `` <br \>
`` docker network connect my-tiny-network [container's ID with manipulate image] `` <br \>

3.2) Check if you can ping one from another

(yup, it needs more automation here as well)

4) ``docker run -it -d -p 8091:8091  manipulatedb /bin/bash ``   <br \>

5) Under /home, run create program:  <br \>
``root@0f2d2de2ba6d:/home# ./create`` <br \>
``root@0f2d2de2ba6d:/home#`` <br \> 
``root@0f2d2de2ba6d:/home#``  <br \>

6) Check on container with image ``mysql_new`` if new database was created. 



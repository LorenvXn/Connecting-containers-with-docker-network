# Connecting-containers-with-docker-network

Connecting mysql container with a C container for C API mysql programming purposes.  -- The container with ``manipulatedb`` will behave as the connection server for the mysql database.

Building: <br \>

``!!!First of all, build mysql container!!!``

> From ``db_server`` folder: <br \>

1) ``docker build -t mysql_new . `` <br \>
2) ``docker run -it -d -p 3306:3306 mysql_new /bin/bash `` <br \>

`` root@tron-VirtualBox:~/dockerZ/C_dockerZ/testish/db_server# docker ps -a`` <br \>
``CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                              NAMES
4764499f46cd        mysql_new           "docker-entrypoint..."   3 seconds ago       Up 2 seconds        3300/tcp, 0.0.0.0:3306->3306/tcp   xenodochial_hamilton``  <br \>


3.1)  Find container's ID, and execute <br \>
3.2)  Restart mysql service (if needed): ``service mysql restart``<br \>
``
root@tron-VirtualBox:~/dockerZ/C_dockerZ/testish/db_server# docker exec -ti 4764499f46cd /bin/bash `` <br \>
`` root@4764499f46cd:/# service mysql restart `` <br \>

4) Create new dba user, as per indication in ``db_user_creation.txt``<br \>


> Docker-network creation:

1) Create new bridge:  ``docker network create --driver=bridge [new bridge name]``
 ``docker network create --driver=bridge moar-network``
2) Add new container to new network:
``docker network connect moar-network [container's ID with mysql_new image]``

 ``docker network connect moar-network  4764499f46cd`` 

> From ``C_server`` folder: <br \>

1) Run ``test.pl`` script. This will find the name of mysql_new image, and update/recreate the ``create.c`` file. <br \> 

2) `` docker build -t manipulatedb . `` <br \>

3.2) Check if you can ping one from another

(yup, it *definitely* needs more automation)

4) ``docker run -it -d -p 8091:8091  manipulatedb /bin/bash ``   <br \>

``  #docker ps -a `` <br \>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                              NAMES
bc0333ec8b1d        manipulatedb        "/bin/bash"              7 seconds ago       Up 6 seconds        22/tcp, 0.0.0.0:8091->8091/tcp     upbeat_fermat <br \>
4764499f46cd        mysql_new           "docker-entrypoint..."   13 minutes ago      Up 13 minutes       3300/tcp, 0.0.0.0:3306->3306/tcp   xenodochial_hamilton <br \> 

`` root@server# docker exec -ti bc0333ec8b1d /bin/bash``
``root@bc0333ec8b1d:/home#`` 

5) Under /home, run the already compiled C program:  <br \>

``root@bc0333ec8b1d:/home# ./create ``<br \>
``root@bc0333ec8b1d:/home# echo $?`` <br \>
``0 ``<br \>
``root@bc0333ec8b1d:/home# ``<br \>


6) Check on container with image ``mysql_new`` if new database was created. 

root@server# ``docker exec xenodochial_hamilton  mysql -uroot -pMuhaha -e  "show databases;"`` 
mysql: [Warning] Using a password on the command line interface can be insecure.  <br \>
Database<br \>
information_schema<br \>
mysql<br \>
performance_schema<br \>
sys<br \> 
``testdb`` <br \>

# Connecting-containers-with-docker-network

Connecting mysql container with a C container for C API mysql programming purposes.  -- The container with ``manipulatedb`` will behave as the connection server for the mysql database.

Building:


``!!!First of all, build mysql container!!!``

> From ``db_server`` folder: 


1) ``docker build -t mysql_new . ``

2) ``docker run -it -d -p 3306:3306 mysql_new /bin/bash ``


``` root@server# docker ps -a

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                              NAMES
4764499f46cd        mysql_new           "docker-entrypoint..."   3 seconds ago       Up 2 seconds        3300/tcp, 0.0.0.0:3306->3306/tcp   xenodochial_hamilton
```



3.1)  Find container's ID, and execute

3.2)  Restart mysql service (if needed): ``service mysql restart``

``
root@server# docker exec -ti 4764499f46cd /bin/bash ``

`` root@4764499f46cd:/# service mysql restart `` 


4) Create new dba user, as per indication in ``db_user_creation.txt``



> Docker-network creation: 


1) Create new bridge:  ``docker network create --driver=bridge [new bridge name]``

 ``docker network create --driver=bridge moar-network``
 
2) Add new container to new network:

``docker network connect moar-network [container's ID with mysql_new image]`` 


 ``docker network connect moar-network  4764499f46cd``  
 

> From ``C_server`` folder:


1) Run ``test.pl`` script. This will find the name of mysql_new image, and update/recreate the ``create.c`` file. 


2) `` docker build -t manipulatedb . ``


(yup, it *definitely* needs more automation) 


4) ``docker run -it -d -p 8091:8091  manipulatedb /bin/bash ``   


```  
#docker ps -a  

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                              NAMES
bc0333ec8b1d        manipulatedb        "/bin/bash"              7 seconds ago       Up 6 seconds        22/tcp, 0.0.0.0:8091->8091/tcp     upbeat_fermat 


4764499f46cd        mysql_new           "docker-entrypoint..."   13 minutes ago      Up 13 minutes       3300/tcp, 0.0.0.0:3306->3306/tcp   xenodochial_hamilton 
```


4.1) Add new created container to the new moar-network bridge: 


``docker network connect moar-network  bc0333ec8b1d ``  
    un -it -d -p 8091:8091 manipulatedb /bin/bash



4.2) Access container:  


`` root@server# docker exec -ti bc0333ec8b1d /bin/bash`` 

``root@bc0333ec8b1d:/home#``



5) Under /home, run the already compiled C program: 


```root@bc0333ec8b1d:/home# ./create 

root@bc0333ec8b1d:/home# echo $?

0 

root@bc0333ec8b1d:/home# 
```



6) Check on container with image ``mysql_new`` if new database was created.  


```
root@server# docker exec xenodochial_hamilton  mysql -uroot -pMuhaha -e  "show databases;"

mysql: [Warning] Using a password on the command line interface can be insecure. 

Database

information_schema

mysql

performance_schema

sys

testdb
```

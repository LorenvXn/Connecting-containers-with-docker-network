# Linking-docker-containers

Linking mysql container with a C container for C API mysql programming purposes.  -- The container with ``manipulatedb`` will behave as the connection server for the mysql database.

Building:

From ``db_server`` folder: <br \>

1) docker build -t mysql_new . <br \>
2) docker run -it -d -p 3306:3306 mysql_new /bin/bash <br \>
3) Find container's ID, and execute (for instance: ``docker exec -it 9d0a36520421 /bin/bash`` ) <br \>
(it needds more automation at point 3... lel!)


From ``C_server`` folder: <br \>

1) Run ``test.pl`` script. This will find the name of mysql_new image, and update/recreate the ``create.c`` file. <br \> 
2) docker build --tag="manipulatedb" . <br \>
3) docker run -it -d -p 8091:8091 --link <Container name>:<Container name>  manipulatedb bash <br \>
(for instance  docker run -it -d -p 8091:8091 --link hardcore_goldstine:hardcore_goldstine manipulatedb bash) <br \>
4) find container's ID and execute. You should already find the compiled program under /home directory. <br \>
Run it and then check databases on the mysql container. A new database `` testdb `` should be created.<br \>



> For getting rid of bash script, you could implement the gcc compilation and assigning shift value to $var in the Perl script..etc... 

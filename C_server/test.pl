#!/usr/bin/perl

use strict;
####################################################
# Extracts mysql_new's IP and adds it in C file
#####################################################

my $filename = 'create.c';
open(my $fh, '>', 'create.c');

chomp(my $var =`/bin/bash scriptish.sh`);


print $fh "

#include <my_global.h>
#include <mysql.h>

int main(int argc, char **argv)
{
  MYSQL *con = mysql_init(NULL);

  if (con == NULL)
  {
      fprintf(stderr, \"%s\\n\", mysql_error(con));
      exit(1);
  }

  if (mysql_real_connect(con, \"$var\", \"monty\", \"some_pass\",
          NULL, 0, NULL, 0) == NULL)
  {
      fprintf(stderr, \"%s\\n\", mysql_error(con));
      mysql_close(con);
      exit(1);
  }

  if (mysql_query(con, \"CREATE DATABASE testdb\"))
  {
      fprintf(stderr, \"%s\\n\", mysql_error(con));
      mysql_close(con);
      exit(1);
  }

  mysql_close(con);
  exit(0);
}

";

close $fh;


##################################################################################
#root@0f2d2de2ba6d:/home# more create.c
# [-------snip---------]
#
#  if (mysql_real_connect(con, "172.17.0.2", "monty", "some_pass",
#          NULL, 0, NULL, 0) == NULL)
#  [------snip---------]
#
# Script & project based on materials:  http://zetcode.com/db/mysqlc/ 
# https://blog.csainty.com/2016/07/connecting-docker-containers.html
##################################################################################


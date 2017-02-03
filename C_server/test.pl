#!/usr/bin/perl

use strict;

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


##################################################
# Script based on http://zetcode.com/db/mysqlc/
##################################################


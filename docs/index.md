# YETI installation manual

# 1 Overview

Minimal system installation requires following compoments:

- Routing database (postgresql-9.3) see [sec:Databases-installation]

- CDRs database (postgresql-9.3) see [sec:Databases-installation]

- Management interface (web interace written on RoR) see [sec:Management-interface-installation]

- DSS storage (Redis) see [sec:DSS-Storage-installation]

- Management server (configurations server) see [sec:Management-server-installation]

- Traffic switch (SBC based on SEMS) see [sec:Traffic-switch-server-installation]

- Load balancer (kamailio) see [sec:Load-balancer-installation]


# 2 Databases installation

System requires two databases: one for routing and one for CDRs.

We recommend to place routing database at the same host with management interface to reach best interface responsiveness by reducing network delay for database requests from web-interface.

## 2.1 Install packages

both routing and CDRs databases requires similar sets of connected repositories and installed packages.

Make sure that following repositories added on your system:

```
deb http://ftp.us.debian.org/debian/ wheezy main
```

System repositories can be changed by editing of file: /etc/apt/sources.list

import public keys for repositories:

```
# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6
```

Install packages:

```
# aptitude update && aptitude install postgresql-9.3 postgresql-contrib-9.3 postgresql-9.3-prefix postgresql-9.3-pgq3 postgresql-9.3-yeti skytools3 skytools3-ticker
```

## 2.2 Create databases

Create routing database:

```
# su - postgres
$ psql
postgres=# create user yeti encrypted password 'somepassword' superuser; 
CREATE ROLE 
postgres=# create database yeti owner yeti; 
CREATE DATABASE 
postgres=# \q
```

Create database to store CDR:

```
# su - postgres
$ psql
postgres=# create database cdr owner yeti;
CREATE DATABASE
postgres=# \q
```

Note: It's recommended to specify values for databases names, usernames, passwords differ from specified in this manual for security reasons.

For large installations is reasonable to place CDR database on dedicated server

## 2.3 Check

Check databases created and accessible:

```
root@evial:/# psql -h 127.0.0.1 -U yeti -d yeti
```

Don't forget to make changes in /etc/postgresql/9.3/main/pg_hba.conf and apply them if you plan to access this databases from another hosts


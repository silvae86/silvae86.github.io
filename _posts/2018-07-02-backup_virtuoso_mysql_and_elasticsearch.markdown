---
layout: post
title:  "How to backup MySQL, OpenLink Virtuoso and ElasticSearch database data via command line in Linux"
date:   2018-07-09 15:12:00 +0100
tags: sysadmin backup mysql virtuoso elasticsearch ubuntu
---

MySQL, ElasticSearch and OpenLink Virtuoso are all dependencies of our research data management platform, [Dendro](https://github.com/feup-infolab/dendro). Here is how we back up the databases.

### Backup Script

This script is a basic template for backing up the data of all three servers.

{% highlight shell%}
# Create backup directory with date timestamp
##get valid timestamp for the backup directory
BACKUP_DIR=$HOME/$(date +"%Y-%m-%d_%H-%M-%S") 
###enter your mysql password here
MYSQL_PASSWORD="MYSQL_PASSWORD" 

###create timestamped backup directory in your home folder
mkdir -p $BACKUP_DIR #create backup directory

# ElasticSearch: 
mkdir -p $BACKUP_DIR/elasticsearch/nodes
sudo cp -r /var/lib/elasticsearch/elasticsearch/nodes/* $BACKUP_DIR/elasticsearch/nodes

# Virtuoso: 
mkdir -p $BACKUP_DIR/virtuoso/db
sudo cp -r /usr/local/virtuoso-opensource/var/lib/virtuoso/db/* $BACKUP_DIR/virtuoso/db 

#MySQL (backup all databases): 
mysqldump --all-databases > $BACKUP_DIR/mysqlbackup.sql -u root -p$MYSQL_PASSWORD
{% endhighlight %}



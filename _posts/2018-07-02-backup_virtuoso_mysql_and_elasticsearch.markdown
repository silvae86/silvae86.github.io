---
layout: post
title:  "How to backup MySQL, OpenLink Virtuoso and ElasticSearch database data via command line in Linux"
date:   2018-07-02 16:54:07 +0100
categories: sysadmin backup mysql virtuoso elasticsearch ubuntu
---

MySQL, ElasticSearch and OpenLink Virtuoso are all dependencies of our research data management platform, [Dendro](https://github.com/feup-infolab/dendro). Here is how we back up the databases.

### Backup Script

Generate public keys. The command will produce two keys, one public (`~/.ssh/example.com-id.pub`) and one private (`~/.ssh/example.com-id`). 

{% highlight shell %}
# Create backup directory with date timestamp
BACKUP_DIR=$HOME/$(date +"%Y-%m-%d_%H-%M-%S") #get valid timestamp for the backup directory
MYSQL_PASSWORD="MYSQL_PASSWORD" #enter your mysql password here
mkdir -p $BACKUP_DIR #create backup directory
# ElasticSearch: 
mkdir -p $BACKUP_DIR/elasticsearch/nodes
sudo cp -r /var/lib/elasticsearch/elasticsearch/nodes/* $BACKUP_DIR/elasticsearch/nodes

# Virtuoso: 
mkdir -p $BACKUP_DIR/virtuoso/db
sudo cp -r /usr/local/virtuoso-opensource/var/lib/virtuoso/db/* $BACKUP_DIR/virtuoso/db 

#MySQL (backup all databases): 
mysqldump --all-databases > $BACKUP_DIR/mysqlbackup$(date +"%Y-%m-%d_%H-%M-%S").sql -u root -p$MYSQL_PASSWORD
{% endhighlight %}



---
layout: post
title:  "Convert Standalone MongoDB to Replica Set with WiredTiger storage engine (macOS and Homebrew)"
date: 2021-03-04 22:07:000 +0100
tags: macOS homebrew mongodb replicaset wiredtiger changestreams
comments_id: 23
---

If you want to take advantage of MongoDB [Change Streams](https://docs.mongodb.com/manual/changeStreams/) (which will allow an event to be fired whenever a collection is modified instead of polling the database for changes), you need to change your MongoDB instance to a Replica Set. Here is the full process using the Terminal.

I am using a local installation of MongoDB 3.6 installed via Homebrew on macOS, but this procedure also works for practically any version, provided that you edit a couple of the commands that I show in the guide.

{% include warning.html content="Be aware that this will triple the amount of storage taken by MongoDB, as the replica set requires a minimum of 3 replicas!" %}

## Install MongoDB command line utilities

Homebrew provides a formula for installing the MongoDB command line utilities that is not installed with the server by default.

```bash
brew tap mongodb/brew
brew install mongodb-database-tools
brew install mongodb-community-shell
```

## Dump your existing database

```bash
mongodump --out ~/mongobackup
```

## Create a new folder for the Mongo database to store its files

```bash
mkdir -p /usr/local/var/repl-emagine-data-wiredtiger
```

## Backup MongoDB configuration file

Now, make a backup of your existing mongodb configuration and create a new mongodb configuration.

```bash
cp /usr/local/etc/mongod.conf /usr/local/etc/mongod.conf.bak
```

## Edit the MongoDB configuration file

Edit the configuration and modify it to use `wiredTiger` as the storage engine. This handles issues you may later have with [read/write concerns](https://docs.mongodb.com/manual/reference/read-concern/), where some operations require specific read/write concerns (e.g. `majority`) and will throw errors if your storage engine does not support them. The recommended engine is thus `wiredTiger`.

```bash
vim /usr/local/etc/mongod.conf
```

Pay attention to the `storage.dbPath` path of the configuration file. This value should match the folder path that you created before.

```yaml
systemLog:
  destination: file
  path: /usr/local/var/log/mongodb/mongo.log
  logAppend: true
storage:
  engine: wiredTiger
  dbPath: /usr/local/var/repl-emagine-data-wiredtiger
net:
  bindIp: 127.0.0.1
replication:
  replSetName: replocal
```

## Restart MongoDB

Restart the database. Edit the command appropriately if using a different version of MongoDB.

```bash
brew services restart mongodb-community@3.6
```

## Activate the new Replica Set

Access the new MongoDB instance via the command line:

```bash
mongo
```

Initiate a new replica set with `replocal` as the `_id`.

```javascript
rs.initiate({_id: "replocal", members: [{_id: 0, host: "127.0.0.1:27017"}] })
{ "ok" : 1 }
```
{% include info.html content="You may need this replica set name when connecting later using your favorite tool such as [Robo 3T](https://robomongo.org/) (this will be the **Replica set name** field)" %}

It will tell you that you are secondary, but you will soon be promoted to primary:

```javascript
replocal:PRIMARY> rs.status()
```

## Confirm that your MongoDB Replica Set is using the WiredTiger storage engine

Run in mongo CLI:

```javascript
replocal:PRIMARY> db.serverStatus().storageEngine
```

You should get this:

```json
{
	"name" : "wiredTiger",
	"supportsCommittedReads" : true,
	"readOnly" : false,
	"persistent" : true
}
```

Exit the CLI

```javascript
replocal:PRIMARY> exit
```

## Restore database

Restore your database from the dump that you created before.

```bash
mongorestore ~/mongobackup
```

Go for a looooong coffee ☕️ and come back.

## Delete database dump

Do not forget to delete the dump after you are sure that everything is correctly restored.

```bash
rm -rf ~/mongobackup
```

## Sources / Credits

1. ["Setup MongoDB on localhost as Replica Set"](https://gist.github.com/davisford/bb37079900888c44d2bbcb2c52a5d6e8)
2. ["Change Standalone to WiredTiger"](https://docs.mongodb.com/manual/tutorial/convert-standalone-to-replica-set/)

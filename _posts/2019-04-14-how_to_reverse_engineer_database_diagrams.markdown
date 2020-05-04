---
layout: post
title:  "How to make nice diagrams from your SQLite database"
date:   2019-04-14 23:20:00 +0100
tags: databases sqlite diagrams macos reverse engineering
redirect_from:
  - "/databases/sqlite/diagrams/macos/reverse/engineering/2019/04/14/how_to_reverse_engineer_database_diagrams/"
---

There often comes the time when you have an existing database and you need to build a nice diagram to analyse it quickly. Here is how to do it using open-source software. We are going to be working on a Mac running macOS 10.14 Mojave, as well as an SQLite database.

The tool that we are going to use is [Schemacrawler](http://www.schemacrawler.com/diagramming.html). It can generate very nice diagrams as you can see at the software's home page.

Credits go out to the user @dannguyen for his Github Gist that you can find [here](https://gist.github.com/dannguyen/f056d05bb7fec408bb7c14ea1552c349). Thanks!

## Installing GraphViz

First, we need to install [GraphViz](https://www.graphviz.org), an open-source visualization tool. We are going to install it using [Homebrew](https://brew.sh), which is like `apt-get` for the Mac.

### Install Homebrew

If you don't have it already, you can install Homebrew with the following command.

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install GraphViz

Install GraphViz with the following command:

```sh
brew install libtool
brew link libtool
brew install graphviz
brew link --overwrite graphviz
```

### Default location of GraphViz Executables

By default, the dot executable should be:

On Linux/Mac OS-X :

* Firstly in: `/usr/local/bin/dot`
* Then in: `/usr/bin/dot`

You can also specify the environment variable `GRAPHVIZ_DOT` to set the exact location of your GraphViz executable.

_(from the [GraphViz webpage](http://plantuml.com/graphviz-dot))_

## macOS Catalina Problems (Library Validation)

Before we can run schemacrawler, we need to make sure that our version of Java is compatible with macOS Catalina app notarizing and library validation. This is a bug documented [here](https://bugs.openjdk.java.net/browse/JDK-8223671), causing this in 10.15 and later:

```text
Failed to load native library:sqlite-3.30.1-63e686c6-fc4b-46d5-bee9-6ac08b61d492-libsqlitejdbc.jnilib. osinfo: Mac/x86_64
java.lang.UnsatisfiedLinkError: /var/folders/dq/_vfds3wn0v34sh0sw_45dvn80000gn/T/sqlite-3.30.1-63e686c6-fc4b-46d5-bee9-6ac08b61d492-libsqlitejdbc.jnilib (dlopen(/var/folders/dq/_vfds3wn0v34sh0sw_45dvn80000gn/T/sqlite-3.30.1-63e686c6-fc4b-46d5-bee9-6ac08b61d492-libsqlitejdbc.jnilib, 1): no suitable image found.  Did find: 	/var/folders/dq/_vfds3wn0v34sh0sw_45dvn80000gn/T/sqlite-3.30.1-63e686c6-fc4b-46d5-bee9-6ac08b61d492-libsqlitejdbc.jnilib: code signature in (/var/folders/dq/_vfds3wn0v34sh0sw_45dvn80000gn/T/sqlite-3.30.1-63e686c6-fc4b-46d5-bee9-6ac08b61d492-libsqlitejdbc.jnilib) not valid for use in process using Library Validation: mapped file has no cdha)
SchemaCrawler 15.06.01

Error: org/sqlite/core/NativeDB._open_utf8([BI)V

Re-run SchemaCrawler with just the
-?
option for help

Or, re-run SchemaCrawler with an additional
-loglevel=CONFIG
option for details on the error
Apr 09, 2020 4:13:54 PM us.fatehi.commandlineparser.CommandLineUtility logSafeArguments
INFO: Environment:
SchemaCrawler 15.06.01
Mac OS X 10.15.4
Eclipse OpenJ9 Eclipse OpenJ9 VM 11.0.4+11

Apr 09, 2020 4:13:54 PM us.fatehi.commandlineparser.CommandLineUtility logSafeArguments
INFO: Command line:
-server
sqlite
-database
/tmp/database.db
-user
-password
*****
info
-command
schema
-outputformat
png
-outputfile
/tmp/diagram.png
Apr 09, 2020 4:13:54 PM us.fatehi.commandlineparser.CommandLineUtility logFullStackTrace
SEVERE: org/sqlite/core/NativeDB._open_utf8([BI)V
java.lang.UnsatisfiedLinkError: org/sqlite/core/NativeDB._open_utf8([BI)V
	at org.sqlite.core.NativeDB._open(NativeDB.java:78)
	at org.sqlite.core.DB.open(DB.java:195)
	at org.sqlite.SQLiteConnection.open(SQLiteConnection.java:243)
	at org.sqlite.SQLiteConnection.<init>(SQLiteConnection.java:61)
	at org.sqlite.jdbc3.JDBC3Connection.<init>(JDBC3Connection.java:28)
	at org.sqlite.jdbc4.JDBC4Connection.<init>(JDBC4Connection.java:21)
	at org.sqlite.JDBC.createConnection(JDBC.java:115)
	at org.sqlite.JDBC.connect(JDBC.java:90)
	at schemacrawler.tools.databaseconnector.BaseDatabaseConnectionOptions.getConnection(BaseDatabaseConnectionOptions.java:163)
	at schemacrawler.tools.databaseconnector.BaseDatabaseConnectionOptions.getConnection(BaseDatabaseConnectionOptions.java:104)
	at schemacrawler.tools.commandline.SchemaCrawlerCommandLine.execute(SchemaCrawlerCommandLine.java:119)
	at schemacrawler.Main.main(Main.java:92)
```

Install adoptopenjdk 8

```sh
brew cask install adoptopenjdk
brew tap AdoptOpenJDK/openjdk
# no-quarantine necessary to avoid because of (“adoptopenjdk-14.jdk” is damaged and can’t be opened.) solution found here:
# https://github.com/Homebrew/homebrew-cask/issues/79038
brew cask install adoptopenjdk/openjdk/adoptopenjdk8 --no-quarantine
```

Set JAVA_HOME:

```sh
JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
```

## Installing Schemacrawler as a command-line tool

With all dependencies ready, let's install the tool itself.

Heavily adapted from [here](https://gist.github.com/dannguyen/f056d05bb7fec408bb7c14ea1552c349), only updated to the latest version of SchemaCrawler.

```sh
#!/bin/bash
# set up some variables to reduce redundancy
_SCH_VERSION='15.06.01'
_SCH_BNAME="schemacrawler-${_SCH_VERSION}-distribution"
_SCH_TNAME="/tmp/${SCH_BNAME}.zip"
_SCH_URL="https://github.com/schemacrawler/SchemaCrawler/releases/download/v${_SCH_VERSION}/${_SCH_BNAME}.zip"
_SCH_DIR='/usr/local/opt/schemacrawler'
_SCH_SH="${_SCH_DIR}/schemacrawler-macos-opt.sh"
JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

INITIAL_DIR="$(pwd)"
# Download and unzip into /tmp
cd /tmp
curl -Lo ${_SCH_TNAME} ${_SCH_URL}
unzip ${_SCH_TNAME}

# Move subdir from release package into /usr/local/opt
mkdir -p ${_SCH_DIR}
cp -r /tmp/${_SCH_BNAME}/_schemacrawler/ ${_SCH_DIR}

# create the shell script manually
echo '#!/usr/bin/env bash' > ${_SCH_SH}
echo "SC_DIR=${_SCH_DIR}" >> ${_SCH_SH}
echo "java -cp \$(echo \$SC_DIR/lib/*.jar | tr ' ' ':'):\$SC_DIR/config schemacrawler.Main \"\$@\"" \
  >> ${_SCH_SH}

# make it executable and symlink it
chmod +x ${_SCH_SH}
ln -sf ${_SCH_SH} /usr/local/bin/schemacrawler  
cd "$INITIAL_DIR"
echo "done"
```

The latest releases can be found on the Github page [here](https://github.com/schemacrawler/SchemaCrawler/releases/).

## How to use

If you have an SQL script, you need to run it to create a database first:

```sh
rm -rf database.db
cat db.sql | sqlite3 database.db
```

Then, you run `schemacrawler` to generate a diagram of the database.

```sh
schemacrawler -server sqlite \
  -database database.db \
  -user -password \
  -infolevel standard \
  -command schema \
  -outputformat png \
  -loglevel INFO \
  -outputfile OUTPUT_IMAGE_FILE.png
```

## Changing how the diagrams look by editing the behaviour of SchemaCrawler

You can change the look of the diagrams generated by SchemaCrawler by editing its properties. Just edit `/usr/local/opt/schemacrawler/config/schemacrawler.config.properties`.

```config

schemacrawler.format.no_schemacrawler_info=true
schemacrawler.format.show_database_info=true
schemacrawler.format.show_row_counts=true
schemacrawler.format.identifier_quoting_strategy=quote_if_special_characters

schemacrawler.graph.graphviz.nodes.ranksep=circo
schemacrawler.graph.graphviz.graph.layout=circo
schemacrawler.graph.graphviz.graph.splines=ortho


schemacrawler.graph.graphviz.node.shape=folder
schemacrawler.graph.graphviz.node.style=rounded,filled
schemacrawler.graph.graphviz.node.fillcolor=#fcfdfc
#schemacrawler.graph.graphviz.node.color=red

schemacrawler.graph.graphviz.graph.fontname=Helvetica Neue
schemacrawler.graph.graphviz.node.fontname=Consolas
schemacrawler.graph.graphviz.edge.fontname=Consolas
schemacrawler.graph.graphviz.edge.arrowsize=1.5
```
### Changing diagram settings for a single diagram

You can place a `schemacrawler.config.properties` file in the folder where you run schemacrawler to override certain settings only. Here is an example I made:

```properties
schemacrawler.schema.retrieval.strategy.primarykeys=dictionary
schemacrawler.format.show_row_counts=true
schemacrawler.format.show_ordinal_numbers=true
schemacrawler.graph.graphviz.graph.fontname=Arial
````

## BONUS! Example of a script for generating diagrams

This script was used by me for generating diagrams from the SQL scripts written by my students of Databases in the 2nd year of the Integrated Masters of Informatics Engineering at FEUP.

```shell
#!/usr/bin/env bash

JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

function diagram
{
    local database="$(pwd)/$1"
    echo "database is $database"
    local path="$(pwd)/$2"
    echo "path is $path"
    /bin/cp "$database" "/tmp/database.db"
    /bin/ls -la "/tmp/database.db"
    /bin/bash -c '/usr/local/bin/schemacrawler -server sqlite -database /tmp/database.db -user -password -loglevel info -command schema -outputformat png -outputfile /tmp/diagram.png'
    /bin/cp "/tmp/diagram.png" "$path"
}

rm -rf database.db
cat criar.sql | sqlite3 database.db && \
	echo "Cria BD" && \
cat povoar.sql | sqlite3 database.db && \
	echo "Povoa BD"
read WAIT
diagram database.db diagram.png

```

### New version that runs queries and triggers also (Delivery 3)

```shell
#!/usr/bin/env bash

JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

function faz_diagrama
{
	local database="$(pwd)/$1"
	echo "database is $database"
	local path="$(pwd)/$2"
	echo "path is $path"
	/bin/rm "/tmp/diagram.pdf"
	/bin/cp "$database" "/tmp/database.db"
	/bin/ls -la "/tmp/database.db"
	/bin/bash -c '/usr/local/bin/schemacrawler -server sqlite -database /tmp/database.db -user -password -loglevel info -command schema -outputformat pdf -outputfile /tmp/diagram.pdf'
	/bin/cp "/tmp/diagram.pdf" "$path"
}

function existe()
{
	local ficheiro=$1
	[ -f "$ficheiro" ] || (echo "Ficheiro $ficheiro não existe!" && read ERROR)
}

function corre_queries
{
	for (( i = 1; i <= 10; i++ )); do
		local file_path="./int${i}.sql"
		printf "\n---------Ficheiro Query ${file_path}---------\n\n"
		existe "$file_path" && \
			cat "$file_path" | sqlite3 database.db || (echo "Erro a correr query ${i}" && read ERROR)
	done
}

function testa_triggers
{
	for (( i = 1; i <= 3; i++ )); do
		local file_path="./gatilho${i}_XXXXXX.sql"
		printf "\n---------Ficheiro Gatilho ${file_path}---------\n\n"

		( existe "./gatilho${i}_adiciona.sql" || existe "./gatilho${i}_verifica.sql" ] || existe "./gatilho${i}_remove.sql" ) && \
			cat "./gatilho${i}_adiciona.sql" | sqlite3 database.db && \
				cat "./gatilho${i}_verifica.sql" | sqlite3 database.db && \
					cat "./gatilho${i}_remove.sql" | sqlite3 database.db || (echo "Erro a correr trigger ${i}" && read ERROR)
	done
}

rm -rf database.db
cat criar.sql | sqlite3 database.db && \
echo "Cria BD" && \
cat povoar.sql | sqlite3 database.db && \
echo "Povoa BD"
echo "Pressione qq tecla..."
read WAIT

corre_queries && \
echo "Corre Queries Corretamente"
read WAIT
echo "Pressione qq tecla..."

testa_triggers && \
echo "Corre Triggers Corretamente"
read ERROR

faz_diagrama database.db diagram.pdf
```

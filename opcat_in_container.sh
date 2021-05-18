#!/bin/sh

# Some wrangling to make the local and dockerized executable work the same way

# we only know the user at runtime based on the env var set in opcat.sh
# set up now, better late than never
mkdir -p /Users/$USER
DOC_DIR=/Users/$USER/Documents

# a symlink already exists in the container for /documents/conf.txt
# so now we symlink the directory that contains it...
ln -s /documents $DOC_DIR

# symlink the license file to the home dir, because that will be our working dir
# and make it our working dir
ln -s /opcat/license.lic $HOME/
cd $HOME
ln -s $DOC_DIR/conf.txt $HOME/

/usr/local/openjdk-8/bin/java -jar -Xmx1024m -Dopcat.home="/opcat" -jar /opcat/OPCAT.jar

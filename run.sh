#!/bin/bash

set -e

chown -R mongodb:mongodb /var/lib/mongodb

if [ ! -f /.mongodb_password_set ]; then
	echo "Found no /.mongodb_password_set"
	/set_mongodb_password.sh
fi
if [ ! -f /var/lib/mongodb/mongod.lock ]; then
exec sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --httpinterface --rest --nojournal --auth --smallfiles
else
rm /var/lib/mongodb/mongod.lock
mongod --dbpath /var/lib/mongodb --repair && exec sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --httpinterface --rest --nojournal --auth --smallfiles --dbpath /var/lib/mongodb
fi


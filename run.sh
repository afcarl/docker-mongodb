#!/bin/bash

set -e

chown -R mongodb:mongodb /data/db

if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi
if [ ! -f /data/db/mongod.lock ]; then
exec sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --httpinterface --rest --nojournal --auth --smallfiles
else
rm /data/db/mongod.lock
mongod --dbpath /data/db --repair && exec sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --httpinterface --rest --nojournal --auth --smallfiles --dbpath /data/db
fi


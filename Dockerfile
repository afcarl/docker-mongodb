FROM ubuntu:14.04
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
 && echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' > /etc/apt/sources.list.d/mongodb.list \
 && apt-get update \
 && apt-get install -y mongodb-org-server pwgen \
 && sed 's/^bind_ip/#bind_ip/' -i /etc/mongod.conf \
 && rm -rf /var/lib/apt/lists/* # 20140918


# Add run scripts
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 ./*.sh

EXPOSE 27017
EXPOSE 28017
VOLUME ["/var/lib/mongodb"]
CMD ["/run.sh"]

FROM ubuntu:16.04
MAINTAINER Jordi Prats

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install tzdata -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install locales -y

#
# timezone and locale
#
RUN echo "Europe/Andorra" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

#
# paquets base
#

RUN DEBIAN_FRONTEND=noninteractive apt-get install git -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install puppet -y

#
# puppet masterless
#

RUN mkdir -p /opt/puppet-masterless
RUN git clone https://github.com/jordiprats/puppet-masterless /opt/puppet-masterless

RUN mkdir -p /opt/masterless-data
COPY redis.pp /opt/masterless-data


#
# publish
#

VOLUME ["/var/lib/redis-6380"]

EXPOSE 6380

FROM fedora
MAINTAINER Maciej Lasyk <maciek@lasyk.info>

RUN yum -y update; yum -y install nginx; yum clean all
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 8002
CMD [ "/usr/sbin/nginx" ]
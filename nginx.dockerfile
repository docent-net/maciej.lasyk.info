FROM fedora:24
MAINTAINER Maciej Lasyk <maciek@lasyk.info>

RUN dnf -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 8002
CMD [ "/usr/sbin/nginx" ]
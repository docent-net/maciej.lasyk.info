FROM fedora:26
MAINTAINER Maciej Lasyk <maciek@lasyk.info>

RUN dnf -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
CMD [ "/usr/sbin/nginx" ]

FROM debian:jessie

MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

ENV REFRESHED_AT 2015-10-08

RUN apt-get update && \
    apt-get install -y curl && \
    curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo 'deb http://nginx.org/packages/debian/ jessie nginx' > /etc/apt/sources.list.d/nginx.list && \
    apt-get -y -q install nginx && \
    mkdir -p /var/www/html/site &&
    chown -R www-data:www-data /var/lib/nginx

VOLUME ["/var/www/html/site"]

ADD conf/global.conf /etc/nginx/conf.d/
ADD conf/nginx.conf /etc/nginx/

# USER root
EXPOSE 80
EXPOSE 443
CMD ["nginx"]

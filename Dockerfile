FROM alpine:latest

MAINTAINER NEGRO, Eric <yogo95@zrim-everything.eu>

RUN apk --no-cache add pdns pdns-backend-pgsql pdns-doc

#
# ##################################################
#

EXPOSE 53 53/udp 8081

#
# ##################################################
#

CMD ["/usr/sbin/pdns_server"]

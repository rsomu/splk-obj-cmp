FROM golang:alpine 
ARG OBJSYNC_VERSION="1.0.0"

RUN apk add git 
RUN go get github.com/peak/s5cmd

RUN apk update && apk add bash
RUN mkdir /root/.aws

COPY ./*.sh /usr/bin/
RUN chmod +x /usr/bin/*.sh
CMD ["/usr/bin/objdiff.sh"]

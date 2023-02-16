FROM golang:1.19.2-alpine3.16 AS builder
LABEL maintainer "stream2me@github"
RUN apk add --no-cache git
RUN git clone https://github.com/mosajjal/sniproxy /app 
WORKDIR /app
ENV CGO_ENABLED=0
RUN go build -o main . 
CMD ["/app/main"]

FROM alpine:latest
RUN mkdir -p /app/config
COPY --from=builder /app/main /app/sniproxy
#WORKDIR /app 
#ADD run.sh /app
#CMD sh /app/run.sh 
CMD /app/sniproxy -c /app/config/config.json


##FROM alpine:latest
##LABEL maintainer "stream2me@github"
##RUN apk add --no-cache curl
##RUN mkdir -p /app/config
##WORKDIR /app 

##RUN curl -sL $(curl -s https://api.github.com/repos/mosajjal/sniproxy/releases/latest | grep browser_download_url | cut -d\" -f4 | egrep linux.*amd$(getconf LONG_BIT).tar.gz$) | tar zx
##ADD run.sh /app
##CMD sh run.sh

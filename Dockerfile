#FROM golang:onbuild
LABEL maintainer="mohsinsaeed_7@outlook.com"
FROM golang:alpine3.13
RUN addgroup -S remote && adduser -S remoteuser -G remote
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main .
USER remoteuser
CMD ["/app/main"]
EXPOSE 8080

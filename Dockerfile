#FROM golang:onbuild
FROM golang:alpine3.13
LABEL maintainer="mohsinsaeed_7@outlook.com"
RUN addgroup -S remote && adduser -S remoteuser -G remote
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main .
USER remoteuser
CMD ["/app/main"]
EXPOSE 8080

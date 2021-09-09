#FROM golang:onbuild
FROM golang:alpine3.13
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main .
CMD ["/app/main"]
EXPOSE 8080

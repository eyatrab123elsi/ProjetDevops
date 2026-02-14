FROM alpine
LABEL author="Eya Trabelsi"
RUN apk update && apk add openjdk11
CMD ["java","-version"]

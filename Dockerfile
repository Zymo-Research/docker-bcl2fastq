FROM alpine:3.10

MAINTAINER Mingda Jin

WORKDIR /tmp

# anyone knows how to install mcheck.h gracefully on Alpine?
COPY mcheck.h /usr/include/

RUN apk --no-cache add \
      alpine-sdk \
      bash \
      zlib-dev \
      libstdc++ \
 && wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip \
 && unzip bcl2fastq2-v2-20-0-tar.zip \
 && tar xzvf bcl2fastq2-v2.20.0.422-Source.tar.gz \
 && ./bcl2fastq/src/configure --prefix=/usr/local/ \
 && make \
 && make install \
 && rm -r /tmp/* \
 && rm /usr/include/mcheck.h \
 && apk --no-cache del \
      alpine-sdk \
      bash \
      zlib-dev

WORKDIR /

ENTRYPOINT ["bcl2fastq"]

CMD ["--version"]
